-- employees 테이블에서 사원들의 모든 업무아이디를 조회하기
select employee_id, job_id
from employees;

-- 급여를 12,000달러 이상 받는 사원의 이름과 급여를 조회하기
select first_name, salary
from employees
where salary > 12000;

-- 사원번호가 176번 사원의 아이디와 이름 직종을 조회하기
select employee_id, first_name, job_id
from employees
where employee_id = 176;

-- 급여를 12,000달러 이상 15,000달러 이하 받는 사원들의 사원 아이디와 이름과 급여를 조회하기
select employee_id, first_name, salary
from employees
where salary >= 12000 and salary <= 15000;

-- 2005년 1월 1일부터 2000년 6월 30일 사이에 입사한 사원의 아이디, 이름, 업무아이디, 입사일을 조회하기
select employee_id, first_name, job_id, hire_date
from employees
where hire_date >= '2005/01/30' and hire_date <= '2005/06/30';

-- 급여가 5,000달러와 12,000달러 사이이고, 부서번호가 20 또는 50인 사원의 이름과 급여를 조회하기
select first_name, salary
from employees
where salary >= 5000 and salary <= 12000
and department_id in (20, 50);

-- 관리자가 없는 사원의 이름과 업무아이디를 조회하기
select first_name, job_id
from employees
where manager_id is null;

-- 커미션을 받는 모든 사원의 이름과 급여, 커미션을 급여 및 커미션의 내림차순으로 정렬해서 조회하기
select first_name, salary, commission_pct
from employees
where commission_pct is not null
order by salary desc;

select first_name, salary, commission_pct
from employees
where commission_pct is not null
order by commission_pct desc;

-- 이름의 2번째 글자가 e인 모든 사원의 이름을 조회하기
select first_name
from employees
where substr(first_name, 2, 1) = 'e';

-- 업무아이디가 ST_CLERK 또는 SA_REP이고 급여를 2,500달러, 3,500달러, 7,000달러 받는 모든 사원의 이름과 업무아이디, 급여를 조회하기
select first_name, job_id, salary
from employees
where job_id in ('ST_CLERK', 'SA_REP')
and salary in (2500, 3500, 7000);

-- 모든 사원의 이름과 입사일, 근무 개월 수를 계산하여 조회하기, 근무개월 수는 정수로 반올림하고, 근무개월수를 기준으로 오름차순으로 정렬하기
select first_name, hire_date, round(months_between(sysdate, hire_date)) as 근무개월수
from employees
order by 근무개월수 asc;

-- 모든 사원의 이름, 부서번호, 부서이름을 조회하기
select e.first_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

-- 80번부서에 소속된 사원의 이름과 업무아이디, 업무제목, 부서이름을 조회하기
select e.first_name, e.job_id, j.job_title, d.department_name
from employees e, jobs j, departments d
where e.department_id = 80
and e.department_id = d.department_id
and e.job_id = j.job_id;

-- 커미션을 받는 모든 사원의 이름과 업무아이디, 업무제목, 부서이름, 부서소재지 도시명을 조회하기
select e.first_name, e.job_id, j.job_title, d.department_name, l.city
from employees e, jobs j, departments d, locations l
where e.commission_pct is not null
and e.department_id = d.department_id(+)
and e.job_id = j.job_id(+)
and d.location_id = l.location_id(+);

-- 유럽에 소재지를 두고 있는 모든 부서아이디와 부서이름을 조회하기
select d.department_id, d.department_name
from departments d, locations l, countries c, regions r
where r.region_name = 'Europe'
and r.region_id = c.region_id
and c.country_id = l.country_id
and l.location_id = d.location_id;

-- 사원의 이름과 소속부서명, 급여, 급여 등급을 조회하기
select first_name, department_name, salary, g.grade
from employees e, departments d, salary_grades g
where e.department_id = d.department_id(+)
and e.salary >= g.min_salary and e.salary <= g.max_salary;

-- 사원의 이름과 소속부서명, 소속부서의 관리자명을 조회하기, 소속부서가 없는 사원은 소속부서명 '없음, 관리자명 '없음'으로 표시하기
select e.first_name, nvl(d.department_name, '없음' ) 소속부서, nvl(dm.first_name, '없음') 관리자명
from employees e, departments d, employees dm
where e.department_id = d.department_id(+)
and e.manager_id = dm.employee_id(+);

-- 모든 사원의 급여 최고액, 급여 최저액, 급여 총액, 급여 평균액을 조회하기
select max(salary), min(salary), sum(salary), avg(salary)
from employees;

-- 업무별 급여 최고액, 급여 최저액, 급여 총액, 급여 평균액을 조회하기
select job_id, max(salary), min(salary), sum(salary), avg(salary)
from employees 
group by job_id;

-- 각 업무별 사원수를 조회해서 가장 사원수가 많은 업무 3개를 조회하기, 업무아이디와 사원수 표시하기
-- rank() 동일한 값일 때는 동일한 순위를 부여받기 때문에 해당 예문에는 적합하지 않다.
select ranking, job_id, emp_count 
from (select dense_rank() over(order by emp_count desc)ranking,
      job_id, emp_count
      from (select job_id, count(*)emp_count
            from employees 
            group by job_id))
where ranking >= 1 and ranking <= 3;

-- 행마다 다른 순위를 부여받기 때문에 예제와 적합하다.
select emp_row, job_id, emp_count
from (select row_number() over(order by emp_count desc)emp_row,
      job_id, emp_count
      from (select job_id, count(*) emp_count
            from employees 
            group by job_id))
where emp_row <= 3;
