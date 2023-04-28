-- ������ ��ȸ

--------------------------------------------------------------------------------------------------
-- ���̺��� ��� ��(record), ��� ��(column)�� ��ȸ�ϱ�
-- select *
-- form ���̺��;
--------------------------------------------------------------------------------------------------

-- regions ���̺��� ��� ��, ��� �� ��ȸ�ϱ�
select *
from regions;
-- countries ���̺��� ��� ��, ��� �� ��ȸ�ϱ�
select *
from countries;
-- departments ���̺��� ��� ��, ��� �� ��ȸ�ϱ�
select *
from departments;
-- jobs ���̺��� ��� ��, ��� �� ��ȸ�ϱ�
select *
from jobs;

-- employees ���̺��� ��� ��, ��� �� ��ȸ�ϱ�
select *
from employees;

--------------------------------------------------------------------------------------------------
-- ���̺� ��� ���� ��ȸ�ϰ�, ������ �÷��� ��ȸ�ϱ�
-- select �÷���, �÷���, �÷���
-- from ���̺��;
-- * select ���� �� ������ �÷����� ,�� �����ʴ´�.
-- * �÷����� ������ ���̺��� �÷��� ������ ������� �ۼ��� �� �ִ�.
-- * �÷����� ��ҹ��ڸ� �������� �ʴ´�.
--------------------------------------------------------------------------------------------------

-- employees ���̺��� �������̵�, �����̸�(first_name), �̸���, ��ȭ��ȣ ��ȸ�ϱ�
select employee_id, first_name, email, phone_number
from employees;

-- employees ���̺��� �������̵� ��ȸ�ϱ�
select job_id
from employees;

-- employees ���̺��� �������̵� �ߺ����� ��ȸ�ϱ�
select DISTINCT job_id
from employees;

-- employees ���̺��� �������̵�, �μ����̵� ��ȸ�ϱ�
SELECT job_id, department_id
from employees;

-- employees ���̺��� �������̵�, �μ����̵� �ߺ����� ��ȸ�ϱ�
-- ����Ŭ������ null ���� ���� �������� �ʾҴٴ� ���̴�.
-- ���� null�� �Ͱ� ������ �ϸ� ���� null�̴�.
SELECT DISTINCT job_id, department_id
from employees;

--------------------------------------------------------------------------------------------------
-- ��ȸ�� �÷��� ��Ī ���̱�
-- select �÷��� as ��Ī, �÷��� as ��Ī, �÷��� as ��Ī
-- from ���̺��;

-- select �÷��� ��Ī, �÷��� ��Ī, �÷��� ��Ī
-- from ���̺��;
-- * as�� ������ �� �ִ�.
-- * ��Ī�� �����̳� ����Ŭ�� ���� ���ԵǾ� ���� ���� "��Ī" �������� �����Ѵ�.
-- * select������ ������� ����� ��ȸ�Ǿ� ���� �� ������� ����� ���ؼ� ��Ī�� �ο��� �� �ִ�.
--------------------------------------------------------------------------------------------------

-- employees ���̺��� employess_id, first_name, job_id�� ��ȸ�ϰ�,
-- ���� id, name, job�̶�� ��Ī�� �ο��ϱ�
select employee_id as id, first_name as name, job_id as job
from employees;

-- employees ���̺��� employess_id, first_name, last_name�� ��ȸ�ϰ�,
-- first_name�� last_name�� ���ļ� imployee_name ��Ī�� �ٿ��� ��ȸ�ϱ�
-- �÷��� || �÷��� �� ���� �÷��� ���� �����Ͽ� �ϳ��� ���ڿ��� �����. ��Ī�� �����ڸ� ������ ������ ǥ�õȴ�.
SELECT employee_id, first_name || last_name as employee_name
from employees;

-- employees ���̺��� employess_id, first_name, last_name�� ��ȸ�ϰ�,
-- first_name�� last_name�� ���ļ� ��ȸ�ϱ�
-- ����, "��� ���̵�", "��� �̸�"�� ��Ī�� ���̱�
SELECT employee_id as "��� ���̵�", first_name || last_name as "��� �̸�"
from employees;

--------------------------------------------------------------------------------------------------
-- ���� ����(������ ���͸�)
-- ���̺�(�����̼�)���� ���õ� ������ �����ϴ� �ุ ��ȸ�ϱ�
-- select *
-- from ���̺��
-- where ���ǽ�
-- * ���õ� ���ǽ��� true�� �����Ǵ� �ุ ��ȸ�Ѵ�.

-- ����Ŭ�� �� ������
-- equal:            =
-- not equal:        !=, <>
-- greaterThan:      >
-- gteaterEqual      >=        
-- lessThan          <
-- lessEqual         <=

-- ����Ŭ�� �� ������
-- ����          and
-- ����          or
-- ������        not
--------------------------------------------------------------------------------------------------

-- employees ���̺��� �ҼӺμ� ���̵� 60���� ������ ���̵�, �̸�, �ҼӺμ����̵� ��ȸ
select employee_id, first_name, department_id
from employees
where department_id = 60;

