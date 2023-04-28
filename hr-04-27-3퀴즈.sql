-- employees ���̺��� ������� ��� �������̵� ��ȸ�ϱ�
select employee_id, job_id
from employees;

-- �޿��� 12,000�޷� �̻� �޴� ����� �̸��� �޿��� ��ȸ�ϱ�
select first_name, salary
from employees
where salary > 12000;

-- �����ȣ�� 176�� ����� ���̵�� �̸� ������ ��ȸ�ϱ�
select employee_id, first_name, job_id
from employees
where employee_id = 176;

-- �޿��� 12,000�޷� �̻� 15,000�޷� ���� �޴� ������� ��� ���̵�� �̸��� �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where salary >= 12000 and salary <= 15000;

-- 2005�� 1�� 1�Ϻ��� 2000�� 6�� 30�� ���̿� �Ի��� ����� ���̵�, �̸�, �������̵�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, job_id, hire_date
from employees
where hire_date >= '2005/01/30' and hire_date <= '2005/06/30';

-- �޿��� 5,000�޷��� 12,000�޷� �����̰�, �μ���ȣ�� 20 �Ǵ� 50�� ����� �̸��� �޿��� ��ȸ�ϱ�
select first_name, salary
from employees
where salary >= 5000 and salary <= 12000
and department_id in (20, 50);

-- �����ڰ� ���� ����� �̸��� �������̵� ��ȸ�ϱ�
select first_name, job_id
from employees
where manager_id is null;

-- Ŀ�̼��� �޴� ��� ����� �̸��� �޿�, Ŀ�̼��� �޿� �� Ŀ�̼��� ������������ �����ؼ� ��ȸ�ϱ�
select first_name, salary, commission_pct
from employees
where commission_pct is not null
order by salary desc;

select first_name, salary, commission_pct
from employees
where commission_pct is not null
order by commission_pct desc;

-- �̸��� 2��° ���ڰ� e�� ��� ����� �̸��� ��ȸ�ϱ�
select first_name
from employees
where substr(first_name, 2, 1) = 'e';

-- �������̵� ST_CLERK �Ǵ� SA_REP�̰� �޿��� 2,500�޷�, 3,500�޷�, 7,000�޷� �޴� ��� ����� �̸��� �������̵�, �޿��� ��ȸ�ϱ�
select first_name, job_id, salary
from employees
where job_id in ('ST_CLERK', 'SA_REP')
and salary in (2500, 3500, 7000);

-- ��� ����� �̸��� �Ի���, �ٹ� ���� ���� ����Ͽ� ��ȸ�ϱ�, �ٹ����� ���� ������ �ݿø��ϰ�, �ٹ��������� �������� ������������ �����ϱ�
select first_name, hire_date, round(months_between(sysdate, hire_date)) as �ٹ�������
from employees
order by �ٹ������� asc;

-- ��� ����� �̸�, �μ���ȣ, �μ��̸��� ��ȸ�ϱ�
select e.first_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

-- 80���μ��� �Ҽӵ� ����� �̸��� �������̵�, ��������, �μ��̸��� ��ȸ�ϱ�
select e.first_name, e.job_id, j.job_title, d.department_name
from employees e, jobs j, departments d
where e.department_id = 80
and e.department_id = d.department_id
and e.job_id = j.job_id;

-- Ŀ�̼��� �޴� ��� ����� �̸��� �������̵�, ��������, �μ��̸�, �μ������� ���ø��� ��ȸ�ϱ�
select e.first_name, e.job_id, j.job_title, d.department_name, l.city
from employees e, jobs j, departments d, locations l
where e.commission_pct is not null
and e.department_id = d.department_id(+)
and e.job_id = j.job_id(+)
and d.location_id = l.location_id(+);

-- ������ �������� �ΰ� �ִ� ��� �μ����̵�� �μ��̸��� ��ȸ�ϱ�
select d.department_id, d.department_name
from departments d, locations l, countries c, regions r
where r.region_name = 'Europe'
and r.region_id = c.region_id
and c.country_id = l.country_id
and l.location_id = d.location_id;

-- ����� �̸��� �ҼӺμ���, �޿�, �޿� ����� ��ȸ�ϱ�
select first_name, department_name, salary, g.grade
from employees e, departments d, salary_grades g
where e.department_id = d.department_id(+)
and e.salary >= g.min_salary and e.salary <= g.max_salary;

-- ����� �̸��� �ҼӺμ���, �ҼӺμ��� �����ڸ��� ��ȸ�ϱ�, �ҼӺμ��� ���� ����� �ҼӺμ��� '����, �����ڸ� '����'���� ǥ���ϱ�
select e.first_name, nvl(d.department_name, '����' ) �ҼӺμ�, nvl(dm.first_name, '����') �����ڸ�
from employees e, departments d, employees dm
where e.department_id = d.department_id(+)
and e.manager_id = dm.employee_id(+);

-- ��� ����� �޿� �ְ��, �޿� ������, �޿� �Ѿ�, �޿� ��վ��� ��ȸ�ϱ�
select max(salary), min(salary), sum(salary), avg(salary)
from employees;

-- ������ �޿� �ְ��, �޿� ������, �޿� �Ѿ�, �޿� ��վ��� ��ȸ�ϱ�
select job_id, max(salary), min(salary), sum(salary), avg(salary)
from employees 
group by job_id;

-- �� ������ ������� ��ȸ�ؼ� ���� ������� ���� ���� 3���� ��ȸ�ϱ�, �������̵�� ����� ǥ���ϱ�
-- rank() ������ ���� ���� ������ ������ �ο��ޱ� ������ �ش� �������� �������� �ʴ�.
select ranking, job_id, emp_count 
from (select dense_rank() over(order by emp_count desc)ranking,
      job_id, emp_count
      from (select job_id, count(*)emp_count
            from employees 
            group by job_id))
where ranking >= 1 and ranking <= 3;

-- �ึ�� �ٸ� ������ �ο��ޱ� ������ ������ �����ϴ�.
select emp_row, job_id, emp_count
from (select row_number() over(order by emp_count desc)emp_row,
      job_id, emp_count
      from (select job_id, count(*) emp_count
            from employees 
            group by job_id))
where emp_row <= 3;
