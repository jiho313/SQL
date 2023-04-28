-- 그룹 바이 절에 등장한 것을 셀렉트 절에 적을 수 있다.
-- 통계작업시 사용 분기별 매출, 월별 매출, 상품별 매출
select job_id, avg(salary)
from employees
group by job_id;

-------------------------------------------------------------------------------------------
-- 그룹함수
-------------------------------------------------------------------------------------------
/*
    count(*)
        조회된 모든 행의 갯수를 반환한다.
        
    count(컬럼명)
        지정된 컬럼의 값이 null이 아닌 행의 갯수를 반환한다.
    
    count(distinct 컬럼명)
        지정된 컬럼에 대해서 중복된 행을 한번만 포함한 행의 갯수를 반환한다.
*/

-- employees 테이블에 등록된 모든 직원수를 조회하기
select count(*)
from employees;

-- employees 테이블에서 커미션을 받은 직원수를 조회하기
select count(commission_pct) -- commission_pct 컬럼의 값이 null이 아닌 행의 수를 센다.
from employees;

-- employees 테이블에서 직원들이 종사하고 있는 총 직종의 수를 죄회하기
select count(distinct job_id)
from employees;



/*
    min(컬럼명)
        지정된 행의 최소값을 반환한다.
    max(컬럼명)
        지정된 행의 최대값을 반환한다.
    sum(컬럼명)
        지정된 행의 합계를 반환한다.
    avg(컬럼명)
        지정된 행의 평균을 반환한다.
*/

select avg(commission_pct)
from employees;

-- 직원 테이블에서 최소급여, 최대급여, 급여합계, 급여평균을 조회하기
select min(salary), max(salary), sum(salary), avg(salary)
from employees;

-- 직원 테이블에서 커미션을 받지 못하는 직원의 수를 조회하기
select count(*)
from employees
where commission_pct is null;

-- 직원 테이블에서 급여등급이 'D'인 직원의 수를 조회하기
select count(*)
from employees e, salary_grades g
where e.salary >= g.min_salary
and e.salary <= g.max_salary
and g.grade = 'D';

-------------------------------------------------------------------------------------------
-- group by절을 이용해서 집합그룹 생성하고, 그룹함수 적용하기
-------------------------------------------------------------------------------------------

-- 부서별 사원수를 조회하기
select department_id, count(*)
from employees
GROUP by department_id
order by 1;

-- 직종별 사원수를 조회하기
select job_id, count(*)
from employees
GROUP by job_id
order by 1;

-- 입사년도별 사원수를 조회하기
select to_char(hire_date, 'YYYY'), count(*)
from employees
GROUP by to_char(hire_date, 'YYYY')
order by 1;

-- 급여 액수별 사원수를 조회하기
SELECT trunc(salary, -3), count(*)
from employees
GROUP by trunc(salary, -3)
order by 1;

-- 부서별, 직종별 사원수를 조회하기
SELECT department_id, job_id, count(*)
from employees
GROUP by department_id, job_id
order by 1, 2;

-- 부서별 사원수를 집계했을 때, 사원수가 30명 이상인 부서의 아이디와 사원수를 조회하기
select department_id, count(*)
from employees
GROUP by department_id
having count(*) >= 30
order by 1;

-- with절을 이용해서 조회결과를 캐싱하기
with emp_count
as (select department_id, count(*) as cnt
    from employees
    group by department_id)
select department_id, cnt
from emp_count
where cnt >= 30;

-- 2005년 이후에 입사한 직원들을 부서별로 사원수를 조회했을 때, 직원수가10명 이상인
-- 부서의 아이디와 사원수를 조회하기
select department_id, count(*)
from employees
where hire_date >= '2006/01/01'
group by department_id
having count(*) >= 10;










