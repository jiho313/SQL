-- 데이터 조회

--------------------------------------------------------------------------------------------------
-- 테이블이 모든 행(record), 모든 열(column)을 조회하기
-- select *
-- form 테이블명;
--------------------------------------------------------------------------------------------------

-- regions 테이블의 모든 행, 모든 열 조회하기
select *
from regions;
-- countries 테이블의 모든 행, 모든 열 조회하기
select *
from countries;
-- departments 테이블의 모든 행, 모든 열 조회하기
select *
from departments;
-- jobs 테이블의 모든 행, 모든 열 조회하기
select *
from jobs;

-- employees 테이블의 모든 행, 모든 열 조회하기
select *
from employees;

--------------------------------------------------------------------------------------------------
-- 테이블 모든 행을 조회하고, 지정된 컬럼만 조회하기
-- select 컬럼명, 컬럼명, 컬럼명
-- from 테이블명;
-- * select 절의 맨 마지막 컬럼명에는 ,를 적지않는다.
-- * 컬럼명의 순서는 테이블의 컬럼명 순서와 상관없이 작성할 수 있다.
-- * 컬럼명은 대소문자를 구문하지 않는다.
--------------------------------------------------------------------------------------------------

-- employees 테이블에서 직원아이디, 직원이름(first_name), 이메일, 전화번호 조회하기
select employee_id, first_name, email, phone_number
from employees;

-- employees 테이블에서 직종아이디를 조회하기
select job_id
from employees;

-- employees 테이블에서 직종아이디를 중복없이 조회하기
select DISTINCT job_id
from employees;

-- employees 테이블에서 직종아이디, 부서아이디를 조회하기
SELECT job_id, department_id
from employees;

-- employees 테이블에서 직종아이디, 부서아이디를 중복없이 조회하기
-- 오라클에서의 null 아직 값이 결정되지 않았다는 뜻이다.
-- 값이 null인 것과 연산을 하면 값은 null이다.
SELECT DISTINCT job_id, department_id
from employees;

--------------------------------------------------------------------------------------------------
-- 조회된 컬럼에 별칭 붙이기
-- select 컬럼명 as 별칭, 컬럼명 as 별칭, 컬럼명 as 별칭
-- from 테이블명;

-- select 컬럼명 별칭, 컬럼명 별칭, 컬럼명 별칭
-- from 테이블명;
-- * as를 생략할 수 있다.
-- * 별칭에 공백이나 오라클의 예약어가 포함되어 있을 때는 "별칭" 형식으로 정의한다.
-- * select절에서 연산식의 결과를 조회되어 있을 때 연산식의 결과에 대해서 별칭을 부여할 수 있다.
--------------------------------------------------------------------------------------------------

-- employees 테이블에서 employess_id, first_name, job_id를 조회하고,
-- 각각 id, name, job이라고 별칭을 부여하기
select employee_id as id, first_name as name, job_id as job
from employees;

-- employees 테이블에서 employess_id, first_name, last_name을 조회하고,
-- first_name과 last_name을 합쳐서 imployee_name 별칭을 붙여서 조회하기
-- 컬럼명 || 컬럼명 두 개의 컬럼의 값을 연결하여 하나의 문자열로 만든다. 별칭은 연산자를 포함해 합쳐져 표시된다.
SELECT employee_id, first_name || last_name as employee_name
from employees;

-- employees 테이블에서 employess_id, first_name, last_name을 조회하고,
-- first_name과 last_name을 합쳐서 조회하기
-- 각각, "사원 아이디", "사원 이름"을 별칭을 붙이기
SELECT employee_id as "사원 아이디", first_name || last_name as "사원 이름"
from employees;

--------------------------------------------------------------------------------------------------
-- 행의 제한(데이터 필터링)
-- 테이블(릴레이션)에서 제시된 조건을 만족하는 행만 조회하기
-- select *
-- from 테이블명
-- where 조건식
-- * 제시된 조건식이 true로 판정되는 행만 조회한다.

-- 오라클의 비교 연산자
-- equal:            =
-- not equal:        !=, <>
-- greaterThan:      >
-- gteaterEqual      >=        
-- lessThan          <
-- lessEqual         <=

-- 오라클의 논리 연산자
-- 논리곱          and
-- 논리합          or
-- 논리부정        not
--------------------------------------------------------------------------------------------------

-- employees 테이블에서 소속부서 아이디가 60번인 직원의 아이디, 이름, 소속부서아이디 조회
select employee_id, first_name, department_id
from employees
where department_id = 60;

-- employees 테이블에서 first_name이 'Steven' 직원의 아이디, 이름, 직종아이디를 조회하기
-- 오라클에서 텍스트 데이터는 ''로 감싼다. ""은 별칭, 컬럼명을 뜻한다.
-- 문자 데이터는 대소문자를 엄격하게 구분한다.
select employee_id, first_name, job_id
from employees
where first_name = 'Steven';

