--------------------------------------------------------------------------------------------
-- 묵시적 타입 변환
--------------------------------------------------------------------------------------------
select *
from departments
where department_id = 10;

-- department_id 컬럼의 타입이 숫자 타입이어서 텍스트 '10;이 숫자 10로 변환되었다.
select *
from departments
where department_id = '10';

select product_name, product_create_date, trunc(sysdate-7)
from sample_product
where product_create_date >= trunc(sysdate - 7);

-- product_create_date 컬럼의 타입이 date타입이이서 텍스트 '2023-04-14'가 date타입으로 변환되었다.
select *
from sample_product
where product_create_date >= '2023-04-14';



-- 아래의 SQL 명령어는 오류다.
-- where product_create_date >= '2023-04-21' - 7; 에서는
-- '2023-04-21' - 7 연산이 먼저 실행되는데, 뺄셈 연산을 수행하기 위해서 '2023-04-21' 숫자로 변환할 수 없다.
-- 오늘 기준으로 7일전에 등록된 상품을 조회하기 위해서는 '2023-04-21'을 date 타입으로 변환하는 명시적 형변환이 필요하다.
select *
from sample_product
where product_create_date >= '2023-04-21'- 7;

-- 아래의 코드로 수정
select *
from sample_product
where product_create_date >= to_date('2023/04/14') - 7;

--------------------------------------------------------------------------------------------
-- 명시적 타입 변환
--------------------------------------------------------------------------------------------
/*
명시적 형변환 
    텍스트-숫자 -- 잘 안씀
        텍스트 -> 숫자
        to_number('숫자') 
            to_number('10')     -> 10
            to_number('3.14')   -> 3.14
        to_number('텍스트', '패턴')
            to_number('10,000,000', '99,999,999')   -> 10000000
        
        숫자 -> 
        to_char(숫자)
            to_char(10)             -> '10'
        
        to_char(숫자, '포맷팅패턴')
            to_char(1000000, '9,999,999') -> '1,000,000'
            to_char(123.456, '999.99')   -> '123.45'
            
    텍스트-날짜
        텍스트 -> 날짜
            to_date('2023-04-23')               -> date
            to_date('2023-04-20', 'YYYY-MM-DD') -> date
            to_date('2023-04-20 15:31:30', 'YYYY-MM-DD HH24:MI:SS') -> date
        날짜 -> 텍스트
            to_char(sysdate, 'YYYY')                    -> '2023'
            to_char(sysdate, 'MM')                      -> '04'
            to_char(sysdate, 'DD')                      -> '21'
            to_char(sysdate, 'YYYY-MM')                 -> '2023-04'
            to_char(sysdate, 'YYYY-MM-DD')              -> '2023-04-21'
            to_char(sysdate, 'YYYY-MM-DD' HH24')        -> '2023-04-21 10'
            to_char(sysdate, 'YYYY-MM-DD' HH24:MI:SS')  -> '2023-04-21 10:08:23'
            
*/

-- '1000' - 100 이 연산은 명시적 형변환, 묵시적 형변환 모두 동작한다.
select '1000' - 100, to_number('1000') - 100
from dual;

-- '1,000' - 100 이 연산은 묵시적 형변환은 실행되지 않는다. 명시적 형변환이 꼭 필요하다.
SELECT to_number('1,000','9,999') - 100
from dual;

-- 자바와는 다르게 자릿수가 같거나 많게 해야 실행된다.
select to_char(1000000, '9,999,999')
from dual;

select to_char(1000000, '9,999,999'),       -- '1,000,000'`
        to_char(1000000, '99,999'),         -- '#######'
         to_char(1000000, '999,999,999')    -- '  1,000,000'
from dual;

select to_char(1000000, '0,000,000'),       -- '1,000,000'`
        to_char(1000000, '00,000'),         -- '#######'
         to_char(1000000, '000,000,000')    -- '001,000,000'
from dual;

select to_date('2023-04-21') - 7
from dual;

select hire_date, employee_id, first_name
from employees
where to_char(hire_date, 'YYYY') = '2005';

-- 이게 더 맞는 방법 연산자의 좌변을 가공하지 말아야 한다.
select hire_date, employee_id, first_name
from employees
where hire_date >= '2005-01-01' and hire_date < '2006-01-01';

--------------------------------------------------------------------------------------------
-- 기타 함수
--------------------------------------------------------------------------------------------
/*
기타 함수
    nvl(컬럼명 혹은 표현식, 값)
        컬럼명 혹은 표현식의 값이 null이 아니면 컬럼명 혹은 표현식의 값이 반환된다.
        컬럼명 혹은 표현식의 값이 null이면 지정된 값이 반환된다.
        * 컬럼명 혹은 표현식의 타입과 값의 타입이 일치해야 한다. 혼합해서 사용할 경우 to_char이나 to_number로 형변환한다
        
    nvl2(컬럼명 혹은 표현식, 값1, 값2)
        컬럼명 혹은 표현식의 값이 null이 아니면 값이1 반환된다.
        컬럼명 혹은 표현식의 값이 null이면 지정된 값이2 반환된다.   
        * 값1과 값2의 타입이 일치해야 한다. 
        
    -- 많이 쓰이진 않지만 자바에서 활용할 때  null값은 나오지 않기 때문에 쓰임
*/


-- 모든 직원들의 연봉을 조회하기
-- 직원아이디, 이름, 급여, 커미션, 연봉을 출력하기
-- 연봉 -> 급여*12 + 급여*커미션*12

select employee_id, first_name, salary, commission_pct,
    salary*12 + salary*commission_pct*12 as annual_salary
