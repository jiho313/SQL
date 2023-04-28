----------------------------------------------------------------------------------------------------------------------------------------------------
-- � ����
----------------------------------------------------------------------------------------------------------------------------------------------------
-- �޿��� 12000�� �Ѵ� ����� �̸��� �޿��� ��ȸ�ϱ�
select first_name, salary
from employees
where salary >= 1200;

-- �޿��� 5000�̻� 12000������ ����� �̸��� �޿��� ��ȸ�ϱ�
select first_name, salary
from employees
where salary >= 5000 and salary <= 12000
order by salary asc;

-- 2007�⿡ �Ի��� ����� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, to_char(hire_date, 'YYYY')
from employees
where hire_date >= '2007-01-01' and hire_date < '2008-01-01';

select employee_id, first_name, to_char(hire_date, 'YYYY')
from employees
where to_char(hire_date, 'YYYY') = '2007';

-- 20�� 50�� �μ��� �Ҽӵ� ����� �̸��� �μ���ȣ�� ��ȸ�ϰ�, �̸��� ���ĺ������� �����ؼ� ��ȸ�ϱ�
select first_name, department_id
from employees
where department_id in (20, 50);

-- �޿��� 5000�̻� 12000���ϰ�, 20���� 50�� �μ��� �Ҽӵ� ����� �̸��� �޿�, �μ���ȣ�� ��ȸ�ϱ�
select first_name, salary, department_id
from employees
where salary between 5000 and 12000
and department_id in (20, 50);

-- �����ڰ� ���� ����� �̸��� ����, �޿��� ��ȸ�ϱ�
select first_name, job_id, salary
from employees
where manager_id is null;

-- ������ 'SA_MAN'�̰ų� 'ST_MAN'�� �����߿��� �޿��� 8000�̻� �޴� ����� ���̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where job_id in ('SA_MAN', 'ST_MAN') 
and salary >= 8000;

-- ���� ���̺��� �������̵�, ��������, �����޿�, �ְ�޿��� ��ȸ�ϰ�,
-- �����޿�, �ְ�޿��� ���� �ð��� �ӱ��� ��ȸ�ϱ�
-- �޿��� �� �� 20��, �Ϸ� 8�ð� �ٹ� �����̴�.
-- �ð��� �ӱ��� ���� �ڸ��� �ݿø��ؼ� ǥ���Ѵ�.
select job_id, job_title,
            min_salary,
            max_salary, 
            round((min_salary/20/8)) as "�����޿��ð���",
            round((max_salary/20/8)) as "�ְ�޿��ð���"
from jobs;


-- ��� ����� �̸�, �������̵�, �޿�, �ҼӺμ����� ��ȸ�ϱ�
select emp.first_name,
    nvl(to_char(emp.department_id), '����'),
    emp.salary, 
    nvl(to_char(dep.department_name), '����') as department_name
from employees emp, departments dep
where emp.department_id = dep.department_id(+);

-- ��� ����� �̸�, �������̵�, ��������, �޿�, �ּұ޿�, �ִ�޿��� ��ȸ�ϱ�
select emp.first_name,
        emp.job_id, 
        job.job_title, 
        emp.salary,
        job.min_salary, 
        job.max_salary
from employees emp, jobs job
where emp.job_id = job.job_id;

-- ��� ����� �̸�, �������̵�, ��������, �޿�, �ּұ޿��� ���� �޿��� ���̸� ��ȸ�ϱ�
select emp.first_name,
        emp.job_id, 
        job.job_title, 
        emp.salary,
        job.min_salary, 
        (emp.salary - job.min_salary) as "�޿�����"
from employees emp, jobs job
where emp.job_id = job.job_id;

-- Ŀ�̼��� �޴� ��� ����� ���̵�, �μ��̸�, �ҼӺμ��� ������(���ø�)�� ��ȸ�ϱ�
select emp.employee_id,
        dep.department_name,
        loc.city 
from employees emp, departments dep, locations loc
where emp.commission_pct is not null
and emp.department_id = dep.department_id(+)
and dep.location_id = loc.location_id(+);

----------------------------------------------------------------------------------------------------------------------------------------------------
-- �� ����
----------------------------------------------------------------------------------------------------------------------------------------------------
-- �̸��� A�� a�� �����ϴ� ��� ����� �̸��� ����, ��������, �޿�, �ҼӺμ����� ��ȸ�ϱ�
select emp.first_name, emp.job_id, job.job_title, emp.salary, dep.department_name
from employees emp, jobs job, departments dep
where (first_name like 'A%' or first_name like 'a%')
and emp.department_id = dep.department_id
and emp.job_id = job.job_id;

-- 30, 60, 90�� �μ��� �ҼӵǾ� �ִ� ����� �߿��� 100���� �����ϴ� ������� �̸�, ����, �޿�, �޿������ ��ȸ�ϱ�
-- �� ���� emp.salary�� sgr.min_salary, sgr.max_salary
select emp.first_name, emp.job_id, emp.salary, sgr.grade
from employees emp, salary_grades sgr
where emp.department_id in (30, 60, 90)
and emp.salary >= sgr.min_salary and emp.salary <= sgr.max_salary
and emp.manager_id = 100
order by sgr.grade asc;


