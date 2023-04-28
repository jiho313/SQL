-- �׷� ���� ���� ������ ���� ����Ʈ ���� ���� �� �ִ�.
-- ����۾��� ��� �б⺰ ����, ���� ����, ��ǰ�� ����
select job_id, avg(salary)
from employees
group by job_id;

-------------------------------------------------------------------------------------------
-- �׷��Լ�
-------------------------------------------------------------------------------------------
/*
    count(*)
        ��ȸ�� ��� ���� ������ ��ȯ�Ѵ�.
        
    count(�÷���)
        ������ �÷��� ���� null�� �ƴ� ���� ������ ��ȯ�Ѵ�.
    
    count(distinct �÷���)
        ������ �÷��� ���ؼ� �ߺ��� ���� �ѹ��� ������ ���� ������ ��ȯ�Ѵ�.
*/

-- employees ���̺� ��ϵ� ��� �������� ��ȸ�ϱ�
select count(*)
from employees;

-- employees ���̺��� Ŀ�̼��� ���� �������� ��ȸ�ϱ�
select count(commission_pct) -- commission_pct �÷��� ���� null�� �ƴ� ���� ���� ����.
from employees;

-- employees ���̺��� �������� �����ϰ� �ִ� �� ������ ���� ��ȸ�ϱ�
select count(distinct job_id)
from employees;



/*
    min(�÷���)
        ������ ���� �ּҰ��� ��ȯ�Ѵ�.
    max(�÷���)
        ������ ���� �ִ밪�� ��ȯ�Ѵ�.
    sum(�÷���)
        ������ ���� �հ踦 ��ȯ�Ѵ�.
    avg(�÷���)
        ������ ���� ����� ��ȯ�Ѵ�.
*/

select avg(commission_pct)
from employees;

-- ���� ���̺��� �ּұ޿�, �ִ�޿�, �޿��հ�, �޿������ ��ȸ�ϱ�
select min(salary), max(salary), sum(salary), avg(salary)
from employees;

-- ���� ���̺��� Ŀ�̼��� ���� ���ϴ� ������ ���� ��ȸ�ϱ�
select count(*)
from employees
where commission_pct is null;

-- ���� ���̺��� �޿������ 'D'�� ������ ���� ��ȸ�ϱ�
select count(*)
from employees e, salary_grades g
where e.salary >= g.min_salary
and e.salary <= g.max_salary
and g.grade = 'D';

-------------------------------------------------------------------------------------------
-- group by���� �̿��ؼ� ���ձ׷� �����ϰ�, �׷��Լ� �����ϱ�
-------------------------------------------------------------------------------------------

-- �μ��� ������� ��ȸ�ϱ�
select department_id, count(*)
from employees
GROUP by department_id
order by 1;

-- ������ ������� ��ȸ�ϱ�
select job_id, count(*)
from employees
GROUP by job_id
order by 1;

-- �Ի�⵵�� ������� ��ȸ�ϱ�
select to_char(hire_date, 'YYYY'), count(*)
from employees
GROUP by to_char(hire_date, 'YYYY')
order by 1;

-- �޿� �׼��� ������� ��ȸ�ϱ�
SELECT trunc(salary, -3), count(*)
from employees
GROUP by trunc(salary, -3)
order by 1;

-- �μ���, ������ ������� ��ȸ�ϱ�
SELECT department_id, job_id, count(*)
from employees
GROUP by department_id, job_id
order by 1, 2;

-- �μ��� ������� �������� ��, ������� 30�� �̻��� �μ��� ���̵�� ������� ��ȸ�ϱ�
select department_id, count(*)
from employees
GROUP by department_id
having count(*) >= 30
order by 1;

-- with���� �̿��ؼ� ��ȸ����� ĳ���ϱ�
with emp_count
as (select department_id, count(*) as cnt
    from employees
    group by department_id)
select department_id, cnt
from emp_count
where cnt >= 30;

-- 2005�� ���Ŀ� �Ի��� �������� �μ����� ������� ��ȸ���� ��, ��������10�� �̻���
-- �μ��� ���̵�� ������� ��ȸ�ϱ�
select department_id, count(*)
from employees
where hire_date >= '2006/01/01'
group by department_id
having count(*) >= 10;










