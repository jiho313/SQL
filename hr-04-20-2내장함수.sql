--------------------------------------------------------------------------------------------------
-- 단일행 함수: 문자함수
--------------------------------------------------------------------------------------------------

-- LOWER(컬럼명 혹은 표현식) : 소문자로 변환해서 반환한다.
-- UPPER(컬럼명 혹은 표현식) : 대문자로 변환해서 반환한다.
SELECT LOWER(FIRST_NAME), UPPER(FIRST_NAME)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- SUBSTR(컬럼명 혹은 표현식, 시작위치) : 텍스트를 시작위치에서부터 끝까지 잘라서 반환한다.
-- SUBSTR(컬럼명 혹은 표현식, 시작위치, 길이) : 텍스트를 시작위치에서부터 지정된 길이만큼 잘라서 반환한다.
SELECT FIRST_NAME, SUBSTR(FIRST_NAME, 3), SUBSTR(FIRST_NAME, 3, 1), SUBSTR(FIRST_NAME, 3, 2)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- LENGTH(컬럼 혹은 표현식) : 텍스트의 길이를 반환한다.
-- INSTR(컬럼 혹은 표현식, '검색할텍스트') : 검색할 텍스트가 처음으로 등장하는 위치를 반환한다.
SELECT FIRST_NAME, LENGTH(FIRST_NAME), INSTR(FIRST_NAME, 'e')
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- LPAD(컬럼 혹은 표현식, 길이, '텍스트') : 값의 길이가 지정된 길이 보다 짧으면 지정된 텍스트를 모자란 갯수만큼 왼쪽에 추가한다. 
-- RPAD(컬럼 혹은 표현식, 길이, '텍스트') : 값의 길이가 지정된 길이 보다 짧으면 지정된 텍스트를 모자란 갯수만큼 오른쪽에 추가한다. 
SELECT FIRST_NAME, LPAD(FIRST_NAME, 10, '0'), RPAD(FIRST_NAME, 10, '0')
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

SELECT FIRST_NAME, REPLACE(FIRST_NAME, 'e', '*')
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

--------------------------------------------------------------------------------------------------
-- 단일행 함수: 숫자함수
--------------------------------------------------------------------------------------------------

-- ROUND(컬럼명 혹은 표현식) : 소숫점 바로 아래에서 반올림한다.
SELECT ROUND(12.3), ROUND(1234.5)
FROM DUAL;

-- ROUND(컬럼명 혹은 표현식, 숫자) : 지정된 자릿수로 반올림한다.
-- 양의 정수 : 소숫점 자릿수, 음의 정수 : -1, -2, -3은 각각 10의자리, 100의자리 1000의 자리다.
SELECT ROUND(12345.345, 1), ROUND(12345.345, 2)
FROM DUAL;

SELECT ROUND(12345.345, 0), ROUND(12345.345, -1), ROUND(12345.345, -2)
FROM DUAL;

-- ROUND(컬럼명 혹은 표현식, 숫자) : 지정된 자릿수의 값만 남기고 나머지는 버린다.
-- 양의 정수 : 소숫점 자릿수, 음의 정수 : -1, -2, -3은 각각 10의자리, 100의자리 1000의 자리다.
SELECT TRUNC(12.3), TRUNC(1234.5)
FROM DUAL;

SELECT TRUNC(12345.345, 1), TRUNC(12345.345, 2)
FROM DUAL;

SELECT TRUNC(12345.345, 0), TRUNC(12345.345, -1), TRUNC(12345.345, -2)
FROM DUAL;

-------------------------------------------------------------------------------------------------
-- 단일행 함수 : 날짜함수
-------------------------------------------------------------------------------------------------

-- SYSDATE : 시스템의 현재 날짜와 시간정보를 반환한다.
SELECT SYSDATE
FROM DUAL;

-- 날짜 + 정수 : 정수만큼 경과된 날짜
-- 날짜 - 정수 : 정수만큼 이전 날짜
-- 날짜 + 정수/24 : 정수시간만큼 경과된 날짜
-- 날짜 - 정수/24 : 정수시간만큼 이전 날짜
-- 날짜 - 날짜 : 두 날짜 사이의 일수
SELECT SYSDATE - 10 AS "10일전", SYSDATE + 10 AS "10일후"
FROM DUAL;

SELECT SYSDATE + 10/24 AS "10시간후"
FROM DUAL;

-- ROUND(날짜) : 정오를 넘어가면 1일 증가된 날짜정보를 반환한다.
-- TRUNC(날짜) : 시분초 정보가 0으로 변경된 날짜정보를 반환한다.
SELECT *
FROM SAMPLE_PRODUCTS
WHERE PRODUCT_CREATE_DATE >= TRUNC(SYSDATE) - 7;    -- 7일전

SELECT SYSDATE, TRUNC(SYSDATE), ROUND(SYSDATE)
FROM DUAL;

-- MONTHS_BETWEEN(날짜, 날짜) : 두 날짜사이의 개월수를 반환한다.
SELECT MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- ADD_MONTHS(날짜, 개월수) : 날짜에서 지정된 개월수 만큼 경과/이전 날짜를 반환한다.
-- ADD_MONTHS()함수가 반환하는 날짜는 제시된 날짜와 일자가 동일한 날짜를 반환한다.
SELECT SYSDATE, TRUNC(ADD_MONTHS(SYSDATE, 3))
FROM DUAL;

-- LAST_DAY(날짜): 지정된 날짜가 포함된 월의 마지막 날짜를 반환한다.
SELECT LAST_DAY(SYSDATE)
FROM DUAL;

-- ADD_MONTHS, LAST_DAY를 이용해서 현재 날짜를 기준으로 지난달에 입고된 상품을 조회하기
SELECT *
FROM SAMPLE_PRODUCTS
WHERE PRODUCT_CREATE_DATE >= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -2))) + 1
AND PRODUCT_CREATE_DATE < TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) + 1;

-- 오늘을 기준으로 이번달 1일부터 오늘까지의 날짜를 조회하기
SELECT TO_CHAR(TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) + LEVEL, 'YYYY-MM-DD') DAY
FROM DUAL
CONNECT BY TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) +  LEVEL <= SYSDATE;

-- 오늘을 기준으로 이번달 1일부터 오늘까지 날짜별로 상품 입고건수를 조회하기
SELECT B.DAY, NVL(A.CNT, 0)
FROM (SELECT TO_CHAR(PRODUCT_CREATE_DATE, 'YYYY-MM-DD') DAY, COUNT(*) CNT 
      FROM SAMPLE_PRODUCTS
      GROUP BY TO_CHAR(PRODUCT_CREATE_DATE, 'YYYY-MM-DD')) A,
     (SELECT TO_CHAR(TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) + LEVEL, 'YYYY-MM-DD') DAY
      FROM DUAL
      CONNECT BY TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) +  LEVEL <= SYSDATE) B
WHERE A.DAY(+) = B.DAY
ORDER BY B.DAY;






