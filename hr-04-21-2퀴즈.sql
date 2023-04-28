-- EMPLOYEES 테이블에서 이름이 8자인 직원들의 이름을 조회하기
select first_name
from employees
where length(first_name)= 8;

-- EMPLOYEES 테이블에서 이름이 8글자 이상인 직원들의 이름과 글자수를 조회하기
select first_name, length(first_name)
from employees
where length(first_name)>= 8;

-- EMPLOYEES 테이블에서 직원의 이름을 전부 대문자로 변환했을 때 3번째 글자가 'E'인 모든 직원의 이름을 조회하기
select upper(first_name)
from employees
where substr(upper(first_name), 3, 1) = 'E';

-- EMPLOYEES 테이블에서 2007년도에 입사한 직원들의 직원아이디, 이름, 입사일을 조회하기
select employee_id, first_name, hire_date -- 이 방법을 더 선호한다.
from employees
where hire_date >= '2007-01-01' and hire_date < '2008-01-01'
order by hire_date asc;

select employee_id, first_name, hire_date
from employees
where to_char(hire_date, 'YYYY') = '2007';

-- EMPLOYEES 테이블에서 2005년에 입사한 직원 중에서 커미션을 받는 직원의 아이디, 이름, 급여, 커미션을 조회하기
select employee_id, first_name, salary, commission_pct, hire_date
from employees
where hire_date >= '2005-01-01' and hire_date < '2006-01-01' 
and commission_pct is not null;

-- EMPLOYEES 테이블에서 오늘이 입사일인 직원의 아이디, 이름, 입사일을 조회하기
select employee_id, first_name, hire_date
from employees
where to_char(hire_date, 'MM/DD') = to_char(sysdate, 'MM/DD');

-- EMPLOYEES 테이블에서 10월달에 입사한 모든 사원들의 아이디, 이름, 입사일을 조회하기
select employee_id, first_name, hire_date
from employees
where to_char(hire_date, 'MM') ='10';

-- EMPLOYEES 테이블에서 급여를 5000이상 받는 직원들의 아이디, 이름, 급여, 급여 등급을 조회하기. 급여 등급: 20000이상 A, 15000이상 B, 10000이상 C, 그 외는 D 다.
select employee_id, first_name, salary,
        case 
            when salary >= 20000 then 'a'
            when salary >= 15000 then 'b'
            when salary >= 10000 then 'c'
            else 'd'
        end as salary_grade
from employees
order by salary_grade;

-- EMPLOYEES 테이블에서 60번 부서에 소속된 사원들의 근무개월수를 오늘을 기준으로 계산해서 조회하기. 직원아이디, 이름, 입사일, 근무개월수가 조회되어야 하고, 근무개월수를 기준으로 오름차순 정렬한다.
select employee_id, first_name, hire_date, trunc(months_between(sysdate, hire_date))worked_months
from employees
where department_id = 60
order by worked_months asc;

-- EMPLOYEES 테이블에서 사원의 이름과 급여를 표시하고, 급여에 대해서 #로 표시하기. '#'하나는 급여 1000에 해당한다. lpad

  -- 출력예시
  -- 홍길동 4300 ####
  -- 김유신 8700 ########
  -- 강감찬 6500 ######
  
-- lpad(표현식'#', trunc(salary/1000), 들어갈 값'#')
select first_name, salary, lpad('#', trunc(salary/1000), '#') 샵출력
from employees;
  
--annual_salary
-- EMPLOYEES 테이블에서 2006년 상반기에 입사한 직원들의 직원아이디, 이름, 입사일, 연봉을 계산하기. 연봉은 급여12 + 급여커미션*12다.
select employee_id, first_name, hire_date,
        (salary*12 + salary*nvl(commission_pct, 0)*12) as annual_salary
from employees
where hire_date >= '2006-01-01' and hire_date <= last_day('2006-06-01');

select employee_id, first_name, hire_date,
        (salary*12 + salary*nvl(commission_pct, 0)*12) as annual_salary
from employees
where hire_date >= '2006-01-01' and hire_date <('2006-07-01');

-- EMPLOYEES 테이블에서 100번 상사에게 보고하는 직원중에서 커미션을 받은 직원들의 직원아이디, 이름, 급여, 커미션을 조회하기
select employee_id, first_name, salary, commission_pct
from employees
where manager_id = 100 and commission_pct is not null;