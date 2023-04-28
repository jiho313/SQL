--------------------------------------------------------------------------------------------
-- ����
--------------------------------------------------------------------------------------------

--�μ����̺��� ��� �μ� ������ ��ȸ�ϱ�
select *
from departments;

select department_id, department_name, manager_id, location_id
from departments;

--�μ����̺��� ��ġ���̵� 1700���� �ƴ� �μ� ���� ��ȸ�ϱ�
select department_id, department_name, manager_id, location_id
from departments
where location_id != 1700;

-- ����Ŭ ���� <> ���� ������
select department_id, department_name, manager_id, location_id
from departments
where location_id <> 1700;

--100����� �����ϴ� �μ��� ���� ��ȸ�ϱ�
select department_id, department_name, manager_id, location_id
from departments
where manager_id = 100;


--�μ����� 'IT'�� �μ��� ���� ��ȸ�ϱ�
select department_id, department_name, manager_id, location_id
from departments
where department_name = 'IT';


--��ġ���̵� 1700���� ������ �ּ�, �����ȣ, ���ø�, �����ڵ带 ��ȸ�ϱ�
select street_address, postal_code, city, country_id, location_id
from locations
where location_id = 1700;

--�ּұ޿��� 2000�̻� 5000������ ������ �������̵�, ��������, �ּұ޿�, �ִ�޿� ��ȸ�ϱ�
select job_id, job_title, min_salary, max_salary
from jobs
where min_salary >= 2000 and min_salary <= 5000;


--�ִ�޿��� 20000���� �ʰ��ϴ� ������ ���̵�, ��������, �ּұ޿�, �ִ�޿� ��ȸ�ϱ�
select job_id, job_title, min_salary, max_salary
from jobs
where max_salary > 20000;

--100�� ������ �������� �����ϴ� ����� ���̵�, �̸�, �μ����̵��� ��ȸ�ϱ�
select employee_id, first_name, department_id, manager_id
from employees
where manager_id = 100;

--80�� �μ����� �ٹ��ϰ� �޿��� 8000�� �̻� �޴� ����� ���̵�, �̸�, �޿�, Ŀ�̼�����Ʈ ��ȸ�ϱ�
select employee_id, first_name, salary, commission_pct
from employees
where department_id = 80;

--������ SA_REP�̰�, Ŀ�̼�����Ʈ�� 0.25�̻��� ����� ���̵�, �̸�, �޿�, Ŀ�̼�����Ʈ�� ��ȸ�ϱ�
select employee_id, first_name, salary, commission_pct
from employees
where job_id = 'SA_REP' and commission_pct > 0.25;

--80�� �μ��� �ٹ��ϰ�, �޿��� 10000�� �̻��� ����� ���̵�, �̸�, �޿�, ������ ��ȸ�ϱ�
--���� = (�޿� + �޿�xĿ�̼�)x12��
select employee_id, first_name, salary, ((salary + salary * commission_pct)*12) as "����"
from employees
where department_id = 80 and salary > 10000;

--80�� �μ��� �ٹ��ϰ�, 147�� �������� �����ϴ� ��� �߿��� Ŀ�̼��� 0.1�� ����� ������̵�, �̸�, ����, �޿�, Ŀ�̼�����Ʈ�� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary, commission_pct, manager_id
from employees
where department_id = 80 and manager_id != 147 and commission_pct = 0.1;

--������� �����ϴ� ������ �ߺ����� ��ȸ�ϱ�
select DISTINCT job_id
from employees;

--������� �Ҽӵ� �μ����̵� ��� ��ȸ�ϱ�
select distinct department_id
from employees
where department_id is not null;

--�޿��� 5,000�޷��� 12,000�޷� �����̰�, �μ���ȣ�� 20 �Ǵ� 50�� ����� �̸��� �޿��� ��ȸ�ϱ�
select employee_id, salary
from employees
where salary between 5000 and 12000 and department_id in (20, 50);

--������ 'SA_MAN'�̰ų� 'ST_MAN'�� �����߿��� �޿��� 8000�̻� �޴� ����� ���̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where job_id in ('SA_MAN', 'ST_MAN') and salary >= 8000;