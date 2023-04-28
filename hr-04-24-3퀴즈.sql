----------------------------------------------------------------------------------------------------------------------------------------------------
-- 등가 조인
----------------------------------------------------------------------------------------------------------------------------------------------------
-- 급여가 12000을 넘는 사원의 이름과 급여를 조회하기
select first_name, salary
from employees
where salary >= 1200;

-- 급여가 5000이상 12000이하인 사원의 이름과 급여를 조회하기
select first_name, salary
from employees
where salary >= 5000 and salary <= 12000
order by salary asc;

-- 2007년에 입사한 사원의 아이디, 이름, 입사일을 조회하기
select employee_id, first_name, to_char(hire_date, 'YYYY')
from employees
where hire_date >= '2007-01-01' and hire_date < '2008-01-01';

select employee_id, first_name, to_char(hire_date, 'YYYY')
from employees
where to_char(hire_date, 'YYYY') = '2007';

-- 20과 50번 부서에 소속된 사원의 이름과 부서번호를 조회하고, 이름을 알파벳순으로 정렬해서 조회하기
select first_name, department_id
from employees
where department_id in (20, 50);

-- 급여가 5000이상 12000이하고, 20번과 50번 부서에 소속된 사원의 이름과 급여, 부서번호를 조회하기
select first_name, salary, department_id
from employees
where salary between 5000 and 12000
and department_id in (20, 50);

-- 관리자가 없는 사원의 이름과 직종, 급여를 조회하기
select first_name, job_id, salary
from employees
where manager_id is null;

-- 직종이 'SA_MAN'이거나 'ST_MAN'인 직원중에서 급여를 8000이상 받는 사원의 아이디, 이름, 직종, 급여를 조회하기
select employee_id, first_name, job_id, salary
from employees
where job_id in ('SA_MAN', 'ST_MAN') 
and salary >= 8000;

-- 직종 테이블에서 직종아이디, 직종제목, 최저급여, 최고급여를 조회하고,
-- 최저급여, 최고급여에 대한 시간당 임금을 조회하기
-- 급여는 한 달 20일, 하루 8시간 근무 기준이다.
-- 시간당 임금은 일의 자리로 반올림해서 표시한다.
select job_id, job_title,
            min_salary,
            max_salary, 
            round((min_salary/20/8)) as "최저급여시간당",
            round((max_salary/20/8)) as "최고급여시간당"
from jobs;


-- 모든 사원의 이름, 직종아이디, 급여, 소속부서명을 조회하기
select emp.first_name,
    nvl(to_char(emp.department_id), '없음'),
    emp.salary, 
    nvl(to_char(dep.department_name), '없음') as department_name
from employees emp, departments dep
where emp.department_id = dep.department_id(+);

-- 모든 사원의 이름, 직종아이디, 직종제목, 급여, 최소급여, 최대급여를 조회하기
select emp.first_name,
        emp.job_id, 
        job.job_title, 
        emp.salary,
        job.min_salary, 
        job.max_salary
from employees emp, jobs job
where emp.job_id = job.job_id;

-- 모든 사원의 이름, 직종아이디, 직종제목, 급여, 최소급여와 본인 급여의 차이를 조회하기
select emp.first_name,
        emp.job_id, 
        job.job_title, 
        emp.salary,
        job.min_salary, 
        (emp.salary - job.min_salary) as "급여차이"
from employees emp, jobs job
where emp.job_id = job.job_id;

-- 커미션을 받는 모든 사원의 아이디, 부서이름, 소속부서의 소재지(도시명)을 조회하기
select emp.employee_id,
        dep.department_name,
        loc.city 
from employees emp, departments dep, locations loc
where emp.commission_pct is not null
and emp.department_id = dep.department_id(+)
and dep.location_id = loc.location_id(+);

----------------------------------------------------------------------------------------------------------------------------------------------------
-- 비등가 조인
----------------------------------------------------------------------------------------------------------------------------------------------------
-- 이름이 A나 a로 시작하는 모든 사원의 이름과 직종, 직종제목, 급여, 소속부서명을 조회하기
select emp.first_name, emp.job_id, job.job_title, emp.salary, dep.department_name
from employees emp, jobs job, departments dep
where (first_name like 'A%' or first_name like 'a%')
and emp.department_id = dep.department_id
and emp.job_id = job.job_id;

-- 30, 60, 90번 부서에 소속되어 있는 사원들 중에서 100에게 보고하는 사원들의 이름, 직종, 급여, 급여등급을 조회하기
-- 비등가 조인 emp.salary와 sgr.min_salary, sgr.max_salary
select emp.first_name, emp.job_id, emp.salary, sgr.grade
from employees emp, salary_grades sgr
where emp.department_id in (30, 60, 90)
and emp.salary >= sgr.min_salary and emp.salary <= sgr.max_salary
and emp.manager_id = 100
order by sgr.grade asc;