-- employees 테이블에서 급여를 10000이상 받는 직원의 아이디, 이름, 직종아이디, 급여를 조회하기
select employee_id, first_name, job_id, salary
from employees
where salary >= 10000;

-- departments 테이블에서 location_id가 1700인 부서의 아이디, 부서 이름, lolocation_id 조회하기
select department_id, department_name, location_id
from departments
where location_id = 1700;

-- employees 테이블에서 급여를 10000이상 15000이하로 받는 직원의 아이디, 이름, 급여를 조회하기
select employee_id, first_name, salary
from employees
where salary >= 10000 and salary <= 15000;

-- employees 테이블에서 소속 부서 아이디가 50번인 직원과 소속부서 아이디가 80번인
-- 직원의 아이디, 이름, 소속 부서 아이디 조회하기
select employee_id, first_name, salary, department_id
from employees
where department_id = 50 or department_id = 80;

-- employees 테이블에서 소속부서아이디가 50 혹은 80번인 부서에 소속되어 있고,
-- 급여를 3000미만으로 받는 직원의 아이디, 급여, 소속부서 아이디를 조회하기
select employee_id, salary, department_id
from employees
where (department_id = 50 or department_id = 80) and salary < 3000
-- 급여를 오름차순으로 정렬하기
-- order by salary asc;
-- 급여를 내림차순으로 정렬하기
order by salary desc;


--------------------------------------------------------------------------------------------------
-- 조회결과를 오름차순, 내림차순으로 정렬하기
-- select 컬럼명, 컬럼명, 컬럼명
-- from 테이블명
-- where 조건식
-- order by 컬럼명, asc;
-- * order by 절은 select구문에서 항상 맨 마지막에 포함된다.
-- * order by 절은 지정한 컬럼이 값을 기준으로 오름차순, 내림차순으로 정렬할 수 있다.
-- * 정렬방향을 지정하지 않으면 기본적으로 오름차순이다.
-- * asc는 오름차순 정렬, desc는 내림차순 정렬이다.
--------------------------------------------------------------------------------------------------

-- employees 테이블에서 급여를 10000달러 이상 받는 직원의 급여, 직종아이디, 이름을 조회하기
-- 조회결과는 급여순으로 오름차순 정렬한다
SELECT salary, job_id, first_name
from employees
where salary >= 10000
order by salary asc;

--------------------------------------------------------------------------------------------------
-- 조건식에서 사용가능한 기타 연산자
-- where 컬럼명 between 하한값 and 상한값
-- * 지정된 컬럼의 값이 A값이상 B값이하의 값일 때 true로 판정한다.
-- * where 컬럼명 >= 하한값 and 컬럼명 <= 상한값; 이 조건식과 동일하다.

-- where 컬럼명 in (값1, 값2, 값3)
-- * 지정된 컬럼의 값이 제시된 값1, 값2, 값3 중에서 하나만 일치해도 true로 판정한다.
-- * where 컬럼명 = 값1 or 컬럼명 = 값2 or 컬럼명 = 값3; 이 조건식과 동일하다.

-- where 컬럼명 like '패턴'
-- * 지정된 컬럼의 값이 제시된 패턴과 일치하면 true로 판정한다.
-- * 패턴문자
--  '%'     -> 0개 이상의 임의의 문자를 나타낸다.
--  '_'     -> 임의의 문자 하나를 나타낸다.
-- * where employee_name like '이_';   <------- '이황', '이이'의 값이 true로 판정된다.
-- * where book_title like '자바%';    <------- '자바', '자바의 정석'의 값이 true로 판정된다.
-- * where employee_name like '이_%';  <------- '이이', '이황', '이순신', '이세상에제일예쁜아기' true
--------------------------------------------------------------------------------------------------

-- 급여를 15000이상 20000이하로 받는 직원의 아이디, 이름, 급여, 직종을 조회하기
select employee_id, first_name, salary, job_id
from employees
--where salary >= 15000 and salary <= 20000;
where salary between 15000 and 20000;

-- 10, 20, 30번 부서에 소속된 직원의 아이디, 이름, 소속부서를 조회하기
select employee_id, first_name, department_id
from employees
-- where department_id = 10 or  department_id = 20 or department_id = 30; 
where department_id in (10, 20, 30);

-- 10, 20, 30번 부서에 소속된 직원 중에서 급여를 5000이상 받는 직원이 아이디, 이름, 급여, 소속부서를 조회
select employee_id, first_name, salary, department_id
from employees
where department_id in (10, 20, 30) and salary >= 5000;


commit;


