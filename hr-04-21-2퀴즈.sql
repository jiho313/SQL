-- EMPLOYEES ���̺��� �̸��� 8���� �������� �̸��� ��ȸ�ϱ�
select first_name
from employees
where length(first_name)= 8;

-- EMPLOYEES ���̺��� �̸��� 8���� �̻��� �������� �̸��� ���ڼ��� ��ȸ�ϱ�
select first_name, length(first_name)
from employees
where length(first_name)>= 8;

-- EMPLOYEES ���̺��� ������ �̸��� ���� �빮�ڷ� ��ȯ���� �� 3��° ���ڰ� 'E'�� ��� ������ �̸��� ��ȸ�ϱ�
select upper(first_name)
from employees
where substr(upper(first_name), 3, 1) = 'E';

-- EMPLOYEES ���̺��� 2007�⵵�� �Ի��� �������� �������̵�, �̸�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, hire_date -- �� ����� �� ��ȣ�Ѵ�.
from employees
where hire_date >= '2007-01-01' and hire_date < '2008-01-01'
order by hire_date asc;

select employee_id, first_name, hire_date
from employees
where to_char(hire_date, 'YYYY') = '2007';

-- EMPLOYEES ���̺��� 2005�⿡ �Ի��� ���� �߿��� Ŀ�̼��� �޴� ������ ���̵�, �̸�, �޿�, Ŀ�̼��� ��ȸ�ϱ�
select employee_id, first_name, salary, commission_pct, hire_date
from employees
where hire_date >= '2005-01-01' and hire_date < '2006-01-01' 
and commission_pct is not null;

-- EMPLOYEES ���̺��� ������ �Ի����� ������ ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees
where to_char(hire_date, 'MM/DD') = to_char(sysdate, 'MM/DD');

-- EMPLOYEES ���̺��� 10���޿� �Ի��� ��� ������� ���̵�, �̸�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, hire_date
from employees
where to_char(hire_date, 'MM') ='10';

-- EMPLOYEES ���̺��� �޿��� 5000�̻� �޴� �������� ���̵�, �̸�, �޿�, �޿� ����� ��ȸ�ϱ�. �޿� ���: 20000�̻� A, 15000�̻� B, 10000�̻� C, �� �ܴ� D ��.
select employee_id, first_name, salary,
        case 
            when salary >= 20000 then 'a'
            when salary >= 15000 then 'b'
            when salary >= 10000 then 'c'
            else 'd'
        end as salary_grade
from employees
order by salary_grade;

-- EMPLOYEES ���̺��� 60�� �μ��� �Ҽӵ� ������� �ٹ��������� ������ �������� ����ؼ� ��ȸ�ϱ�. �������̵�, �̸�, �Ի���, �ٹ��������� ��ȸ�Ǿ�� �ϰ�, �ٹ��������� �������� �������� �����Ѵ�.
select employee_id, first_name, hire_date, trunc(months_between(sysdate, hire_date))worked_months
from employees
where department_id = 60
order by worked_months asc;

-- EMPLOYEES ���̺��� ����� �̸��� �޿��� ǥ���ϰ�, �޿��� ���ؼ� #�� ǥ���ϱ�. '#'�ϳ��� �޿� 1000�� �ش��Ѵ�. lpad

  -- ��¿���
  -- ȫ�浿 4300 ####
  -- ������ 8700 ########
  -- ������ 6500 ######
  
-- lpad(ǥ����'#', trunc(salary/1000), �� ��'#')
select first_name, salary, lpad('#', trunc(salary/1000), '#') �����
from employees;
  
--annual_salary
-- EMPLOYEES ���̺��� 2006�� ��ݱ⿡ �Ի��� �������� �������̵�, �̸�, �Ի���, ������ ����ϱ�. ������ �޿�12 + �޿�Ŀ�̼�*12��.
select employee_id, first_name, hire_date,
        (salary*12 + salary*nvl(commission_pct, 0)*12) as annual_salary
from employees
where hire_date >= '2006-01-01' and hire_date <= last_day('2006-06-01');

select employee_id, first_name, hire_date,
        (salary*12 + salary*nvl(commission_pct, 0)*12) as annual_salary
from employees
where hire_date >= '2006-01-01' and hire_date <('2006-07-01');

-- EMPLOYEES ���̺��� 100�� ��翡�� �����ϴ� �����߿��� Ŀ�̼��� ���� �������� �������̵�, �̸�, �޿�, Ŀ�̼��� ��ȸ�ϱ�
select employee_id, first_name, salary, commission_pct
from employees
where manager_id = 100 and commission_pct is not null;