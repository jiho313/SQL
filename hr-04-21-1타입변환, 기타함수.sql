--------------------------------------------------------------------------------------------
-- ������ Ÿ�� ��ȯ
--------------------------------------------------------------------------------------------
select *
from departments
where department_id = 10;

-- department_id �÷��� Ÿ���� ���� Ÿ���̾ �ؽ�Ʈ '10;�� ���� 10�� ��ȯ�Ǿ���.
select *
from departments
where department_id = '10';

select product_name, product_create_date, trunc(sysdate-7)
from sample_product
where product_create_date >= trunc(sysdate - 7);

-- product_create_date �÷��� Ÿ���� dateŸ�����̼� �ؽ�Ʈ '2023-04-14'�� dateŸ������ ��ȯ�Ǿ���.
select *
from sample_product
where product_create_date >= '2023-04-14';



-- �Ʒ��� SQL ��ɾ�� ������.
-- where product_create_date >= '2023-04-21' - 7; ������
-- '2023-04-21' - 7 ������ ���� ����Ǵµ�, ���� ������ �����ϱ� ���ؼ� '2023-04-21' ���ڷ� ��ȯ�� �� ����.
-- ���� �������� 7������ ��ϵ� ��ǰ�� ��ȸ�ϱ� ���ؼ��� '2023-04-21'�� date Ÿ������ ��ȯ�ϴ� ����� ����ȯ�� �ʿ��ϴ�.
select *
from sample_product
where product_create_date >= '2023-04-21'- 7;

-- �Ʒ��� �ڵ�� ����
select *
from sample_product
where product_create_date >= to_date('2023/04/14') - 7;

--------------------------------------------------------------------------------------------
-- ����� Ÿ�� ��ȯ
--------------------------------------------------------------------------------------------
/*
����� ����ȯ 
    �ؽ�Ʈ-���� -- �� �Ⱦ�
        �ؽ�Ʈ -> ����
        to_number('����') 
            to_number('10')     -> 10
            to_number('3.14')   -> 3.14
        to_number('�ؽ�Ʈ', '����')
            to_number('10,000,000', '99,999,999')   -> 10000000
        
        ���� -> 
        to_char(����)
            to_char(10)             -> '10'
        
        to_char(����, '����������')
            to_char(1000000, '9,999,999') -> '1,000,000'
            to_char(123.456, '999.99')   -> '123.45'
            
    �ؽ�Ʈ-��¥
        �ؽ�Ʈ -> ��¥
            to_date('2023-04-23')               -> date
            to_date('2023-04-20', 'YYYY-MM-DD') -> date
            to_date('2023-04-20 15:31:30', 'YYYY-MM-DD HH24:MI:SS') -> date
        ��¥ -> �ؽ�Ʈ
            to_char(sysdate, 'YYYY')                    -> '2023'
            to_char(sysdate, 'MM')                      -> '04'
            to_char(sysdate, 'DD')                      -> '21'
            to_char(sysdate, 'YYYY-MM')                 -> '2023-04'
            to_char(sysdate, 'YYYY-MM-DD')              -> '2023-04-21'
            to_char(sysdate, 'YYYY-MM-DD' HH24')        -> '2023-04-21 10'
            to_char(sysdate, 'YYYY-MM-DD' HH24:MI:SS')  -> '2023-04-21 10:08:23'
            
*/

-- '1000' - 100 �� ������ ����� ����ȯ, ������ ����ȯ ��� �����Ѵ�.
select '1000' - 100, to_number('1000') - 100
from dual;

-- '1,000' - 100 �� ������ ������ ����ȯ�� ������� �ʴ´�. ����� ����ȯ�� �� �ʿ��ϴ�.
SELECT to_number('1,000','9,999') - 100
from dual;

-- �ڹٿʹ� �ٸ��� �ڸ����� ���ų� ���� �ؾ� ����ȴ�.
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

-- �̰� �� �´� ��� �������� �º��� �������� ���ƾ� �Ѵ�.
select hire_date, employee_id, first_name
from employees
where hire_date >= '2005-01-01' and hire_date < '2006-01-01';

--------------------------------------------------------------------------------------------
-- ��Ÿ �Լ�
--------------------------------------------------------------------------------------------
/*
��Ÿ �Լ�
    nvl(�÷��� Ȥ�� ǥ����, ��)
        �÷��� Ȥ�� ǥ������ ���� null�� �ƴϸ� �÷��� Ȥ�� ǥ������ ���� ��ȯ�ȴ�.
        �÷��� Ȥ�� ǥ������ ���� null�̸� ������ ���� ��ȯ�ȴ�.
        * �÷��� Ȥ�� ǥ������ Ÿ�԰� ���� Ÿ���� ��ġ�ؾ� �Ѵ�. ȥ���ؼ� ����� ��� to_char�̳� to_number�� ����ȯ�Ѵ�
        
    nvl2(�÷��� Ȥ�� ǥ����, ��1, ��2)
        �÷��� Ȥ�� ǥ������ ���� null�� �ƴϸ� ����1 ��ȯ�ȴ�.
        �÷��� Ȥ�� ǥ������ ���� null�̸� ������ ����2 ��ȯ�ȴ�.   
        * ��1�� ��2�� Ÿ���� ��ġ�ؾ� �Ѵ�. 
        
    -- ���� ������ ������ �ڹٿ��� Ȱ���� ��  null���� ������ �ʱ� ������ ����
*/


