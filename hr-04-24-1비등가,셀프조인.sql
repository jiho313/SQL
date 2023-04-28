-- 직원테이블에서 커미션을 받는 직원들의
-- 직원아이디, 이름, 급여, 직종아이디, 직종제목, 소속부서아이디, 부서명을 조회하기
select e.employee_id,
        e.first_name,
        e.salary, 
        j.job_id,
        j.job_title,
        d.department_name
from employees e, departments d, jobs j 
where e.department_id = d.department_id
and e.job_id = j.job_id
and e.commission_pct is not null;

-- 직원테이블에서 10, 20, 30, 40번 부서에 소속된 직원들의 
-- 직원아이디, 이름, 직종아이디, 소속부서아이디, 소속부서명, 부서소재지도시명을 조회하기
select e.employee_id,
        e.first_name,
        e.job_id, 
        e.department_id,
        d.department_name,
        l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and d.department_id in (10, 20, 30, 40);

select e.employee_id,
        e.first_name,
        e.job_id, 
        d.department_id,
        d.department_name,
        l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and d.department_id between 10 and 40;

------------------------------------------------------------------------------------------
-- 비등가조인용 샘플 테이블 생성 및 값 추가
------------------------------------------------------------------------------------------

create table salary_grades (
    grade char(1),
    min_salary number(8, 2),
    max_salary number(8, 2)
);
  
insert into salary_grades values('A', 50000, 99999);
insert into salary_grades values('B', 20000, 49999);
insert into salary_grades values('C', 10000, 19999);
insert into salary_grades values('D', 5000, 9999);
insert into salary_grades values('E', 2500, 4999);
insert into salary_grades values('F', 1000, 2499);
insert into salary_grades values('G', 0, 999);

-- 60번 부서에 소속된 직원들의 직원아이디, 이름, 급여, 급여등급을 조회하기
select e.employee_id, e.first_name, e.salary, g.grade, g.min_salary, g.max_salary
from employees e, salary_grades g
where e.department_id = 60
and e.salary >= g.min_salary and e.salary <= g.max_salary;

-- 급여등급이 F등급에 해당하는 직원들의 직원아이디, 이름, 급여, 직종아이디를 조회하기
select e.employee_id, e.first_name, e.salary, e.job_id, g.grade
from employees e, salary_grades g
where e.salary >= g.min_salary and e.salary <= g.max_salary
and g.grade = 'F';

-- 10, 20, 30, 40번 부서에 소속된 직원들의
-- 직원아이디, 이름, 직종아이디, 급여, 급여등급, 소속부서아이디, 소속부서명을 조회하기
select e.employee_id,
        e.first_name,
        e.job_id,
        e.salary, 
        g.grade, 
        d.department_id,
        d.department_name
from employees e, departments d, salary_grades g
where salary >= g.min_salary and e.salary <= g.max_salary
and e.department_id = d.department_id
and d.department_id in (10, 20, 30, 40);

------------------------------------------------------------------------------------------
-- 셀프조인
------------------------------------------------------------------------------------------

-- 상사가 지정되어 있는 모든 직원들의 직원아이디, 이름, 상사의 이름을 조회하기
select emp.employee_id as emp_id, 
        emp.first_name as emp_name,
        mgr.first_name as mgr_name
from employees emp, employees mgr
where emp.manager_id is not null
and emp.manager_id = mgr.employee_id;

-- 10, 20, 30, 40번 부서에 소속된 직원들의
-- 직원아이디, 이름, 직원의 상사이름, 소속부서아이디, 소속부서명, 소속부서의 관리자 이름을 조회하기
-- employees가 3번 등장하는데 각각의 용도에 맞게 따로 존재해야한다.
-- emp       emp      emp_mgr         dep            dep         dep_mgr
select e.employee_id as 직원아이디, 
        e.first_name as 직원이름,
        em.first_name as 상사이름, 
        e.department_id as 소속부서아이디,
        d.department_name as 소속부서명,
        dm.first_name as 소속부서관리자이름
from employees e, employees em, departments d, employees dm
where e.department_id in (10, 20, 30, 40) 
and e.manager_id = em.employee_id
and e.department_id = d.department_id
and d.manager_id = dm.employee_id;

------------------------------------------------------------------------------------------
-- 포괄조인
------------------------------------------------------------------------------------------
-- 부서아이디, 부서명, 부서관리자아이디, 부서관리자이름을 조회하기
select d.department_id, 
        d.department_name,
        d.manager_id,
        e.first_name
from departments d, employees e
where d.manager_id = e.employee_id(+);
 
-- 커미션을 받는 모든 직원의 직원아이디, 이름, 소속부서아이디, 소속부서명, 
-- 소재지아이디, 소재지도시명을 조회 
-- 소속부서가 지정되지 않는 사원정보도 조회
select e.employee_id,
        e.first_name,
        e.department_id,
        d.department_name,
        d.location_id,
        l.city
from employees e, departments d, locations l
where e.commission_pct is not null
and e.department_id = d.department_id(+)
and d.location_id = l.location_id(+);










