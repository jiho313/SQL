--------------------------------------------------------------------------------------------
-- ��ȣ���� ��������
--------------------------------------------------------------------------------------------

-- �� �μ����� ��ձ޿��� ��ȸ���� �� ��ձ޿� �̻��� �޴� 
-- �������̵�, �̸�, �޿�, �μ����̵� ��ȸ�ϱ�
select e.employee_id, e.first_name, e.salary, e.department_id
from employees e
where e.salary >=  (select avg(salary)
                  from employees
                  where department_id = e.department_id);
                  
-- �μ����̵�, �μ���, �� �μ��� ����� ��ȸ�ϱ�
-- ��ȣ���� ��Į�� ��������
select d.department_id, d.department_name, (select count(*)
                                            from employees
                                            where department_id =d.department_id) cnt
from departments d;

--------------------------------------------------------------------------------------------
-- �ζ��� ��
--------------------------------------------------------------------------------------------

-- �μ��� �ְ�޿��� ����ϰ�, �ش� �μ����� �ְ�޿��� �޴� ������ ���̵�, �̸�, �޿�, �μ����̵� ��ȸ�ϱ�
-- �����
select e.employee_id, e.first_name, e.salary, e.department_id
from (select department_id, max(salary) max_salary
      from employees
      group by department_id) s, employees e
where s.department_id = e.department_id
and s.max_salary = e.salary;
-- ���̺� s�� �μ����̵�� �ش� �μ��� �ְ�޿��� ������ ������ ���̺��̴�.


-- �� �μ����� ��ձ޿��� ��ȸ���� �� ��ձ޿� �̻��� �޴� 
-- �������̵�, �̸�, �޿�, �μ����̵� ��ȸ�ϱ�
-- ����ΰ� ������
select e.employee_id, e.first_name, e.salary, e.department_id
from (select department_id, avg(salary) avg_salary
      from employees
      group by department_id)s, employees e
where s.department_id = e.department_id
and e.salary >= s.avg_salary;

-- �ζ��κ�� �μ����̵�, �μ��̸�, �μ��� �������� ��ȸ�ϱ�
select d.department_id, d.department_name, e.cnt
from (select department_id, count(*) cnt
      from employees 
      group by department_id)e, departments d
where e.department_id = d.department_id












