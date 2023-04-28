---------------------------------------------------------------------------------------------------
-- ����� ���� �� ��ü �����ϱ�
---------------------------------------------------------------------------------------------------

-- emp_salary_details_view �����ϱ�
-- �������̵�, �̸�, �������̵�, ��������, �����ּұ޿�, �����ִ�޿�,
-- �޿�, �޿����, Ŀ�̼�, ����
create or replace view emp_salary_details_view
as
    select
        e.employee_id,
        e.first_name,
        e.job_id,
        j.job_title,
        j.min_salary,
        j.max_salary,
        e.salary,
        g.grade,
        nvl(e.commission_pct, 0) commission_pct,
        trunc(e.salary*12+ salary*nvl(commission_pct, 0)*12) annual_salary
    from employees e, jobs j, salary_grades g
    where e.job_id = j.job_id
    and e.salary >= g.min_salary and e.salary <= g.max_salary
with read only;

-- �޿���޺� ����� ��ȸ�ϱ�
select g.grade, count(*) 
from employees e, salary_grades g
where e.salary >= g.min_salary and e.salary <= g.max_salary
group by g.grade;

-- ������ �� ��ȸ�ϱ�
select *
from emp_salary_details_view;

-- emp_salary_details_view �並 �̿��ؼ� �޿���޺� ����� ��ȸ�ϱ�
select grade, count(*)
from emp_salary_details_view
group by grade;

-- �������̵�, ���� �̸�, ��������, �޿�, �޿����, ������ ��ȸ�ϱ�
select e.employee_id,
        e.first_name, 
        j.job_title,
        e.salary, 
        g.grade, 
        e.salary*12 + e.salary*nvl(e.commission_pct, 0)*12 as annual_salary
from employees e, jobs j, salary_grades g
where e.job_id = j.job_id
and e.salary >= g.min_salary and e.salary <= g.max_salary;

-- emp_salary_details_view �並 �̿��ؼ� �������̵�, ���� �̸�, ��������, �޿�, �޿����, ������ ��ȸ�ϱ�
select employee_id,
        first_name, 
        job_title,
        salary, 
        grade,
        annual_salary
from emp_salary_details_view;

-- �μ� �������� �����ϴ� ��
-- �μ����̵�, �μ���, ������ ���̵�, ������ �̸�,
-- ������ ���̵�, ��������, �����ȣ, �ּ�,�������̵�, ������, �������̵�, ������
create or replace view dept_details_view
as
    select d.department_id,
            d.department_name, 
            m.manager_id,
            m.first_name as manager_name,
            d.location_id,
            l.city, 
            l.postal_code, 
            l.country_id,
            c.country_name, 
            c.region_id,
            r.region_name
    from departments d, employees m, locations l, countries c, regions r
    where d.manager_id = m.employee_id
    and d.location_id = l.location_id
    and l.country_id = c.country_id
    and c.region_id = r.region_id
with read only;

-- 60�� �μ����� �ٹ����� �������� �̸�, �μ���, ����, ����, ���� ��ȸ�ϱ�
select e.first_name, d.department_name, d.city, d.country_name, d.region_name
from employees e, dept_details_view d
where e.department_id = 60
and e.department_id = d.department_id;

-- 60�� �μ��� ������ ��ȸ�ϱ�
select *
from dept_details_view
where department_id = 60;


select department_id
from employees;

select department_id,(count(*))
from employees
group by department_id;





