-- 80번 부서에 소속된 사원들의 이름, 직종, 직종제목, 급여, 최소급여, 최대급여, 급여등급, 소속부서명을 조회하기
-- 비등가 조인 emp.salary와 sgr.min_salary, sgr.max_salary
select emp.first_name,
        emp.job_id,
        job.job_title, 
        emp.salary, 
        job.min_salary, 
        job.max_salary, 
        sgr.grade, 
        dep.department_name
from employees emp,jobs job, salary_grades sgr, departments dep
where emp.department_id = 80
and emp.department_id = dep.department_id
and emp.job_id = job.job_id
and emp.salary >= sgr.min_salary and emp.salary <= sgr.max_salary;

----------------------------------------------------------------------------------------------------------------------------------------------------
-- 셀프 조인
----------------------------------------------------------------------------------------------------------------------------------------------------
-- 사원들중에서 자신의 상사보다 먼저 입사한 사원들의 이름, 입사일, 상사의 이름, 상사의 입사일을 조회하기
select e.first_name as "직원이름",
            e.hire_date as "직원입사일", 
            em.first_name as "상사이름", 
            em.hire_date "상사입사일"
from employees e, employees em 
where e.manager_id = em.employee_id 
and e.hire_date < em.hire_date;

-- 부서명이 IT인 부서에 근무하는 사원들의 이름과, 직종, 급여, 급여등급, 상사의 이름과 직종을 조회하기
select e.first_name, e.job_id, e.salary, g.grade, em.first_name, em.job_id
from employees e, salary_grades g, employees em, departments d
where e.department_id = d.department_id
and d.department_name = 'IT'
and e.salary >= g.min_salary and e.salary <= g.max_salary
and e.manager_id = em.employee_id;

-- 'ST_CLERK'로 근무하다가 다른 직종으로 변경한 사원의 아이디, 이름, 변경전 부서명, 현재 직종, 현재 근무부서명을 조회하기
select e.employee_id, 
        e.first_name,
        pd.department_name as "변경전부서명",
        e.job_id as "현재직종",
        d.department_name as "현재근무부서명"
from employees e, job_history jh, departments d, departments pd
where jh.job_id = 'ST_CLERK'
and e.employee_id = jh.employee_id
and jh.department_id = pd.department_id
and e.department_id = d.department_id;

-- 'Toronto'에서 근무중인 직원의 아이디, 이름을 조회하기
select e.employee_id, e.first_name
from employees e, locations l, departments d
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.city = 'Toronto';

-- 커미션을 받는 직원들을 급여 등급별로 구분해서 사원수를 조회하기
select g.grade, count(*)
from employees e, salary_grades g
where e.commission_pct is not null 
and e.salary >= g.min_salary and e.salary <= g.max_salary
group by g.grade;

--  직원의 아이디, 이름, 커미션을 조회하기. 커미션을 받지 않는 직원은 '없음'으로 표시하기
SELECT employee_id, first_name, NVL(TO_CHAR(commission_pct, 'fm0.99' ), '없음')
FROM employees;

-- 'Europe'에 소재지를 두고 있는 모든 부서의 부서아이디와 부서이름을 조회하기
select d.department_id, d.department_name
from departments d, locations l, countries c, regions r
where d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id
and r.region_name = 'Europe';


-- 급여등급이 'E'등급인 직원 중에서 2005년에 입사한 직원의 아이디, 이름, 입사일, 급여, 소속부서아이디, 소속부서명을 조회하기
select e.employee_id, e.first_name, to_char(e.hire_date, 'YYYY'), e.salary, e.department_id, d.department_name, g.grade
from employees e, departments d, salary_grades g
where e.department_id = d.department_id
and e.salary >= g.min_salary and e.salary <= g.max_salary
and g.grade = 'E'
and e.hire_date >= '2005-01-01' and e.hire_date < '2006-01-01';

-- 직원들을 등급별로 구분해서 인상된 급여를 조회하기
-- A 등급: 5% 인상, B등급: 7% 인상, C등급: 10% 인상, D등급: 12% 인상, E등급: 15% 이상, 나머지는 20%인상
select e.employee_id, e.first_name, g.grade, e.salary,
     decode(g.grade, 'A', e.salary*1.05,
                     'B', e.salary*1.07,
                     'C', e.salary*1.1,
                     'D', e.salary*1.12,
                     'E', e.salary*1.15,
                     e.salary*1.2) as "인상된급여",
     decode(g.grade, 'A', 1.05,
                     'B', 1.07,
                     'C', 1.1,
                     'D', 1.12,
                     'E', 1.15,
                     1.2) as "인상률"
from employees e, salary_grades g
where e.salary >= g.min_salary and e.salary <= g.max_salary;


