-------------------------------------------------------------------------------------------
-- 서브쿼리
-------------------------------------------------------------------------------------------

-- 단일행 서브쿼리
-- 서브쿼리의 실행결과가 1행 1열인 경우
-- 단일행 서브쿼리 연산자 : >, <, <=, >=, =, !=, <>

-- 전체 직원의 평균급여보다 급여를 많이 받는 직원의 아이디, 이름, 급여를 조회하기.
select employee_id, first_name, salary
from employees
where salary > 평균급여;

select employee_id, first_name, salary
from employees
where salary > (select avg(salary)
                from employees);
                
-- 가장 급여를 적게 받는 직원의 아이디, 이름, 급여를 조회하기
select employee_id, first_name, salary
from employees
where salary = (select min(salary)
                from employees );

-- 다중행 서브쿼리
-- 서브쿼리의 실행결과가 N행 1열인 경우
-- 다중행 서브쿼리 연산자 : in, any, all

-- 1700번 소재지에 위치한 부서에서 근무하는 직원들의 아이디, 이름, 부서아이디를 조회하기
select employee_id, first_name, department_id
from employees
where department_id in (select department_id
                       from departments
                       where location_id = 1700);

-- 서브쿼리를 사용하지 않았을 때
select e.employee_id, e.first_name, e.department_id
from employees e, departments d
where d.location_id = 1700
and d.department_id = e.department_id;

-- 60번 부서에 근무중인 직원들의 급여보다 급여를 많이 받는 직원들의 이름, 급여를 조회하기
select first_name, salary
from employees
where salary > all (select salary
                    from employees
                    where department_id = 60);
/*
    > all은 서브쿼리에서 조회된 모든 값보다 큰 값인 경우 true로 판정한다.
    
    where salary > all (select salary from)은
    where salary > (select max(salary) from)과 동일하다.
*/
                    
select first_name, salary
from employees
where salary > any (select salary
                    from employees
                    where department_id = 60);                    
/*
    > any는 서브쿼리에서 조회된 값 중에서 어느 하나보다 크기만 해도 true로 판정한다.
    
     where salary > any (select salary from)은   
     where salary > (select min(salary) form)과 동일하다.
*/

-- 다중열 서브쿼리
-- 서브쿼리의 실행결과가 N행 N열인 경우
-- 다중열 서브쿼리 연산자 : in

-- 각 부서별 최고 급여를 받는 직원을 받는 직원의 아이디, 이름, 급여를 조회하기

select employee_id, first_name, salary, department_id
from employees
where (department_id, salary) in (select department_id, max(salary)
                                  from employees
                                  where department_id is not null
                                  group by department_id);

-- 서브쿼리와 조인, 2가지 방식으로 모두 해결이 가능한 경우, 언제나 조인을 선택하자

-- 1700번 소재지에 위치한 부서에서 근무하는 직원들의 아이디, 이름, 부서아이디를 조회하기
select employee_id, first_name, department_id
from employees
where department_id in (select department_id
                       from departments
                       where location_id = 1700);

-- 서브쿼리를 사용하지 않고 조인을 사용한 경우
select e.employee_id, e.first_name, e.department_id
from employees e, departments d
where d.location_id = 1700
and d.department_id = e.department_id;

-- 부서별로 직원수를 집계했을 때 직원수가 가장 많은 부서에 소속된 직원들의 이름을 조회하기
select first_name
from employees
where department_id in (select department_id
                       from employees
                       group by department_id
                       having count(*) in (select max(count(*))
                                          from employees
                                          group by department_id));
-- 여기서 select는 뭔가 자바의 return과 비슷한 개념일까...?




 
                
            