-- 80�� �μ��� �Ҽӵ� ������� �̸�, ����, ��������, �޿�, �ּұ޿�, �ִ�޿�, �޿����, �ҼӺμ����� ��ȸ�ϱ�
-- �� ���� emp.salary�� sgr.min_salary, sgr.max_salary
select emp.first_name,
        emp.job_id,
        job.job_title, 
        emp.salary, 
        job.min_salary, 
        job.max_salary, 
        sgr.grade, 
        dep.department_name
from employees emp,jobs job, salary_grades sgr, departments dep
where emp.department_id = 80
and emp.department_id = dep.department_id
and emp.job_id = job.job_id
and emp.salary >= sgr.min_salary and emp.salary <= sgr.max_salary;

----------------------------------------------------------------------------------------------------------------------------------------------------
-- ���� ����
----------------------------------------------------------------------------------------------------------------------------------------------------
-- ������߿��� �ڽ��� ��纸�� ���� �Ի��� ������� �̸�, �Ի���, ����� �̸�, ����� �Ի����� ��ȸ�ϱ�
select e.first_name as "�����̸�",
            e.hire_date as "�����Ի���", 
            em.first_name as "����̸�", 
            em.hire_date "����Ի���"
from employees e, employees em 
where e.manager_id = em.employee_id 
and e.hire_date < em.hire_date;

-- �μ����� IT�� �μ��� �ٹ��ϴ� ������� �̸���, ����, �޿�, �޿����, ����� �̸��� ������ ��ȸ�ϱ�
select e.first_name, e.job_id, e.salary, g.grade, em.first_name, em.job_id
from employees e, salary_grades g, employees em, departments d
where e.department_id = d.department_id
and d.department_name = 'IT'
and e.salary >= g.min_salary and e.salary <= g.max_salary
and e.manager_id = em.employee_id;

-- 'ST_CLERK'�� �ٹ��ϴٰ� �ٸ� �������� ������ ����� ���̵�, �̸�, ������ �μ���, ���� ����, ���� �ٹ��μ����� ��ȸ�ϱ�
select e.employee_id, 
        e.first_name,
        pd.department_name as "�������μ���",
        e.job_id as "��������",
        d.department_name as "����ٹ��μ���"
from employees e, job_history jh, departments d, departments pd
where jh.job_id = 'ST_CLERK'
and e.employee_id = jh.employee_id
and jh.department_id = pd.department_id
and e.department_id = d.department_id;

-- 'Toronto'���� �ٹ����� ������ ���̵�, �̸��� ��ȸ�ϱ�
select e.employee_id, e.first_name
from employees e, locations l, departments d
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.city = 'Toronto';

-- Ŀ�̼��� �޴� �������� �޿� ��޺��� �����ؼ� ������� ��ȸ�ϱ�
select g.grade, count(*)
from employees e, salary_grades g
where e.commission_pct is not null 
and e.salary >= g.min_salary and e.salary <= g.max_salary
group by g.grade;

--  ������ ���̵�, �̸�, Ŀ�̼��� ��ȸ�ϱ�. Ŀ�̼��� ���� �ʴ� ������ '����'���� ǥ���ϱ�
SELECT employee_id, first_name, NVL(TO_CHAR(commission_pct, 'fm0.99' ), '����')
FROM employees;

-- 'Europe'�� �������� �ΰ� �ִ� ��� �μ��� �μ����̵�� �μ��̸��� ��ȸ�ϱ�
select d.department_id, d.department_name
from departments d, locations l, countries c, regions r
where d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id
and r.region_name = 'Europe';


-- �޿������ 'E'����� ���� �߿��� 2005�⿡ �Ի��� ������ ���̵�, �̸�, �Ի���, �޿�, �ҼӺμ����̵�, �ҼӺμ����� ��ȸ�ϱ�
select e.employee_id, e.first_name, to_char(e.hire_date, 'YYYY'), e.salary, e.department_id, d.department_name, g.grade
from employees e, departments d, salary_grades g
where e.department_id = d.department_id
and e.salary >= g.min_salary and e.salary <= g.max_salary
and g.grade = 'E'
and e.hire_date >= '2005-01-01' and e.hire_date < '2006-01-01';

-- �������� ��޺��� �����ؼ� �λ�� �޿��� ��ȸ�ϱ�
-- A ���: 5% �λ�, B���: 7% �λ�, C���: 10% �λ�, D���: 12% �λ�, E���: 15% �̻�, �������� 20%�λ�
select e.employee_id, e.first_name, g.grade, e.salary,
     decode(g.grade, 'A', e.salary*1.05,
                     'B', e.salary*1.07,
                     'C', e.salary*1.1,
                     'D', e.salary*1.12,
                     'E', e.salary*1.15,
                     e.salary*1.2) as "�λ�ȱ޿�",
     decode(g.grade, 'A', 1.05,
                     'B', 1.07,
                     'C', 1.1,
                     'D', 1.12,
                     'E', 1.15,
                     1.2) as "�λ��"
from employees e, salary_grades g
where e.salary >= g.min_salary and e.salary <= g.max_salary;


