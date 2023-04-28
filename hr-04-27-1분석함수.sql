-------------------------------------------------------------------------------------------
-- top-n 분석
-------------------------------------------------------------------------------------------

-- 급여를 가장 많이 받는 직원 1 ~ 5위 해당하는 직원의 아이디, 이름, 급여를 조회하기
-- rownum이 셀렉트절과 웨얼절에 같은 것을 나타내는 것은 아니다.
select rownum, employee_id, first_name, salary
from (select employee_id, first_name, salary
      from employees
      order by salary desc)
where rownum <= 5;

-- 급여를 가장 많이 받는 직원 6 ~ 10위 해당하는 직원의 아이디, 이름, 급여를 조회하기
-- top에서 부터 결과를 조회하기 때문에 결과가 나오지 않는다. 
select rownum, employee_id, first_name, salary
from (select employee_id, first_name, salary
      from employees
      order by salary desc)
where rownum >= 6 and rownum <= 10;

-- 급여를 가장 많이 받는 직원 6 ~ 10위 해당하는 직원의 아이디, 이름, 급여를 조회하기
-- 가상의 테이블을 만들고 rownum에 별칭을 부여한 후 where절에 조건을 입력해서 조회한다.
select rn, employee_id, first_name, salary
from (select rownum as rn, employee_id, first_name, salary
        from (select employee_id, first_name, salary
              from employees
              order by salary desc))
where rn >= 6 and rn <= 10;

-------------------------------------------------------------------------------------------
-- 오라클의 분석함수
-------------------------------------------------------------------------------------------
/*
분석함수
    - 테이블에 있는 데이터를 특정 용도로 분석하여 결과를 반환하는 함수
    - 복잡한 계산을 단순하게 처리해주는 함수
    - select절에서 실행된다.
    - 형식
        select 분석함수(인자)
                over (
                     [partition by 컬럼명, 컬러명, ...]
                     [order by 컬럼명, 컬럼명, ...]
                )
        from 테이블명;
        * 분석함수(인자) : 사용할 분석함수의 이름, 인자에는 분석대상이되는 컬럼명 혹은 표현식
        * over : 분석함수임을 나타내는 키워드다.
        * partition by : 계산대상 그룹을 지정한다.
        * order by : 계산대상 그룹에 대한 정렬을 수행한다.
        
    - 분석함수의 종류
        * 순위함수 : rank, dense_rank, row_number
        * 집계함수 : sum, min, max, avg, count
*/

-------------------------------------------------------------------------------------------
-- row_number()
-- rownum 의사컬럼과 비슷한 기능을 수행한다.
-- 파티션으로 분할된 그룹별로 각 로우에 대한 순번을 반환하는 함수다.
-------------------------------------------------------------------------------------------

-- 급여가 높은순으로 정렬해서 순번이 포함된 데이터를 조회한다.
select row_number() over (order by salary desc)emp_row,
       employee_id first_name, salary
from employees;

-- 부서별로 나눠서 급여가 높은순으로 정렬해서 순번이 포함된 데이터를 조회한다.
select row_number() over(PARTITION by department_id
                         order by salary desc)emp_row,
       department_id, employee_id, first_name, salary
from employees;

-- 부서별로 나눠서 급여를 높은 순으로 정렬했을 때 가장 많이 받는 3명을 조회한다.
select emp_row, department_id, employee_id, salary
from (select row_number() over(PARTITION by department_id
                         order by salary desc)emp_row,
       department_id, employee_id, first_name, salary
        from employees)
where emp_row <= 3;

-- 부서별로 나눠서 급여를 높은 순으로 정렬했을 때 가장 많이 받는 직원을 조회한다.
select emp_row, department_id, employee_id, salary
from (select row_number() over(PARTITION by department_id
                          order by salary desc)emp_row,
       department_id, employee_id, first_name, salary
        from employees)
where emp_row <= 1;

-- 직원들의 아이디를 기준으로 낮은 순으로 정렬했을 때 11~20번째 직원을 조회하기
-- 많이 볼 쿼리, 해당하는 페이지에 일정한 갯수의 상품을 뿌릴 때
select emp_row, employee_id, first_name
from (select row_number() over (order by employee_id asc)emp_row,
            employee_id, first_name
            from employees)
where emp_row >= 11 and emp_row <= 20;
-------------------------------------------------------------------------------------------
-- 랭크, 
-- 순위 반환 함수
-------------------------------------------------------------------------------------------
select rank() over(order by salary desc) ranking,
        employee_id, first_name, salary
from employees;

select dense_rank() over(order by salary desc) ranking,
        employee_id, first_name, salary
from employees;

-------------------------------------------------------------------------------------------
-- cume_dist() percent_rank
-- 주어진 그룹에 대한 상대적인 누적분포도 값 반환
-- 주어진 그룹에 대한 백분위 순위 반환
-------------------------------------------------------------------------------------------
-- 부서별로 그룹을 나누고, 급여순으로 정렬했을 때 해당 부서에서 해당 급여의 상대적인 누적분포도를 조회
select department_id, employee_id, salary,
     trunc(cume_dist() over (partition by department_id
                     order by salary),2) dept_dist
from employees;
-------------------------------------------------------------------------------------------
-- 그룹함수와 분석함수
-------------------------------------------------------------------------------------------

-- sum()을 그룹함수로 사용하기
-- 집합그룹당 결과가 하나 조회된다.

-- 테이블이 집합그룹이기 때문에 결과가 하나 조회된다.
select sum(salary)
from employees;

-- 부서아이디별로 그룹핑 했기 때문에 부서마다 결과가 하나 조회된다.
select department_id, sum(salary)
from employees
group by department_id
order by department_id;

-- sum()을 분석함수로 사용하기
-- 모든 행마다 분석함수 결과가 조회된다.

select department_id, employee_id, first_name, salary, 
        sum(salary) over() -- 파티션을 구분하지 않았기 때문에 급여 총합이 집계된다.
from employees;

select department_id, employee_id, first_name, salary, 
        sum(salary) over (partition by department_id)dept_salary
from employees;

-- 부서별 급여 총합을 집계했을 때, 해당 직원의 급여 비율을 조회하기
select department_id, employee_id, first_name, salary, round(salary/dept_salary, 2)
from(select department_id, employee_id, first_name, salary,
        sum(salary) over (partition by department_id)dept_salary
        from employees);


--------------------------------------------------------------------------------------
-- 페이징 처리와 순위함수
--------------------------------------------------------------------------------------
/*
    - 한 화면에 표시할 데이터 행의 갯수
        int rows = 10;
    - 요청한 페이지 번호
        int pageNo = 1;
    - 전체 데이터행의 갯수
        int totalRows =107;
    - 전체 페이지갯수
        int totalPages =(int) Math.ceil((double)totalRows/rows)
        
    -- 요청한 페이지의 시작 인덱스와 끝 인덱스
        int beginIndex = (pageNo - 1)*rows +1;
        int endIndex = pageNo*rows;
        
        
    select no, title, maker, price
    from (select row_number() over (order by no desc)row_num, 
                  no, title, maker, price ....
          from products)
    where row_num >= ? and row_num <= ?;

*/


