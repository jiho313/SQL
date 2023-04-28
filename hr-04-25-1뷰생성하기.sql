---------------------------------------------------------------------------------------------------
-- 사용자 정의 뷰 객체 생성하기
---------------------------------------------------------------------------------------------------

-- emp_salary_details_view 생성하기
-- 직원아이디, 이름, 직종아이디, 직종제목, 직종최소급여, 직종최대급여,
-- 급여, 급여등급, 커미션, 연봉
create or replace view emp_salary_details_view
as
    select
        e.employee_id,
        e.first_name,
        e.job_id,
        j.job_title,
        j.min_salary,
        j.max_salary,
        e.salary,
        g.grade,
        nvl(e.commission_pct, 0) commission_pct,
        trunc(e.salary*12+ salary*nvl(commission_pct, 0)*12) annual_salary
    from employees e, jobs j, salary_grades g
    where e.job_id = j.job_id
    and e.salary >= g.min_salary and e.salary <= g.max_salary
with read only;

-- 급여등급별 사원수 조회하기
select g.grade, count(*) 
from employees e, salary_grades g
where e.salary >= g.min_salary and e.salary <= g.max_salary
group by g.grade;

-- 생성한 뷰 조회하기
select *
from emp_salary_details_view;

-- emp_salary_details_view 뷰를 이용해서 급여등급별 사원수 조회하기
select grade, count(*)
from emp_salary_details_view
group by grade;

-- 직원아이디, 직원 이름, 직종제목, 급여, 급여등급, 연봉을 조회하기
select e.employee_id,
        e.first_name, 
        j.job_title,
        e.salary, 
        g.grade, 
        e.salary*12 + e.salary*nvl(e.commission_pct, 0)*12 as annual_salary
from employees e, jobs j, salary_grades g
where e.job_id = j.job_id
and e.salary >= g.min_salary and e.salary <= g.max_salary;

-- emp_salary_details_view 뷰를 이용해서 직원아이디, 직원 이름, 직종제목, 급여, 급여등급, 연봉을 조회하기
select employee_id,
        first_name, 
        job_title,
        salary, 
        grade,
        annual_salary
from emp_salary_details_view;

-- 부서 상세정보를 제공하는 뷰
-- 부서아이디, 부서명, 관리자 아이디, 관리자 이름,
-- 소재지 아이디, 소재지명, 우편번호, 주소,국가아이디, 국가명, 지역아이디, 지역명
create or replace view dept_details_view
as
    select d.department_id,
            d.department_name, 
            m.manager_id,
            m.first_name as manager_name,
            d.location_id,
            l.city, 
            l.postal_code, 
            l.country_id,
            c.country_name, 
            c.region_id,
            r.region_name
    from departments d, employees m, locations l, countries c, regions r
    where d.manager_id = m.employee_id
    and d.location_id = l.location_id
    and l.country_id = c.country_id
    and c.region_id = r.region_id
with read only;

-- 60번 부서에서 근무중인 직원들의 이름, 부서명, 도시, 국가, 지역 조회하기
select e.first_name, d.department_name, d.city, d.country_name, d.region_name
from employees e, dept_details_view d
where e.department_id = 60
and e.department_id = d.department_id;

-- 60번 부서의 상세정보 조회하기
select *
from dept_details_view
where department_id = 60;


select department_id
from employees;

select department_id,(count(*))
from employees
group by department_id;





















