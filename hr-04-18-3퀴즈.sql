--------------------------------------------------------------------------------------------
-- 퀴즈
--------------------------------------------------------------------------------------------

--부서테이블의 모든 부서 정보를 조회하기
select *
from departments;

select department_id, department_name, manager_id, location_id
from departments;

--부서테이블에서 위치아이디가 1700번이 아닌 부서 정보 조회하기
select department_id, department_name, manager_id, location_id
from departments
where location_id != 1700;

-- 오라클 한정 <> 부정 연산자
select department_id, department_name, manager_id, location_id
from departments
where location_id <> 1700;

--100사원이 관리하는 부서의 정보 조회하기
select department_id, department_name, manager_id, location_id
from departments
where manager_id = 100;


--부서명이 'IT'인 부서의 정보 조회하기
select department_id, department_name, manager_id, location_id
from departments
where department_name = 'IT';


--위치아이디가 1700번인 지역의 주소, 우편번호, 도시명, 국가코드를 조회하기
select street_address, postal_code, city, country_id, location_id
from locations
where location_id = 1700;

--최소급여가 2000이상 5000이하인 직종의 직종아이디, 직종제목, 최소급여, 최대급여 조회하기
select job_id, job_title, min_salary, max_salary
from jobs
where min_salary >= 2000 and min_salary <= 5000;


--최대급여가 20000불을 초과하는 직종의 아이디, 직종제목, 최소급여, 최대급여 조회하기
select job_id, job_title, min_salary, max_salary
from jobs
where max_salary > 20000;

--100번 관리자 직원에게 보고하는 사원의 아이디, 이름, 부서아이디을 조회하기
select employee_id, first_name, department_id, manager_id
from employees
where manager_id = 100;

--80번 부서에서 근무하고 급여를 8000불 이상 받는 사원의 아이디, 이름, 급여, 커미션포인트 조회하기
select employee_id, first_name, salary, commission_pct
from employees
where department_id = 80;

--직종이 SA_REP이고, 커미션포인트가 0.25이상인 사원의 아이디, 이름, 급여, 커미션포인트를 조회하기
select employee_id, first_name, salary, commission_pct
from employees
where job_id = 'SA_REP' and commission_pct > 0.25;

--80번 부서에 근무하고, 급여가 10000불 이상인 사원의 아이디, 이름, 급여, 연봉을 조회하기
--연봉 = (급여 + 급여x커미션)x12다
select employee_id, first_name, salary, ((salary + salary * commission_pct)*12) as "연봉"
from employees
where department_id = 80 and salary > 10000;

--80번 부서에 근무하고, 147번 직원에게 보고하는 사원 중에서 커미션이 0.1인 사원의 사원아이디, 이름, 직종, 급여, 커미션포인트를 조회하기
select employee_id, first_name, job_id, salary, commission_pct, manager_id
from employees
where department_id = 80 and manager_id != 147 and commission_pct = 0.1;

--사원들이 수행하는 직종을 중복없이 조회하기
select DISTINCT job_id
from employees;

--사원들이 소속된 부서아이디를 모두 조회하기
select distinct department_id
from employees
where department_id is not null;

--급여가 5,000달러와 12,000달러 사이이고, 부서번호가 20 또는 50인 사원의 이름과 급여를 조회하기
select employee_id, salary
from employees
where salary between 5000 and 12000 and department_id in (20, 50);

--직종이 'SA_MAN'이거나 'ST_MAN'인 직원중에서 급여를 8000이상 받는 사원의 아이디, 이름, 직종, 급여를 조회하기
select employee_id, first_name, job_id, salary
from employees
where job_id in ('SA_MAN', 'ST_MAN') and salary >= 8000;