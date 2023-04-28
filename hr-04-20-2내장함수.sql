--------------------------------------------------------------------------------------------------
-- ������ �Լ�: �����Լ�
--------------------------------------------------------------------------------------------------

-- LOWER(�÷��� Ȥ�� ǥ����) : �ҹ��ڷ� ��ȯ�ؼ� ��ȯ�Ѵ�.
-- UPPER(�÷��� Ȥ�� ǥ����) : �빮�ڷ� ��ȯ�ؼ� ��ȯ�Ѵ�.
SELECT LOWER(FIRST_NAME), UPPER(FIRST_NAME)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- SUBSTR(�÷��� Ȥ�� ǥ����, ������ġ) : �ؽ�Ʈ�� ������ġ�������� ������ �߶� ��ȯ�Ѵ�.
-- SUBSTR(�÷��� Ȥ�� ǥ����, ������ġ, ����) : �ؽ�Ʈ�� ������ġ�������� ������ ���̸�ŭ �߶� ��ȯ�Ѵ�.
SELECT FIRST_NAME, SUBSTR(FIRST_NAME, 3), SUBSTR(FIRST_NAME, 3, 1), SUBSTR(FIRST_NAME, 3, 2)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- LENGTH(�÷� Ȥ�� ǥ����) : �ؽ�Ʈ�� ���̸� ��ȯ�Ѵ�.
-- INSTR(�÷� Ȥ�� ǥ����, '�˻����ؽ�Ʈ') : �˻��� �ؽ�Ʈ�� ó������ �����ϴ� ��ġ�� ��ȯ�Ѵ�.
SELECT FIRST_NAME, LENGTH(FIRST_NAME), INSTR(FIRST_NAME, 'e')
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- LPAD(�÷� Ȥ�� ǥ����, ����, '�ؽ�Ʈ') : ���� ���̰� ������ ���� ���� ª���� ������ �ؽ�Ʈ�� ���ڶ� ������ŭ ���ʿ� �߰��Ѵ�. 
-- RPAD(�÷� Ȥ�� ǥ����, ����, '�ؽ�Ʈ') : ���� ���̰� ������ ���� ���� ª���� ������ �ؽ�Ʈ�� ���ڶ� ������ŭ �����ʿ� �߰��Ѵ�. 
SELECT FIRST_NAME, LPAD(FIRST_NAME, 10, '0'), RPAD(FIRST_NAME, 10, '0')
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

SELECT FIRST_NAME, REPLACE(FIRST_NAME, 'e', '*')
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

--------------------------------------------------------------------------------------------------
-- ������ �Լ�: �����Լ�
--------------------------------------------------------------------------------------------------

-- ROUND(�÷��� Ȥ�� ǥ����) : �Ҽ��� �ٷ� �Ʒ����� �ݿø��Ѵ�.
SELECT ROUND(12.3), ROUND(1234.5)
FROM DUAL;

-- ROUND(�÷��� Ȥ�� ǥ����, ����) : ������ �ڸ����� �ݿø��Ѵ�.
-- ���� ���� : �Ҽ��� �ڸ���, ���� ���� : -1, -2, -3�� ���� 10���ڸ�, 100���ڸ� 1000�� �ڸ���.
SELECT ROUND(12345.345, 1), ROUND(12345.345, 2)
FROM DUAL;

SELECT ROUND(12345.345, 0), ROUND(12345.345, -1), ROUND(12345.345, -2)
FROM DUAL;

-- ROUND(�÷��� Ȥ�� ǥ����, ����) : ������ �ڸ����� ���� ����� �������� ������.
-- ���� ���� : �Ҽ��� �ڸ���, ���� ���� : -1, -2, -3�� ���� 10���ڸ�, 100���ڸ� 1000�� �ڸ���.
SELECT TRUNC(12.3), TRUNC(1234.5)
FROM DUAL;

SELECT TRUNC(12345.345, 1), TRUNC(12345.345, 2)
FROM DUAL;

