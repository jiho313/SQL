-- 급여를 가장 많이 받는 직원의 아이디, 이름, 직종, 급여를 조회하기
select employee_id, first_name, job_id, salary
from employees
where salary >= (select max(salary)
                from employees);

-- 급여를 가장 적게 받는 지원의 아이디, 이름, 직종, 급여, 급여 등급을 조회하기
select e.employee_id, e.first_name, e.job_id, e.salary, g.grade
from employees e, salary_grades g
where e.salary >= g.min_salary and e.salary <= g.max_salary 
and salary <= (select min(salary)
                 from employees);

-- 급여를 금액대별로 분류했을 때 각 금액대별 직원수를 조회하기
-- 금액대는 2000, 3000, 4000, 5000과 같이 백의 자리값을 버리면 된다.
select trunc(salary, -3), count(*)
from employees
group by trunc(salary, -3)
order by 1;

-- 80번 부서에 근무하고, 80번 부서의 최저급여를 받는 사원의 아이디, 이름, 직종, 급여, 부서아이디를 조회하기
select employee_id, first_name, job_id, salary, department_id
from employees
where department_id = 80 
and salary in (select min(salary)
                 from employees
                 where department_id = 80);
                 
-- 'Neena'와 같은 해에 입사한 직원들의 이름과 입사일을 조회하기
select first_name, hire_date
from employees
where to_char(hire_date, 'YYYY') in (select to_char(hire_date, 'YYYY')
                                     from employees
                                     where first_name in 'Neena');

-- 'Neena'의 상사와 같은 상사에게 보고하는 직원의 아이디, 이름, 부서아이디, 부서명을 조회하기
select e.employee_id, e.first_name, e.department_id, d.department_name 
from employees e, departments d
where e.manager_id = d.manager_id 
and e.manager_id in (select manager_id
                        from employees
                        where first_name = 'Neena');

-- 전체 직원의 평균급여 2배 이상을 받는 사원의 아이디, 이름, 급여를 조회하기
select employee_id, first_name, salary
from employees
where salary >= (select avg(salary)*2
                 from employees);

-- 전체 직원의 평균급여보다 급여를 많이 받고, 'Neena'와 같은 해에 입사한 직원의 아이디, 이름, 급여, 입사일을 조회하기
select employee_id, first_name, salary, hire_date 
from employees
where salary > (select avg(salary)
                 from employees)
and to_char(hire_date, 'YYYY') in (select to_char(hire_date, 'YYYY')
                                   from employees
                                   where first_name = 'Neena');

-- 'Ismael'과 같은 해에 입사했고, 같은 부서에 근무하는 직원의 아이디, 이름, 입사일, 부서아이디를 조회하기
select employee_id, first_name, hire_date, department_id
from employees
where to_char(hire_date, 'YYYY') in (select to_char(hire_date, 'YYYY')
                                     from employees
                                     where first_name = 'Ismael')
and department_id in (select department_id
                      from employees
                      where first_name = 'Ismael');

-- 가장 많은 직원이 입사한 해에 입사한 직원들의 이름, 입사일, 소속부서아이디, 부서명을 조회하기
select e.first_name, e.hire_date, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id 
and to_char(hire_date, 'YYYY') in (select to_char(hire_date, 'YYYY')
                                     from employees
                                     group by to_char(hire_date, 'YYYY')
                                     having count(*) in  (select max(count(*))
                                                          from employees
                                                          group by to_char(hire_date, 'YYYY')));
 
-- 직종아이디별로 직원수를 조회했을 때 직원수가 10이상인 직종에 일하고 있는 직원의 이름, 직종아이디를 조회하기
select first_name, job_id
from employees
where job_id in (select job_id
                 from employees
                 group by job_id
                 having count(*) >= 10);

-- 각 부서별로 평균급여를 조회했을 때 평균급여 이상을 받는 
-- 부서아이디, 이름, 급여를 조회하고, 부서아이디별로 정렬하기
select e.department_id, e.first_name, e.salary
from employees e
where e.salary >= (select avg(salary)
                   from employees
                   where department_id = e.department_id)
order by e.department_id asc;



