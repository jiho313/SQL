/*
is not null과 is null
    - 컬럼의 값이 null인지 여부를 판단해서 true, false 값을 반환하는 연산자.
    - 형식
        select 컬럼명, 컬럼명
        from 테이블명   
        where 컬럼명 = null;    <--- 지정된 컬럼의 값이 null인 행을 조회한다.(정상동작하지 않음)
        * 조회결과가 없다.
        
        select 컬럼명, 컬럼명
        from 테이블명
        where 컬럼명 != null;   <--- 지정된 컬럼의 값이 null이 아닌 행을 조회한다.(정상동작하지 않음
        * 조회결과가 없다.
        
        -- 지정된 컬럼의 값이 null인 행을 조회한다.
        select 컬럼명, 컬럼명
        from 테이블명   
        where 컬러명 is null;   

        -- 지정된 컬럼의 값이 null이 아닌 행을 조회한다.
        select 컬럼명, 컬럼명
        from 테이블명   
        where 컬러명 is not null;   

*/
-- employees 테이블에서 소속부서가 결정되지 않은 직원의 아이디, 이름을 조회하기
select employee_id, first_name
from employees
where department_id is null;

-- departments 테이블에서 부서 담당자가 없는 부서의 아이디, 부서이름 조회하기
SELECT department_id, department_name
from departments
where manager_id is null;

-- employees 테이블에서 커미션을 받는 직원의 아이디, 이름, 급여, 커미션 지급률 조회하기
select employee_id, first_name, salary, COMMISSION_PCT
from employees
where COMMISSION_PCT is not null;

select count(*)
from employees;























