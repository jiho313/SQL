-- Ŀ�̼��� �޴� ������� ���̵�, �̸�, �μ���ȣ, �μ���, �޿������ ��ȸ�ϱ�
select e.employee_id, e.first_name, e.department_id, d.department_name, g.grade
from employees e, departments d, salary_grades g
where e.commission_pct is not null
and e.department_id = d.department_id(+)
and e.salary >= g.min_salary and e.salary <= g.max_salary
order by g.grade;

-- ��� ����� ������̵�, �̸�, �� ����� ����̸�, �ҼӺμ��̸�, �ҼӺμ� ������ �̸� ��ȸ�ϱ�
select e.employee_id, 
        e.first_name, 
        em.first_name as ����̸�,
        d.department_name,
        dm.first_name as �ҼӺμ��������̸�
from employees e, departments d, employees em, employees dm
where e.department_id = d.department_id(+) 
and e.manager_id = em.employee_id(+)
and d.manager_id = dm.employee_id(+);

-- ������ ��ձ޿��� ������� �� ��ձ޿��� ���� ���� ������ ��ձ޿��� ��ȸ�ϱ�
-- �ζ��� ��
select e.job_id, s.min_avg_salary
from (select job_id, avg(salary) avg_salary
     from employees 
     group by job_id) e,
     (select min(avg_salary) min_avg_salary
     from (select job_id, avg(salary) avg_salary
     from employees 
     group by job_id)) s
where e.avg_salary = s.min_avg_salary;

-- ���� ����
select job_id, avg(salary)
from employees 
group by job_id
having avg(salary) = (select min(avg(salary))
                      from employees
                      group by job_id);
                      
-- with���� ĳ���ϴ� ���                      
with job_avg_salary
as (select job_id, avg(salary) avg_salary
    from employees
    group by job_id)
select job_id, avg_salary
from job_avg_salary
where avg_salary = (select min(avg_salary)
                    from job_avg_salary);
-- ������ ��ձ޿��� ������� �� ��ձ޿��� ���� ���� ������ ���̵�, ��������, �� ������ �����޿�, �� ������ �ִ�޿��� ��ȸ�ϱ�
-- �ζ��κ�
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

select a.job_id, j.job_title, j.min_salary, j.max_salary
from (select job_id, avg(salary)
      from employees
      group by job_id
      having avg(salary) = (select min(avg(salary))
                            from employees
                            group by job_id)) a, jobs j
where a.job_id = j.job_id;

-- ��������
select job_id, job_title, min_salary, max_salary
from jobs 
where job_id = (select job_id
                from employees
                group by job_id
                having avg(salary) = (select min(avg(salary))
                                      from employees
                                      group by job_id));

-- ������ �������� ������� �� ������ �� ���̶� �ٹ��ϰ� �ִ� ������� �������� ��ȸ�ϱ�
select nvl(c.country_name, '�����Ҹ�'), count(*)
from employees e, departments d, locations l, countries c
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+)
and l.country_id = c.country_id(+)
group by c.country_name;

-- �μ��� ��ձ޿��� ������� �� ��ü������ ��ձ޿����� ��ձ޿��� ���� �μ��� ���̵�� ��ձ޿��� ��ȸ�ϱ�
select department_id, trunc(avg_salary)
from (select department_id, avg(salary) avg_salary
        from employees
        group by department_id)
where department_id is not null 
and avg_salary > (select avg(salary)
                      from employees);
                      
select department_id, trunc(avg(salary))
from employees
where department_id is not null
group by department_id
having avg(salary) > (select avg(salary)
                      from employees);


-- ��� ���̺��� �޿��� �������� �޿� ����� ��ȸ���� ��, �޿���޺� ������� ��ȸ�ϱ�
select g.grade, count(*)
from (select g.grade
      from employees e, salary_grades g
      where e.salary >= g.min_salary and e.salary <= g.max_salary) g
group by g.grade;

select y.grade, nvl(x.cnt, 0)cnt, y.min_salary, y.max_salary
from (select g.grade, count(*) cnt
      from employees e, salary_grades g
      where e.salary >= g.min_salary and e.salary <= g.max_salary
      group by g.grade) x, salary_grades y
where x.grade(+) = y.grade
order by y.grade;

/*
(SELECT G.GRADE, COUNT(*) CNT
 FROM EMPLOYEES E, SALARY_GRADES G
 WHERE E.SALARY >= G.MIN_SALARY AND E.SALARY <= G.MAX_SALARY
 GROUP BY G.GRADE) X

 ������ ���̺� X              SALARY_GRADES Y
 ------------------         --------------------------------
 GRADE CNT                  GRADE   MIN_SALARY  MAX_SALARY
 ------------------         --------------------------------
 B       1                   A
 C       18                  B
 D       39                  C
 E       44                  D
 F       5                   E
 ------------------          F
                             G
                            ----------------------------------
                            
X�� Y�� ����
--------------------------------------------------------------
GRADE   CNT     GRADE   MIN_SALARY  MAX_SALARY
--------------------------------------------------------------
NULL    NULL    A       50000   99999
B       1       B       20000   49999
C       18       C       10000   19999
D       39       D       5000   9999
E       44       E       2500   4999
F       5       F       1000   2499
NULL    NULL    G       0       999
--------------------------------------------------------------
*/

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
      
select to_char(hire_date, 'YYYY'), count(*)
from employees
group by to_char(hire_date, 'YYYY')
having count(*) in (select min(count(*))
                            from employees 
                            group by to_char(hire_date, 'YYYY'));

-- �����ں� ������� ��ȸ���� �� ������� 10���� �Ѵ� ������ ���̵�� ������� ��ȸ�ϱ�
select e.manager_id, count(*)           
from employees e, employees em
where e.manager_id = em.employee_id
group by e.manager_id
having count(*) > 10;

-- �μ��� ��ձ޿��� ��ȸ���� �� �� �μ��� ��ձ޿����� ���� �޿��� ���� ����� �̸�, �޿�, �μ����� ��ȸ�ϱ�
-- ��ȣ���� ���������� Ǯ��
select e.first_name, e.salary, d.department_name
from employees e, departments d
where e.salary < (select avg(salary)
                  from employees 
                  where department_id = e.department_id)
and e.department_id = d.department_id;

-- �ζ��κ�� Ǯ��
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
where d.manager_id = dm.employee_id(+);


select department_id, count(*)cnt       --- 5. ���� ��� ��ȸ
from employees                          --- 1. ���̺� ��ȸ
where department_id is not null         --- 2. ���͸�
group by department_id                  --- 3. ���͸� �� �׷���
having count(*) > 5                     --- 4. �׷����� ������� ���͸�
order by cnt asc                        --- 6. ���� ����� ����



