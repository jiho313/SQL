-- �޿��� ���� ���� �޴� ������ ���̵�, �̸�, ����, �޿��� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary
from employees
where salary >= (select max(salary)
                from employees);

-- �޿��� ���� ���� �޴� ������ ���̵�, �̸�, ����, �޿�, �޿� ����� ��ȸ�ϱ�
select e.employee_id, e.first_name, e.job_id, e.salary, g.grade
from employees e, salary_grades g
where e.salary >= g.min_salary and e.salary <= g.max_salary 
and salary <= (select min(salary)
                 from employees);

-- �޿��� �ݾ״뺰�� �з����� �� �� �ݾ״뺰 �������� ��ȸ�ϱ�
-- �ݾ״�� 2000, 3000, 4000, 5000�� ���� ���� �ڸ����� ������ �ȴ�.
select trunc(salary, -3), count(*)
from employees
group by trunc(salary, -3)
order by 1;

-- 80�� �μ��� �ٹ��ϰ�, 80�� �μ��� �����޿��� �޴� ����� ���̵�, �̸�, ����, �޿�, �μ����̵� ��ȸ�ϱ�
select employee_id, first_name, job_id, salary, department_id
from employees
where department_id = 80 
and salary in (select min(salary)
                 from employees
                 where department_id = 80);
                 
-- 'Neena'�� ���� �ؿ� �Ի��� �������� �̸��� �Ի����� ��ȸ�ϱ�
select first_name, hire_date
from employees
where to_char(hire_date, 'YYYY') in (select to_char(hire_date, 'YYYY')
                                     from employees
                                     where first_name in 'Neena');

-- 'Neena'�� ���� ���� ��翡�� �����ϴ� ������ ���̵�, �̸�, �μ����̵�, �μ����� ��ȸ�ϱ�
select e.employee_id, e.first_name, e.department_id, d.department_name 
from employees e, departments d
where e.manager_id = d.manager_id 
and e.manager_id in (select manager_id
                        from employees
                        where first_name = 'Neena');

-- ��ü ������ ��ձ޿� 2�� �̻��� �޴� ����� ���̵�, �̸�, �޿��� ��ȸ�ϱ�
select employee_id, first_name, salary
from employees
where salary >= (select avg(salary)*2
                 from employees);

-- ��ü ������ ��ձ޿����� �޿��� ���� �ް�, 'Neena'�� ���� �ؿ� �Ի��� ������ ���̵�, �̸�, �޿�, �Ի����� ��ȸ�ϱ�
select employee_id, first_name, salary, hire_date 
from employees
where salary > (select avg(salary)
                 from employees)
and to_char(hire_date, 'YYYY') in (select to_char(hire_date, 'YYYY')
                                   from employees
                                   where first_name = 'Neena');

-- 'Ismael'�� ���� �ؿ� �Ի��߰�, ���� �μ��� �ٹ��ϴ� ������ ���̵�, �̸�, �Ի���, �μ����̵� ��ȸ�ϱ�
select employee_id, first_name, hire_date, department_id
from employees
where to_char(hire_date, 'YYYY') in (select to_char(hire_date, 'YYYY')
                                     from employees
                                     where first_name = 'Ismael')
and department_id in (select department_id
                      from employees
                      where first_name = 'Ismael');

-- ���� ���� ������ �Ի��� �ؿ� �Ի��� �������� �̸�, �Ի���, �ҼӺμ����̵�, �μ����� ��ȸ�ϱ�
select e.first_name, e.hire_date, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id 
and to_char(hire_date, 'YYYY') in (select to_char(hire_date, 'YYYY')
                                     from employees
                                     group by to_char(hire_date, 'YYYY')
                                     having count(*) in  (select max(count(*))
                                                          from employees
                                                          group by to_char(hire_date, 'YYYY')));
 
-- �������̵𺰷� �������� ��ȸ���� �� �������� 10�̻��� ������ ���ϰ� �ִ� ������ �̸�, �������̵� ��ȸ�ϱ�
select first_name, job_id
from employees
where job_id in (select job_id
                 from employees
                 group by job_id
                 having count(*) >= 10);

-- �� �μ����� ��ձ޿��� ��ȸ���� �� ��ձ޿� �̻��� �޴� 
-- �μ����̵�, �̸�, �޿��� ��ȸ�ϰ�, �μ����̵𺰷� �����ϱ�
select e.department_id, e.first_name, e.salary
from employees e
where e.salary >= (select avg(salary)
                   from employees
                   where department_id = e.department_id)
order by e.department_id asc;



