-- �������̺��� Ŀ�̼��� �޴� ��������
-- �������̵�, �̸�, �޿�, �������̵�, ��������, �ҼӺμ����̵�, �μ����� ��ȸ�ϱ�
select e.employee_id,
        e.first_name,
        e.salary, 
        j.job_id,
        j.job_title,
        d.department_name
from employees e, departments d, jobs j 
where e.department_id = d.department_id
and e.job_id = j.job_id
and e.commission_pct is not null;

-- �������̺��� 10, 20, 30, 40�� �μ��� �Ҽӵ� �������� 
-- �������̵�, �̸�, �������̵�, �ҼӺμ����̵�, �ҼӺμ���, �μ����������ø��� ��ȸ�ϱ�
select e.employee_id,
        e.first_name,
        e.job_id, 
        e.department_id,
        d.department_name,
        l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and d.department_id in (10, 20, 30, 40);

select e.employee_id,
        e.first_name,
        e.job_id, 
        d.department_id,
        d.department_name,
        l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and d.department_id between 10 and 40;

------------------------------------------------------------------------------------------
-- �����ο� ���� ���̺� ���� �� �� �߰�
------------------------------------------------------------------------------------------

create table salary_grades (
    grade char(1),
    min_salary number(8, 2),
    max_salary number(8, 2)
);
  
insert into salary_grades values('A', 50000, 99999);
insert into salary_grades values('B', 20000, 49999);
insert into salary_grades values('C', 10000, 19999);
insert into salary_grades values('D', 5000, 9999);
insert into salary_grades values('E', 2500, 4999);
insert into salary_grades values('F', 1000, 2499);
insert into salary_grades values('G', 0, 999);

-- 60�� �μ��� �Ҽӵ� �������� �������̵�, �̸�, �޿�, �޿������ ��ȸ�ϱ�
select e.employee_id, e.first_name, e.salary, g.grade, g.min_salary, g.max_salary
from employees e, salary_grades g
where e.department_id = 60
and e.salary >= g.min_salary and e.salary <= g.max_salary;

-- �޿������ F��޿� �ش��ϴ� �������� �������̵�, �̸�, �޿�, �������̵� ��ȸ�ϱ�
select e.employee_id, e.first_name, e.salary, e.job_id, g.grade
from employees e, salary_grades g
where e.salary >= g.min_salary and e.salary <= g.max_salary
and g.grade = 'F';

-- 10, 20, 30, 40�� �μ��� �Ҽӵ� ��������
-- �������̵�, �̸�, �������̵�, �޿�, �޿����, �ҼӺμ����̵�, �ҼӺμ����� ��ȸ�ϱ�
select e.employee_id,
        e.first_name,
        e.job_id,
        e.salary, 
        g.grade, 
        d.department_id,
        d.department_name
from employees e, departments d, salary_grades g
where salary >= g.min_salary and e.salary <= g.max_salary
and e.department_id = d.department_id
and d.department_id in (10, 20, 30, 40);

------------------------------------------------------------------------------------------
-- ��������
------------------------------------------------------------------------------------------

-- ��簡 �����Ǿ� �ִ� ��� �������� �������̵�, �̸�, ����� �̸��� ��ȸ�ϱ�
select emp.employee_id as emp_id, 
        emp.first_name as emp_name,
        mgr.first_name as mgr_name
from employees emp, employees mgr
where emp.manager_id is not null
and emp.manager_id = mgr.employee_id;

-- 10, 20, 30, 40�� �μ��� �Ҽӵ� ��������
-- �������̵�, �̸�, ������ ����̸�, �ҼӺμ����̵�, �ҼӺμ���, �ҼӺμ��� ������ �̸��� ��ȸ�ϱ�
-- employees�� 3�� �����ϴµ� ������ �뵵�� �°� ���� �����ؾ��Ѵ�.
-- emp       emp      emp_mgr         dep            dep         dep_mgr
select e.employee_id as �������̵�, 
        e.first_name as �����̸�,
        em.first_name as ����̸�, 
        e.department_id as �ҼӺμ����̵�,
        d.department_name as �ҼӺμ���,
        dm.first_name as �ҼӺμ��������̸�
from employees e, employees em, departments d, employees dm
where e.department_id in (10, 20, 30, 40) 
and e.manager_id = em.employee_id
and e.department_id = d.department_id
and d.manager_id = dm.employee_id;

------------------------------------------------------------------------------------------
-- ��������
------------------------------------------------------------------------------------------
-- �μ����̵�, �μ���, �μ������ھ��̵�, �μ��������̸��� ��ȸ�ϱ�
select d.department_id, 
        d.department_name,
        d.manager_id,
        e.first_name
from departments d, employees e
where d.manager_id = e.employee_id(+);
 
-- Ŀ�̼��� �޴� ��� ������ �������̵�, �̸�, �ҼӺμ����̵�, �ҼӺμ���, 
-- ���������̵�, ���������ø��� ��ȸ 
-- �ҼӺμ��� �������� �ʴ� ��������� ��ȸ
select e.employee_id,
        e.first_name,
        e.department_id,
        d.department_name,
        d.location_id,
        l.city
from employees e, departments d, locations l
where e.commission_pct is not null
and e.department_id = d.department_id(+)
and d.location_id = l.location_id(+);