-- employees ���̺��� first_name�� 'Steven' ������ ���̵�, �̸�, �������̵� ��ȸ�ϱ�
-- ����Ŭ���� �ؽ�Ʈ �����ʹ� ''�� ���Ѵ�. ""�� ��Ī, �÷����� ���Ѵ�.
-- ���� �����ʹ� ��ҹ��ڸ� �����ϰ� �����Ѵ�.
select employee_id, first_name, job_id
from employees
where first_name = 'Steven';

-- employees ���̺��� �޿��� 10000�̻� �޴� ������ ���̵�, �̸�, �������̵�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where salary >= 10000;

-- departments ���̺��� location_id�� 1700�� �μ��� ���̵�, �μ� �̸�, lolocation_id ��ȸ�ϱ�
select department_id, department_name, location_id
from departments
where location_id = 1700;

-- employees ���̺��� �޿��� 10000�̻� 15000���Ϸ� �޴� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where salary >= 10000 and salary <= 15000;

-- employees ���̺��� �Ҽ� �μ� ���̵� 50���� ������ �ҼӺμ� ���̵� 80����
-- ������ ���̵�, �̸�, �Ҽ� �μ� ���̵� ��ȸ�ϱ�
select employee_id, first_name, salary, department_id
from employees
where department_id = 50 or department_id = 80;

-- employees ���̺��� �ҼӺμ����̵� 50 Ȥ�� 80���� �μ��� �ҼӵǾ� �ְ�,
-- �޿��� 3000�̸����� �޴� ������ ���̵�, �޿�, �ҼӺμ� ���̵� ��ȸ�ϱ�
select employee_id, salary, department_id
from employees
where (department_id = 50 or department_id = 80) and salary < 3000
-- �޿��� ������������ �����ϱ�
-- order by salary asc;
-- �޿��� ������������ �����ϱ�
order by salary desc;


--------------------------------------------------------------------------------------------------
-- ��ȸ����� ��������, ������������ �����ϱ�
-- select �÷���, �÷���, �÷���
-- from ���̺��
-- where ���ǽ�
-- order by �÷���, asc;
-- * order by ���� select�������� �׻� �� �������� ���Եȴ�.
-- * order by ���� ������ �÷��� ���� �������� ��������, ������������ ������ �� �ִ�.
-- * ���Ĺ����� �������� ������ �⺻������ ���������̴�.
-- * asc�� �������� ����, desc�� �������� �����̴�.
--------------------------------------------------------------------------------------------------

-- employees ���̺��� �޿��� 10000�޷� �̻� �޴� ������ �޿�, �������̵�, �̸��� ��ȸ�ϱ�
-- ��ȸ����� �޿������� �������� �����Ѵ�
SELECT salary, job_id, first_name
from employees
where salary >= 10000
order by salary asc;

--------------------------------------------------------------------------------------------------
-- ���ǽĿ��� ��밡���� ��Ÿ ������
-- where �÷��� between ���Ѱ� and ���Ѱ�
-- * ������ �÷��� ���� A���̻� B�������� ���� �� true�� �����Ѵ�.
-- * where �÷��� >= ���Ѱ� and �÷��� <= ���Ѱ�; �� ���ǽİ� �����ϴ�.

-- where �÷��� in (��1, ��2, ��3)
-- * ������ �÷��� ���� ���õ� ��1, ��2, ��3 �߿��� �ϳ��� ��ġ�ص� true�� �����Ѵ�.
-- * where �÷��� = ��1 or �÷��� = ��2 or �÷��� = ��3; �� ���ǽİ� �����ϴ�.

-- where �÷��� like '����'
-- * ������ �÷��� ���� ���õ� ���ϰ� ��ġ�ϸ� true�� �����Ѵ�.
-- * ���Ϲ���
--  '%'     -> 0�� �̻��� ������ ���ڸ� ��Ÿ����.
--  '_'     -> ������ ���� �ϳ��� ��Ÿ����.
-- * where employee_name like '��_';   <------- '��Ȳ', '����'�� ���� true�� �����ȴ�.
-- * where book_title like '�ڹ�%';    <------- '�ڹ�', '�ڹ��� ����'�� ���� true�� �����ȴ�.
-- * where employee_name like '��_%';  <------- '����', '��Ȳ', '�̼���', '�̼������Ͽ��۾Ʊ�' true
--------------------------------------------------------------------------------------------------

-- �޿��� 15000�̻� 20000���Ϸ� �޴� ������ ���̵�, �̸�, �޿�, ������ ��ȸ�ϱ�
select employee_id, first_name, salary, job_id
from employees
--where salary >= 15000 and salary <= 20000;
where salary between 15000 and 20000;

-- 10, 20, 30�� �μ��� �Ҽӵ� ������ ���̵�, �̸�, �ҼӺμ��� ��ȸ�ϱ�
select employee_id, first_name, department_id
from employees
-- where department_id = 10 or  department_id = 20 or department_id = 30; 
where department_id in (10, 20, 30);

-- 10, 20, 30�� �μ��� �Ҽӵ� ���� �߿��� �޿��� 5000�̻� �޴� ������ ���̵�, �̸�, �޿�, �ҼӺμ��� ��ȸ
select employee_id, first_name, salary, department_id
from employees
where department_id in (10, 20, 30) and salary >= 5000;


commit;


