-----------------------------------------------------------------------------------
-- 계층 검색
-----------------------------------------------------------------------------------
-- 브레드 컬럼 빵조각을 찾아가듯이
/*
    - 계층관계에 있는 행들을 그 관계를 고려해서 조회하는 검색이다.
    - 형식
        select level, 컬러명, 컬럼명, ...
        from 테이블
        start with 컬럼명 = 값
        connect by prior 컬럼명 = 컬러명
        
        *level : 계층관계에서의 depth를 반환하는 값이다. 
                 시작행이 1이고, 그다음 depth부터 1씩 증가된 값을 반환한다.
        * start with : 계층검색 시작 행을 조건식으로 표현한다.
        * connect by : 계층검색의 방향을 지정한다.
            상위행에서 하위행으로 검색
                connect by proir 부모키컬럼(프라이머리키, 유니크) = 자식컬럼(외래키컬럼)
            하위행에서 상위행으로 검색
                connect by proir 자식컬럼(외래키컬럼) = 부모키컬럼(프라이머리키, 유니크)
    
                * 부모키컬럼은 자식테이블에서 외래키로 참조하는 기본키 컬럼이다.
                * 자식키컬럼은 기본키를 참조하는 외래키 컬럼이다.
*/
select level, employee_id, manager_id, lpad(' ', level*2, ' ') || first_name
from employees
start with employee_id = 100
connect by prior  employee_id = manager_id;

select level, employee_id, manager_id, first_name
from employees
start with employee_id = 112
connect by prior  manager_id = employee_id
order by level desc;

-----------------------------------------------------------------------------------
-- connect by level로 연속된 값 조회하기
-----------------------------------------------------------------------------------

-- 1부터 10까지 1씩 증가하는 값을 조회하기
select level
from dual
connect by level <= 10;

-- 1부터 10까지 2씩 증가하는 값을 조회하기
select level*2
from dual
connect by level <= 10;

-- 초기값을 지정해서 1씩 증가하는 값을 조회하기
select level + 10
from dual
connect by level <= 10;

--------------------------------------------------------------------------------------
-- 2004년 월별 입사자 수 조회 (입사한 직원이 있는 경우에만 조회)
select to_char(hire_date, 'MM') month, count(*) cnt
      from employees
      where hire_date >= '2004/01/01' and hire_date < '2005/01/01'
      group by to_char(hire_date, 'MM')
order by 1;

-- 1~ 12까지 연속적인 값을 조회하기
select lpad(level, 2, '0') month
    from dual
    connect by level <= 12;
    
-- 2004년 월별 입사자 수 조회
with months
as (select lpad(level, 2, '0') month
    from dual
    connect by level <= 12)
select m.month, c.cnt
from (select to_char(hire_date, 'MM') month, count(*) cnt
      from employees
      where hire_date >= '2004/01/01' and hire_date < '2005/01/01'
      group by to_char(hire_date, 'MM')) c, months m
where c.month(+) = m.month
order by m.month;

select to_date('2023/04/01') + level - 1
from dual
connect by level <= to_date('2023/04/25') - to_date('2023/04/01') +1;
