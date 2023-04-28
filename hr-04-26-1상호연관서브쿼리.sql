--------------------------------------------------------------------------------------------
-- 상호연관 서브쿼리
--------------------------------------------------------------------------------------------

-- 각 부서별로 평균급여를 조회했을 때 평균급여 이상을 받는 
-- 직원아이디, 이름, 급여, 부서아이디를 조회하기
select e.employee_id, e.first_name, e.salary, e.department_id
from employees e
where e.salary >=  (select avg(salary)
                  from employees
                  where department_id = e.department_id);
                  
-- 부서아이디, 부서명, 각 부서별 사원수 조회하기
-- 상호연관 스칼라 서브쿼리
select d.department_id, d.department_name, (select count(*)
                                            from employees
                                            where department_id =d.department_id) cnt
from departments d;

--------------------------------------------------------------------------------------------
-- 인라인 뷰
--------------------------------------------------------------------------------------------

-- 부서별 최고급여를 계산하고, 해당 부서에서 최고급여를 받는 직원의 아이디, 이름, 급여, 부서아이디를 조회하기
-- 등가조인
select e.employee_id, e.first_name, e.salary, e.department_id
from (select department_id, max(salary) max_salary
      from employees
      group by department_id) s, employees e
where s.department_id = e.department_id
and s.max_salary = e.salary;
-- 테이블 s는 부서아이디와 해당 부서의 최고급여로 구성된 가상의 테이블이다.


-- 각 부서별로 평균급여를 조회했을 때 평균급여 이상을 받는 
-- 직원아이디, 이름, 급여, 부서아이디를 조회하기
-- 등가조인과 비등가조인
select e.employee_id, e.first_name, e.salary, e.department_id
from (select department_id, avg(salary) avg_salary
      from employees
      group by department_id)s, employees e
where s.department_id = e.department_id
and e.salary >= s.avg_salary;

-- 인라인뷰로 부서아이디, 부서이름, 부서별 직원수를 조회하기
select d.department_id, d.department_name, e.cnt
from (select department_id, count(*) cnt
      from employees 
      group by department_id)e, departments d
where e.department_id = d.department_id












