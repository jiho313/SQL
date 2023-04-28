-- departments 테이블과 locations 테이블을 조인하기
-- 내가 조회하려는 정보가 어느 테이블에 존재하는지 알고 있어야하고, 어떤 필드를 매개로 
-- 연결해야 하는지도 알고 있어야한다.
select a.department_id,
        a.department_name,
        b.city,
        b.postal_code,
        b.street_address
-- 테이블명도 별칭을 정해줄 수 있다.
from departments a, locations b -- from절에 입력하는 것 만으로도 조인 가능
where a.location_id = b.location_id; -- 조인 조건

-----------------------------------------------------------------------------------------------
-- 조인
-----------------------------------------------------------------------------------------------

/*
    등가조인
        컬럼의 값이 같은 것끼리 행을 연결하는 것
*/
-- 직원아이디, 직원이름, 소속부서아이디, 소속부서명을 조회하기
-- employees employees employees     departments
-- 조인할 테이블: employees, departments
-- 조인에 참여하는 컬럼: employees의 department_id,departments의 department_id
select e.employee_id, e.first_name, e.department_id, d.department_name, d.manager_id
from employees e, departments d;


-- 직원아이디, 지원이름, 직원의 직종아이디, 급여, 해당직종의 최소급여, 해당직종의 최대급여 조회
-- emp          emp         emp         emp         jobs              jobs
select e.employee_id,
        e.first_name,
        e.job_id,
        e.salary,
        j.min_salary,
        j.max_salary
from employees e, jobs j
where e.job_id = j.job_id;

-- 부서테이블에서 해당 부서를 관리하는 직원이 지정되어 있는 부서를 대상으로
-- 부서아이디, 부서명, 부서를 관리하는 직원의 이름, 직원의 직종아이디를 조회하기
-- 조인조건에 참여하는 컬럼:departments의 maneger_id와 employees의 employee_id
-- 부서테이블의 관리자아이디와 직원테이블의 직원아이디가 같은 행끼리 조인된 것만 조회한다.
select d.department_id,
        d.department_name,
        e.first_name,
        e.employee_id,
        d.manager_id,
        e.job_id
from departments d, employees e
where d.manager_id = e.employee_id
and d.manager_id is not null;

-- 직종 최저급여와 직종 최고급여의 중간값보다 급여를 더 많이 받고 있는
-- jobs              jobs
-- 직원의 아이디, 이름, 직종아이디, 급여를 조회하기
-- emp           emp    emp      emp
select e.employee_id,
        e.first_name,
        e.job_id, 
        e.salary,
        ((j.min_salary + j.max_salary)/2) as average_salary,
        j.min_salary,
        j.max_salary
from employees e, jobs j
where e.job_id = j.job_id
and e.salary > ((j.min_salary + j.max_salary)/2);

-- 직원의 아이디, 직원의 이름, 직원의 소속부서아이디, 직원이 종사하고 있는 직종의 제목을 조회하기
-- 조인조건에 필요한 컬럼
-- 직원의 소속부서이름: employees의 department_id랑 departments의 department_id가 같은 행
-- 직원의 직종제목: employees의 job_id랑 jobs의 job_id가 같은 행
-- 조인한 테이블의 갯수 -1의 where조건이 있어야 한다 등가조인인 경우 비등가조인은 더 많을 수도 있다.
select e.employee_id,
        e.first_name,
        d.department_id ,
        j.job_title
from employees e, departments d,jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id;

-- 부서테이블에서 해당 부서를 관리하는 직원이 저장되어 있는 부서를 대상으로
-- 부서아이디, 부서명, 해당 부서의 관리자 이름, 관리자의 전화번호, 소재지 도시명, 소재지 주소를 조회하기

select d.department_id, 
        d.department_name,
        e.first_name, 
        e.phone_number, 
        l.city, 
        l.street_address
from departments d, employees e, locations l
where d.manager_id is not null 
and d.department_id = e.department_id
and d.location_id = l.location_id;






