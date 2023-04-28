-- departments ���̺�� locations ���̺��� �����ϱ�
-- ���� ��ȸ�Ϸ��� ������ ��� ���̺� �����ϴ��� �˰� �־���ϰ�, � �ʵ带 �Ű��� 
-- �����ؾ� �ϴ����� �˰� �־���Ѵ�.
select a.department_id,
        a.department_name,
        b.city,
        b.postal_code,
        b.street_address
-- ���̺�� ��Ī�� ������ �� �ִ�.
from departments a, locations b -- from���� �Է��ϴ� �� �����ε� ���� ����
where a.location_id = b.location_id; -- ���� ����

-----------------------------------------------------------------------------------------------
-- ����
-----------------------------------------------------------------------------------------------

/*
    �����
        �÷��� ���� ���� �ͳ��� ���� �����ϴ� ��
*/
-- �������̵�, �����̸�, �ҼӺμ����̵�, �ҼӺμ����� ��ȸ�ϱ�
-- employees employees employees     departments
-- ������ ���̺�: employees, departments
-- ���ο� �����ϴ� �÷�: employees�� department_id,departments�� department_id
select e.employee_id, e.first_name, e.department_id, d.department_name, d.manager_id
from employees e, departments d;


-- �������̵�, �����̸�, ������ �������̵�, �޿�, �ش������� �ּұ޿�, �ش������� �ִ�޿� ��ȸ
-- emp          emp         emp         emp         jobs              jobs
select e.employee_id,
        e.first_name,
        e.job_id,
        e.salary,
        j.min_salary,
        j.max_salary
from employees e, jobs j
where e.job_id = j.job_id;

-- �μ����̺��� �ش� �μ��� �����ϴ� ������ �����Ǿ� �ִ� �μ��� �������
-- �μ����̵�, �μ���, �μ��� �����ϴ� ������ �̸�, ������ �������̵� ��ȸ�ϱ�
-- �������ǿ� �����ϴ� �÷�:departments�� maneger_id�� employees�� employee_id
-- �μ����̺��� �����ھ��̵�� �������̺��� �������̵� ���� �ೢ�� ���ε� �͸� ��ȸ�Ѵ�.
select d.department_id,
        d.department_name,
        e.first_name,
        e.employee_id,
        d.manager_id,
        e.job_id
from departments d, employees e
where d.manager_id = e.employee_id
and d.manager_id is not null;

-- ���� �����޿��� ���� �ְ�޿��� �߰������� �޿��� �� ���� �ް� �ִ�
-- jobs              jobs
-- ������ ���̵�, �̸�, �������̵�, �޿��� ��ȸ�ϱ�
-- emp           emp    emp      emp
select e.employee_id,
        e.first_name,
        e.job_id, 
        e.salary,
        ((j.min_salary + j.max_salary)/2) as average_salary,
        j.min_salary,
        j.max_salary
from employees e, jobs j
where e.job_id = j.job_id
and e.salary > ((j.min_salary + j.max_salary)/2);

-- ������ ���̵�, ������ �̸�, ������ �ҼӺμ����̵�, ������ �����ϰ� �ִ� ������ ������ ��ȸ�ϱ�
-- �������ǿ� �ʿ��� �÷�
-- ������ �ҼӺμ��̸�: employees�� department_id�� departments�� department_id�� ���� ��
-- ������ ��������: employees�� job_id�� jobs�� job_id�� ���� ��
-- ������ ���̺��� ���� -1�� where������ �־�� �Ѵ� ������� ��� �������� �� ���� ���� �ִ�.
select e.employee_id,
        e.first_name,
        d.department_id ,
        j.job_title
from employees e, departments d,jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id;

-- �μ����̺��� �ش� �μ��� �����ϴ� ������ ����Ǿ� �ִ� �μ��� �������
-- �μ����̵�, �μ���, �ش� �μ��� ������ �̸�, �������� ��ȭ��ȣ, ������ ���ø�, ������ �ּҸ� ��ȸ�ϱ�

select d.department_id, 
        d.department_name,
        e.first_name, 
        e.phone_number, 
        l.city, 
        l.street_address
from departments d, employees e, locations l
where d.manager_id is not null 
and d.department_id = e.department_id
and d.location_id = l.location_id;






