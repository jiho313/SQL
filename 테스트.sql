-- Ŀ�̼��� �޴� ������� ���̵�, �̸�, �μ���ȣ, �μ���, �޿������ ��ȸ�ϱ�
select e.employee_id, e.first_name, e.department_id, d.department_name, g.grade
from employees e, departments d, salary_grades g
where e.commission_pct is not null
and e.department_id = d.department_id(+)
and e.salary >= g.min_salary and e.salary <= g.max_salary;

-- ��� ����� ������̵�, �̸�, �� ����� ����̸�, �ҼӺμ��̸�, �ҼӺμ� ������ �̸� ��ȸ�ϱ�
select e.employee_id, 
        e.first_name, 
        em.first_name as ����̸�,
        d.department_name,
        dm.first_name as �ҼӺμ��������̸�
from employees e, departments d, employees em, employees dm
where e.manager_id = em.employee_id(+)
and e.department_id = d.department_id(+)
and e.manager_id = dm.employee_id(+);

-- ������ ��ձ޿��� ������� �� ��ձ޿��� ���� ���� ������ ��ձ޿��� ��ȸ�ϱ�
select e.job_id, s.min_avg_salary
from (select job_id, avg(salary) avg_salary
     from employees 
     group by job_id) e,
     (select min(avg_salary) min_avg_salary
     from (select job_id, avg(salary) avg_salary
     from employees 
     group by job_id)) s
where e.avg_salary = s.min_avg_salary;


-- ������ ��ձ޿��� ������� �� ��ձ޿��� ���� ���� ������ ���̵�, ��������, �� ������ �����޿�, �� ������ �ִ�޿��� ��ȸ�ϱ�
select e.job_id, j.job_title, j.min_salary, j.max_salary
from jobs j,
     (select job_id, avg(salary) avg_salary
      from employees
      group by job_id) e,
     (select min(avg_salary) min_avg_salary
      from (select job_id, avg(salary) avg_salary
           from employees
           group by job_id))s
where e.avg_salary = s.min_avg_salary
and e.job_id = j.job_id;

-- ������ �������� ������� �� ������ �� ���̶� �ٹ��ϰ� �ִ� ������� �������� ��ȸ�ϱ�
select nvl(l.country_id, '�����Ҹ�'), count(*)
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+)
group by l.country_id;

-- �μ��� ��ձ޿��� ������� �� ��ü������ ��ձ޿����� ��ձ޿��� ���� �μ��� ���̵�� ��ձ޿��� ��ȸ�ϱ�
select e.department_id, e.avg_salary
from (select department_id, avg(salary) avg_salary
        from employees
        group by department_id) e
where e.avg_salary > (select avg(salary)
                      from employees);


-- ��� ���̺��� �޿��� �������� �޿� ����� ��ȸ���� ��, �޿���޺� ������� ��ȸ�ϱ�
select g.grade, count(*)
from(select g.grade
from employees e, salary_grades g
where e.salary >= g.min_salary and e.salary <= g.max_salary) g
group by g.grade;

-- ������� �ٹ��ϴ� �μ��� ���絵�ÿ� �� ���ÿ��� �ٹ��ϴ� ������� ��ȸ�ϱ�
select nvl(l.city, '�������Ҹ�'), count(*)
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+)
group by l.city;


-- ���� ���� ����� �Ի��� �ؿ� �� �ؿ� �Ի��� ������� ��ȸ�ϱ�
select d."�Ի���", m."�����"
from (select to_char(hire_date, 'YYYY') as "�Ի���"
        from employees
        group by to_char(hire_date, 'YYYY')
        having count(*) in (select min(count(*))
                            from employees 
                            group by to_char(hire_date, 'YYYY'))) d,
     (select min(count(*)) as "�����"
      from employees 
      group by to_char(hire_date, 'YYYY'))m;

-- �����ں� ������� ��ȸ���� �� ������� 10���� �Ѵ� ������ ���̵�� ������� ��ȸ�ϱ�
select e.manager_id, count(*)
from employees e, employees em
where e.manager_id = em.employee_id
group by e.manager_id
having count(*) > 10;

-- �μ��� ��ձ޿��� ��ȸ���� �� �� �μ��� ��ձ޿����� ���� �޿��� ���� ����� �̸�, �޿�, �μ����� ��ȸ�ϱ�
-- ���������� Ǯ��
select e.first_name, e.salary, d.department_name
from employees e, departments d
where e.salary < (select avg(salary)
                  from employees 
                  where department_id = e.department_id)
and e.department_id = d.department_id;

-- �ζ��κ�� Ǯ��)
select e.first_name, e.department_id, e.salary, d.department_name
from employees e, departments d,
     (select department_id, avg(salary) avg_salary
     from employees 
     group by department_id) s
where e.salary < s.avg_salary
and e.department_id = d.department_id
and e.department_id = s.department_id;

-- �μ����� �μ����̵�, �μ���, �μ��������̸�, �Ҽӻ������ ��ȸ�ϱ�
select d.department_id, d.department_name, dm.first_name,(select count(*)
                                            from employees
                                            where department_id =d.department_id) cnt
from employees dm, departments d
where d.manager_id = dm.employee_id;




