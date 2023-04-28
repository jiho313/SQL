-------------------------------------------------------------------------------------------
-- top-n �м�
-------------------------------------------------------------------------------------------

-- �޿��� ���� ���� �޴� ���� 1 ~ 5�� �ش��ϴ� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
-- rownum�� ����Ʈ���� �������� ���� ���� ��Ÿ���� ���� �ƴϴ�.
select rownum, employee_id, first_name, salary
from (select employee_id, first_name, salary
      from employees
      order by salary desc)
where rownum <= 5;

-- �޿��� ���� ���� �޴� ���� 6 ~ 10�� �ش��ϴ� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
-- top���� ���� ����� ��ȸ�ϱ� ������ ����� ������ �ʴ´�. 
select rownum, employee_id, first_name, salary
from (select employee_id, first_name, salary
      from employees
      order by salary desc)
where rownum >= 6 and rownum <= 10;

-- �޿��� ���� ���� �޴� ���� 6 ~ 10�� �ش��ϴ� ������ ���̵�, �̸�, �޿��� ��ȸ�ϱ�
-- ������ ���̺��� ����� rownum�� ��Ī�� �ο��� �� where���� ������ �Է��ؼ� ��ȸ�Ѵ�.
select rn, employee_id, first_name, salary
from (select rownum as rn, employee_id, first_name, salary
        from (select employee_id, first_name, salary
              from employees
              order by salary desc))
where rn >= 6 and rn <= 10;

-------------------------------------------------------------------------------------------
-- ����Ŭ�� �м��Լ�
-------------------------------------------------------------------------------------------
/*
�м��Լ�
    - ���̺� �ִ� �����͸� Ư�� �뵵�� �м��Ͽ� ����� ��ȯ�ϴ� �Լ�
    - ������ ����� �ܼ��ϰ� ó�����ִ� �Լ�
    - select������ ����ȴ�.
    - ����
        select �м��Լ�(����)
                over (
                     [partition by �÷���, �÷���, ...]
                     [order by �÷���, �÷���, ...]
                )
        from ���̺��;
        * �м��Լ�(����) : ����� �м��Լ��� �̸�, ���ڿ��� �м�����̵Ǵ� �÷��� Ȥ�� ǥ����
        * over : �м��Լ����� ��Ÿ���� Ű�����.
        * partition by : ����� �׷��� �����Ѵ�.
        * order by : ����� �׷쿡 ���� ������ �����Ѵ�.
        
    - �м��Լ��� ����
        * �����Լ� : rank, dense_rank, row_number
        * �����Լ� : sum, min, max, avg, count
*/

-------------------------------------------------------------------------------------------
-- row_number()
-- rownum �ǻ��÷��� ����� ����� �����Ѵ�.
-- ��Ƽ������ ���ҵ� �׷캰�� �� �ο쿡 ���� ������ ��ȯ�ϴ� �Լ���.
-------------------------------------------------------------------------------------------

-- �޿��� ���������� �����ؼ� ������ ���Ե� �����͸� ��ȸ�Ѵ�.
select row_number() over (order by salary desc)emp_row,
       employee_id first_name, salary
from employees;

-- �μ����� ������ �޿��� ���������� �����ؼ� ������ ���Ե� �����͸� ��ȸ�Ѵ�.
select row_number() over(PARTITION by department_id
                         order by salary desc)emp_row,
       department_id, employee_id, first_name, salary
from employees;

-- �μ����� ������ �޿��� ���� ������ �������� �� ���� ���� �޴� 3���� ��ȸ�Ѵ�.
select emp_row, department_id, employee_id, salary
from (select row_number() over(PARTITION by department_id
                         order by salary desc)emp_row,
       department_id, employee_id, first_name, salary
        from employees)
where emp_row <= 3;

-- �μ����� ������ �޿��� ���� ������ �������� �� ���� ���� �޴� ������ ��ȸ�Ѵ�.
select emp_row, department_id, employee_id, salary
from (select row_number() over(PARTITION by department_id
                          order by salary desc)emp_row,
       department_id, employee_id, first_name, salary
        from employees)
where emp_row <= 1;

-- �������� ���̵� �������� ���� ������ �������� �� 11~20��° ������ ��ȸ�ϱ�
-- ���� �� ����, �ش��ϴ� �������� ������ ������ ��ǰ�� �Ѹ� ��
select emp_row, employee_id, first_name
from (select row_number() over (order by employee_id asc)emp_row,
            employee_id, first_name
            from employees)
where emp_row >= 11 and emp_row <= 20;
-------------------------------------------------------------------------------------------
-- ��ũ, 
-- ���� ��ȯ �Լ�
-------------------------------------------------------------------------------------------
select rank() over(order by salary desc) ranking,
        employee_id, first_name, salary
from employees;

select dense_rank() over(order by salary desc) ranking,
        employee_id, first_name, salary
from employees;

-------------------------------------------------------------------------------------------
-- cume_dist() percent_rank
-- �־��� �׷쿡 ���� ������� ���������� �� ��ȯ
-- �־��� �׷쿡 ���� ����� ���� ��ȯ
-------------------------------------------------------------------------------------------
-- �μ����� �׷��� ������, �޿������� �������� �� �ش� �μ����� �ش� �޿��� ������� ������������ ��ȸ
select department_id, employee_id, salary,
     trunc(cume_dist() over (partition by department_id
                     order by salary),2) dept_dist
from employees;
-------------------------------------------------------------------------------------------
-- �׷��Լ��� �м��Լ�
-------------------------------------------------------------------------------------------

-- sum()�� �׷��Լ��� ����ϱ�
-- ���ձ׷�� ����� �ϳ� ��ȸ�ȴ�.

-- ���̺��� ���ձ׷��̱� ������ ����� �ϳ� ��ȸ�ȴ�.
select sum(salary)
from employees;

-- �μ����̵𺰷� �׷��� �߱� ������ �μ����� ����� �ϳ� ��ȸ�ȴ�.
select department_id, sum(salary)
from employees
group by department_id
order by department_id;

-- sum()�� �м��Լ��� ����ϱ�
-- ��� �ึ�� �м��Լ� ����� ��ȸ�ȴ�.

select department_id, employee_id, first_name, salary, 
        sum(salary) over() -- ��Ƽ���� �������� �ʾұ� ������ �޿� ������ ����ȴ�.
from employees;

select department_id, employee_id, first_name, salary, 
        sum(salary) over (partition by department_id)dept_salary
from employees;

-- �μ��� �޿� ������ �������� ��, �ش� ������ �޿� ������ ��ȸ�ϱ�
select department_id, employee_id, first_name, salary, round(salary/dept_salary, 2)
from(select department_id, employee_id, first_name, salary,
        sum(salary) over (partition by department_id)dept_salary
        from employees);


--------------------------------------------------------------------------------------
-- ����¡ ó���� �����Լ�
--------------------------------------------------------------------------------------
/*
    - �� ȭ�鿡 ǥ���� ������ ���� ����
        int rows = 10;
    - ��û�� ������ ��ȣ
        int pageNo = 1;
    - ��ü ���������� ����
        int totalRows =107;
    - ��ü ����������
        int totalPages =(int) Math.ceil((double)totalRows/rows)
        
    -- ��û�� �������� ���� �ε����� �� �ε���
        int beginIndex = (pageNo - 1)*rows +1;
        int endIndex = pageNo*rows;
        
        
    select no, title, maker, price
    from (select row_number() over (order by no desc)row_num, 
                  no, title, maker, price ....
          from products)
    where row_num >= ? and row_num <= ?;

*/


