-- 커미션을 받는 사원들의 아이디, 이름, 부서번호, 부서명, 급여등급을 조회하기
select e.employee_id, e.first_name, e.department_id, d.department_name, g.grade
from employees e, departments d, salary_grades g
where e.commission_pct is not null
and e.department_id = d.department_id(+)
and e.salary >= g.min_salary and e.salary <= g.max_salary;

-- 모든 사원의 사원아이디, 이름, 그 사원의 상사이름, 소속부서이름, 소속부서 관리자 이름 조회하기
select e.employee_id, 
        e.first_name, 
        em.first_name as 상사이름,
        d.department_name,
        dm.first_name as 소속부서관리자이름
from employees e, departments d, employees em, employees dm
where e.manager_id = em.employee_id(+)
and e.department_id = d.department_id(+)
and e.manager_id = dm.employee_id(+);

-- 직종별 평균급여를 계산했을 때 평균급여가 가장 적은 직종과 평균급여를 조회하기
select e.job_id, s.min_avg_salary
from (select job_id, avg(salary) avg_salary
     from employees 
     group by job_id) e,
     (select min(avg_salary) min_avg_salary
     from (select job_id, avg(salary) avg_salary
     from employees 
     group by job_id)) s
where e.avg_salary = s.min_avg_salary;


-- 직종별 평균급여를 계산했을 때 평균급여가 가장 적은 직종의 아이디, 직종제목, 그 직종의 최저급여, 그 직종의 최대급여를 조회하기
select e.job_id, j.job_title, j.min_salary, j.max_salary
from jobs j,
     (select job_id, avg(salary) avg_salary
      from employees
      group by job_id) e,
     (select min(avg_salary) min_avg_salary
      from (select job_id, avg(salary) avg_salary
           from employees
           group by job_id))s
where e.avg_salary = s.min_avg_salary
and e.job_id = j.job_id;

-- 국가별 직원수를 계산했을 때 직원이 한 명이라도 근무하고 있는 국가명과 직원수를 조회하기
select nvl(l.country_id, '국가불명'), count(*)
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+)
group by l.country_id;

-- 부서별 평균급여를 계산했을 때 전체직원의 평균급여보다 평균급여가 높은 부서의 아이디와 평균급여를 조회하기
select e.department_id, e.avg_salary
from (select department_id, avg(salary) avg_salary
        from employees
        group by department_id) e
where e.avg_salary > (select avg(salary)
                      from employees);


-- 사원 테이블의 급여를 기준으로 급여 등급을 조회했을 때, 급여등급별 사원수를 조회하기
select g.grade, count(*)
from(select g.grade
from employees e, salary_grades g
where e.salary >= g.min_salary and e.salary <= g.max_salary) g
group by g.grade;

-- 사원들이 근무하는 부서의 소재도시와 그 도시에서 근무하는 사원수를 조회하기
select nvl(l.city, '소재지불명'), count(*)
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+)
group by l.city;


-- 가장 적은 사원이 입사한 해와 그 해에 입사한 사원수를 조회하기
select d."입사해", m."사원수"
from (select to_char(hire_date, 'YYYY') as "입사해"
        from employees
        group by to_char(hire_date, 'YYYY')
        having count(*) in (select min(count(*))
                            from employees 
                            group by to_char(hire_date, 'YYYY'))) d,
     (select min(count(*)) as "사원수"
      from employees 
      group by to_char(hire_date, 'YYYY'))m;

-- 관리자별 사원수를 조회했을 때 사원수가 10명을 넘는 관리자 아이디와 사원수를 조회하기
select e.manager_id, count(*)
from employees e, employees em
where e.manager_id = em.employee_id
group by e.manager_id
having count(*) > 10;

-- 부서별 평균급여를 조회했을 때 그 부서의 평균급여보다 적은 급여를 받은 사원의 이름, 급여, 부서명을 조회하기
-- 서브쿼리로 풀기
select e.first_name, e.salary, d.department_name
from employees e, departments d
where e.salary < (select avg(salary)
                  from employees 
                  where department_id = e.department_id)
and e.department_id = d.department_id;

-- 인라인뷰로 풀기)
select e.first_name, e.department_id, e.salary, d.department_name
from employees e, departments d,
     (select department_id, avg(salary) avg_salary
     from employees 
     group by department_id) s
where e.salary < s.avg_salary
and e.department_id = d.department_id
and e.department_id = s.department_id;

-- 부서별로 부서아이디, 부서명, 부서관리자이름, 소속사원수를 조회하기
select d.department_id, d.department_name, dm.first_name,(select count(*)
                                            from employees
                                            where department_id =d.department_id) cnt
from employees dm, departments d
where d.manager_id = dm.employee_id;