-- ��� �������� ������ ��ȸ�ϱ�
-- �������̵�, �̸�, �޿�, Ŀ�̼�, ������ ����ϱ�
-- ���� -> �޿�*12 + �޿�*Ŀ�̼�*12

select employee_id, first_name, salary, commission_pct,
    salary*12 + salary*commission_pct*12 as annual_salary
from employees;

-- ���� �� �Ǵ� ǥ������ ��Ī ����: ���� ���� �Ǵ� ǥ������ ����� ��Ī���� ǥ���� ��,
-- AS Ű���带 ������ �� �ֽ��ϴ�. (����) annual_salary

select employee_id, first_name, salary, commission_pct,
    salary*12 + salary*nvl(commission_pct, 0)*12 annual_salary
from employees;


/*
    decode(�÷��� Ȥ�� ǥ����, ��1, �� Ȥ�� ǥ����,
                            ��2, �� Ȥ�� ǥ����,
                            ��3, �� Ȥ�� ǥ����)       
            �÷��� Ȥ�� ǥ������ ���� ��1�� ��ġ�ϸ� ǥ����1�� decode�Լ��� �������� �ȴ�.
            �÷��� Ȥ�� ǥ������ ���� ��1�� ��ġ�ϸ� ǥ����2�� decode�Լ��� �������� �ȴ�.
            �÷��� Ȥ�� ǥ������ ���� ��1�� ��ġ�ϸ� ǥ����3�� decode�Լ��� �������� �ȴ�.
            �÷��� Ȥ�� ǥ������ ���� ��1, ��2, ��3 ���� ��ġ���� ������ decode�Լ��� �������� null�� �ȴ�.
                            
    decode(�÷��� Ȥ�� ǥ����, ��1, �� Ȥ�� ǥ����,
                            ��2, �� Ȥ�� ǥ����,
                            ��3, �� Ȥ�� ǥ����,
                            ǥ����4)
            �÷��� Ȥ�� ǥ������ ���� ��1�� ��ġ�ϸ� ǥ����1�� decode�Լ��� �������� �ȴ�.
            �÷��� Ȥ�� ǥ������ ���� ��1�� ��ġ�ϸ� ǥ����2�� decode�Լ��� �������� �ȴ�.
            �÷��� Ȥ�� ǥ������ ���� ��1�� ��ġ�ϸ� ǥ����3�� decode�Լ��� �������� �ȴ�.
            �÷��� Ȥ�� ǥ������ ���� ��1, ��2, ��3 ���� ��ġ���� ������ ǥ����4�� decode�Լ��� �������� �ȴ�.                 
                            
    -- �ڹ��� caseŰ����� ����ϴ�.
                            
*/

-- ������ �߿��� 60�� �μ��� �Ҽӵ� ������ �޿��� 10%�λ�� �ݾ����� ��ȸ�ϰ�,
--              50�� �μ��� �Ҽӵ� ������ �޿��� 5%�λ�� �ݾ����� ��ȸ�ϰ�,
--              �� �� �μ��� �Ҽӵ� ������ �޿��� 3%�λ�� �ݾ����� ��ȸ�ϱ�

select employee_id, first_name, department_id, salary,
        decode(department_id, 60, salary*1.1,
                              50, salary*1.05,
                              salary*1.03) as increment_salary
from employees
order by employee_id asc;

-- �λ���� �Բ� ������ �ϰ� ���� ��
SELECT employee_id, first_name, department_id, salary,
    decode(department_id, 60, salary * 1.1,
                        50, salary * 1.05,
                        salary * 1.03) AS increment_salary,
    decode(department_id, 60, 1.1,
                        50, 1.05,
                        1.03) AS increment_rate
FROM employees;

/*
    case ����
        case   
            when ���ǽ�1 then ǥ����1
            when ���ǽ�2 then ǥ����2
        end
        
        case   
            when ���ǽ�1 then ǥ����1
            when ���ǽ�2 then ǥ����2
            else ǥ����
        end
        * ���ǽĿ� �پ��� �񱳿����ڿ� �������� ����� �� �ִ�.
        
        case �÷� Ȥ�� ǥ����
            when ���ǽ�1 then ǥ����1
            when ���ǽ�2 then ǥ����2
        end
        
        case �÷� Ȥ�� ǥ����
            when ���ǽ�1 then ǥ����1
            when ���ǽ�2 then ǥ����2
            else ǥ����3
        end
        * �÷� Ȥ�� ǥ������ ���� when�� ���õ� ���� ��ġ���θ��� ������ � ǥ������ �������� ���� �����Ѵ�.
*/

-- �������� �޿��� �λ��ؼ� ��ȸ�ϱ�
-- �޿��� 2000���Ϸ� �޴� ������ 20%�λ�
-- �޿��� 5000���Ϸ� �޴� ������ 15%�λ�
-- �޿��� 10000���Ϸ� �޴� ������ 10%�λ�
-- �� �ܴ� 5% �λ�� �ݾ����� �޿��� ��ȸ�غ���
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

-- �λ���� �Բ� ����
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

-- �Ի�⵵�� �������� ���� ������
-- 2002�� a, 2003�� b, 2004�� c ,,,
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

-- �����񱳴� ���ڵ�, �� ����� ���̽� ��
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