from employees;

-- 계산된 값 또는 표현식의 별칭 지정: 계산된 값을 또는 표현식의 결과를 별칭으로 표시할 때,
-- AS 키워드를 생략할 수 있습니다. (생략) annual_salary

select employee_id, first_name, salary, commission_pct,
    salary*12 + salary*nvl(commission_pct, 0)*12 annual_salary
from employees;


/*
    decode(컬럼명 혹은 표현식, 값1, 값 혹은 표현식,
                            값2, 값 혹은 표현식,
                            값3, 값 혹은 표현식)       
            컬럼명 혹은 표현식의 값이 값1과 일치하면 표현식1이 decode함수의 최종값이 된다.
            컬럼명 혹은 표현식의 값이 값1과 일치하면 표현식2이 decode함수의 최종값이 된다.
            컬럼명 혹은 표현식의 값이 값1과 일치하면 표현식3이 decode함수의 최종값이 된다.
            컬럼명 혹은 표현식의 값이 값1, 값2, 값3 전부 일치하지 않으면 decode함수의 최종값은 null이 된다.
                            
    decode(컬럼명 혹은 표현식, 값1, 값 혹은 표현식,
                            값2, 값 혹은 표현식,
                            값3, 값 혹은 표현식,
                            표현식4)
            컬럼명 혹은 표현식의 값이 값1과 일치하면 표현식1이 decode함수의 최종값이 된다.
            컬럼명 혹은 표현식의 값이 값1과 일치하면 표현식2이 decode함수의 최종값이 된다.
            컬럼명 혹은 표현식의 값이 값1과 일치하면 표현식3이 decode함수의 최종값이 된다.
            컬럼명 혹은 표현식의 값이 값1, 값2, 값3 전부 일치하지 않으면 표현식4가 decode함수의 최종값이 된다.                 
                            
    -- 자바의 case키워드와 비슷하다.
                            
*/

-- 직원들 중에서 60번 부서에 소속된 직원은 급여를 10%인상된 금액으로 조회하고,
--              50번 부서에 소속된 직원은 급여를 5%인상된 금액으로 조회하고,
--              그 외 부서에 소속된 직원은 급여를 3%인상된 금액으로 조회하기

select employee_id, first_name, department_id, salary,
        decode(department_id, 60, salary*1.1,
                              50, salary*1.05,
                              salary*1.03) as increment_salary
from employees
order by employee_id asc;

-- 인상률도 함께 나오게 하고 싶을 때
SELECT employee_id, first_name, department_id, salary,
    decode(department_id, 60, salary * 1.1,
                        50, salary * 1.05,
                        salary * 1.03) AS increment_salary,
    decode(department_id, 60, 1.1,
                        50, 1.05,
                        1.03) AS increment_rate
FROM employees;

/*
    case 구문
        case   
            when 조건식1 then 표현식1
            when 조건식2 then 표현식2
        end
        
        case   
            when 조건식1 then 표현식1
            when 조건식2 then 표현식2
            else 표현식
        end
        * 조건식에 다양한 비교연산자와 논리연산을 사용할 수 있다.
        
        case 컬럼 혹은 표현식
            when 조건식1 then 표현식1
            when 조건식2 then 표현식2
        end
        
        case 컬럼 혹은 표현식
            when 조건식1 then 표현식1
            when 조건식2 then 표현식2
            else 표현식3
        end
        * 컬럼 혹은 표현식의 값과 when에 제시된 값의 일치여부만을 따져서 어떤 표현식이 최종값이 될지 결정한다.
*/

-- 직원들의 급여를 인상해서 조회하기
-- 급여를 2000이하로 받는 직원은 20%인상
-- 급여를 5000이하로 받는 직원은 15%인상
-- 급여를 10000이하로 받는 직원은 10%인상
-- 그 외는 5% 인상된 금액으로 급여를 조회해보기
select employee_id, first_name, department_id, salary,
    trunc(
        case 
            when salary <= 2000 then salary*1.2
            when salary <= 5000 then salary*1.15
            when salary <= 10000 then salary*1.1
            else salary*1.05
        end 
    )as increment_salary
from employees;

-- 인상률도 함께 보기
select employee_id, first_name, department_id, salary,
    trunc(
        case 
            when salary <= 2000 then salary*1.2
            when salary <= 5000 then salary*1.15
            when salary <= 10000 then salary*1.1
            else salary*1.05
        end 
    )as increment_salary,
    case
        when salary <= 2000 then 1.2
        when salary <= 5000 then 1.15
        when salary <= 10000 then 1.1
        else 1.05
    end as increment_rate
from employees;

-- 입사년도를 기준으로 팀을 나누기
-- 2002년 a, 2003년 b, 2004년 c ,,,
select
    case to_char(hire_date, 'YYYY')
        when '2001' then 'a'
        when '2002' then 'b'
        when '2003' then 'c'
        when '2004' then 'd'
        when '2005' then 'e'
        when '2006' then 'f'
        when '2007' then 'g'
        else 'h'
    end as team,
    employee_id, first_name, hire_date
from employees
order by team asc;

-- 이퀄비교는 디코드, 비교 연산식 케이스 웬
select decode(to_char(hire_date, 'YYYY'), '2001', 'a', 
                                          '2002', 'b', 
                                          '2003', 'c', 
                                          '2004', 'd',
                                          '2005', 'e',
                                          '2006', 'f',
                                          '2007', 'g',
                                          'h') as team,
        employee_id, first_name, hire_date
from employees
order by team asc;