SELECT TRUNC(12345.345, 0), TRUNC(12345.345, -1), TRUNC(12345.345, -2)
FROM DUAL;

-------------------------------------------------------------------------------------------------
-- ������ �Լ� : ��¥�Լ�
-------------------------------------------------------------------------------------------------

-- SYSDATE : �ý����� ���� ��¥�� �ð������� ��ȯ�Ѵ�.
SELECT SYSDATE
FROM DUAL;

-- ��¥ + ���� : ������ŭ ����� ��¥
-- ��¥ - ���� : ������ŭ ���� ��¥
-- ��¥ + ����/24 : �����ð���ŭ ����� ��¥
-- ��¥ - ����/24 : �����ð���ŭ ���� ��¥
-- ��¥ - ��¥ : �� ��¥ ������ �ϼ�
SELECT SYSDATE - 10 AS "10����", SYSDATE + 10 AS "10����"
FROM DUAL;

SELECT SYSDATE + 10/24 AS "10�ð���"
FROM DUAL;

-- ROUND(��¥) : ������ �Ѿ�� 1�� ������ ��¥������ ��ȯ�Ѵ�.
-- TRUNC(��¥) : �ú��� ������ 0���� ����� ��¥������ ��ȯ�Ѵ�.
SELECT *
FROM SAMPLE_PRODUCTS
WHERE PRODUCT_CREATE_DATE >= TRUNC(SYSDATE) - 7;    -- 7����

SELECT SYSDATE, TRUNC(SYSDATE), ROUND(SYSDATE)
FROM DUAL;

-- MONTHS_BETWEEN(��¥, ��¥) : �� ��¥������ �������� ��ȯ�Ѵ�.
SELECT MONTHS_BETWEEN(SYSDATE, HIRE_DATE)
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;

-- ADD_MONTHS(��¥, ������) : ��¥���� ������ ������ ��ŭ ���/���� ��¥�� ��ȯ�Ѵ�.
-- ADD_MONTHS()�Լ��� ��ȯ�ϴ� ��¥�� ���õ� ��¥�� ���ڰ� ������ ��¥�� ��ȯ�Ѵ�.
SELECT SYSDATE, TRUNC(ADD_MONTHS(SYSDATE, 3))
FROM DUAL;

-- LAST_DAY(��¥): ������ ��¥�� ���Ե� ���� ������ ��¥�� ��ȯ�Ѵ�.
SELECT LAST_DAY(SYSDATE)
FROM DUAL;

-- ADD_MONTHS, LAST_DAY�� �̿��ؼ� ���� ��¥�� �������� �����޿� �԰�� ��ǰ�� ��ȸ�ϱ�
SELECT *
FROM SAMPLE_PRODUCTS
WHERE PRODUCT_CREATE_DATE >= TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -2))) + 1
AND PRODUCT_CREATE_DATE < TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) + 1;

-- ������ �������� �̹��� 1�Ϻ��� ���ñ����� ��¥�� ��ȸ�ϱ�
SELECT TO_CHAR(TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) + LEVEL, 'YYYY-MM-DD') DAY
FROM DUAL
CONNECT BY TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) +  LEVEL <= SYSDATE;

-- ������ �������� �̹��� 1�Ϻ��� ���ñ��� ��¥���� ��ǰ �԰�Ǽ��� ��ȸ�ϱ�
SELECT B.DAY, NVL(A.CNT, 0)
FROM (SELECT TO_CHAR(PRODUCT_CREATE_DATE, 'YYYY-MM-DD') DAY, COUNT(*) CNT 
      FROM SAMPLE_PRODUCTS
      GROUP BY TO_CHAR(PRODUCT_CREATE_DATE, 'YYYY-MM-DD')) A,
     (SELECT TO_CHAR(TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) + LEVEL, 'YYYY-MM-DD') DAY
      FROM DUAL
      CONNECT BY TRUNC(LAST_DAY(ADD_MONTHS(SYSDATE, -1))) +  LEVEL <= SYSDATE) B
WHERE A.DAY(+) = B.DAY
ORDER BY B.DAY;






