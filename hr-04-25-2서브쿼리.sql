-------------------------------------------------------------------------------------------
-- ��������
-------------------------------------------------------------------------------------------

-- ������ ��������
-- ���������� �������� 1�� 1���� ���
-- ������ �������� ������ : >, <, <=, >=, =, !=, <>

-- ��ü ������ ��ձ޿����� �޿��� ���� �޴� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�.
select employee_id, first_name, salary
from employees
where salary > ��ձ޿�;

select employee_id, first_name, salary
from employees
where salary > (select avg(salary)
                from employees);
                
-- ���� �޿��� ���� �޴� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where salary = (select min(salary)
                from employees );

-- ������ ��������
-- ���������� �������� N�� 1���� ���
-- ������ �������� ������ : in, any, all

-- 1700�� �������� ��ġ�� �μ����� �ٹ��ϴ� �������� ���̵�, �̸�, �μ����̵� ��ȸ�ϱ�
select employee_id, first_name, department_id
from employees
where department_id in (select department_id
                       from departments
                       where location_id = 1700);

-- ���������� ������� �ʾ��� ��
select e.employee_id, e.first_name, e.department_id
from employees e, departments d
where d.location_id = 1700
and d.department_id = e.department_id;

-- 60�� �μ��� �ٹ����� �������� �޿����� �޿��� ���� �޴� �������� �̸�, �޿��� ��ȸ�ϱ�
select first_name, salary
from employees
where salary > all (select salary
                    from employees
                    where department_id = 60);
/*
    > all�� ������������ ��ȸ�� ��� ������ ū ���� ��� true�� �����Ѵ�.
    
    where salary > all (select salary from)��
    where salary > (select max(salary) from)�� �����ϴ�.
*/
                    
select first_name, salary
from employees
where salary > any (select salary
                    from employees
                    where department_id = 60);                    
/*
    > any�� ������������ ��ȸ�� �� �߿��� ��� �ϳ����� ũ�⸸ �ص� true�� �����Ѵ�.
    
     where salary > any (select salary from)��   
     where salary > (select min(salary) form)�� �����ϴ�.
*/

-- ���߿� ��������
-- ���������� �������� N�� N���� ���
-- ���߿� �������� ������ : in

-- �� �μ��� �ְ� �޿��� �޴� ������ �޴� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�

select employee_id, first_name, salary, department_id
from employees
where (department_id, salary) in (select department_id, max(salary)
                                  from employees
                                  where department_id is not null
                                  group by department_id);

-- ���������� ����, 2���� ������� ��� �ذ��� ������ ���, ������ ������ ��������

-- 1700�� �������� ��ġ�� �μ����� �ٹ��ϴ� �������� ���̵�, �̸�, �μ����̵� ��ȸ�ϱ�
select employee_id, first_name, department_id
from employees
where department_id in (select department_id
                       from departments
                       where location_id = 1700);

-- ���������� ������� �ʰ� ������ ����� ���
select e.employee_id, e.first_name, e.department_id
from employees e, departments d
where d.location_id = 1700
and d.department_id = e.department_id;

-- �μ����� �������� �������� �� �������� ���� ���� �μ��� �Ҽӵ� �������� �̸��� ��ȸ�ϱ�
select first_name
from employees
where department_id in (select department_id
                       from employees
                       group by department_id
                       having count(*) in (select max(count(*))
                                          from employees
                                          group by department_id));
-- ���⼭ select�� ���� �ڹ��� return�� ����� �����ϱ�...?




 
                
            