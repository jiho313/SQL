-----------------------------------------------------------------------------------
-- ���� �˻�
-----------------------------------------------------------------------------------
-- �극�� �÷� �������� ã�ư�����
/*
    - �������迡 �ִ� ����� �� ���踦 ����ؼ� ��ȸ�ϴ� �˻��̴�.
    - ����
        select level, �÷���, �÷���, ...
        from ���̺�
        start with �÷��� = ��
        connect by prior �÷��� = �÷���
        
        *level : �������迡���� depth�� ��ȯ�ϴ� ���̴�. 
                 �������� 1�̰�, �״��� depth���� 1�� ������ ���� ��ȯ�Ѵ�.
        * start with : �����˻� ���� ���� ���ǽ����� ǥ���Ѵ�.
        * connect by : �����˻��� ������ �����Ѵ�.
            �����࿡�� ���������� �˻�
                connect by proir �θ�Ű�÷�(�����̸Ӹ�Ű, ����ũ) = �ڽ��÷�(�ܷ�Ű�÷�)
            �����࿡�� ���������� �˻�
                connect by proir �ڽ��÷�(�ܷ�Ű�÷�) = �θ�Ű�÷�(�����̸Ӹ�Ű, ����ũ)
    
                * �θ�Ű�÷��� �ڽ����̺��� �ܷ�Ű�� �����ϴ� �⺻Ű �÷��̴�.
                * �ڽ�Ű�÷��� �⺻Ű�� �����ϴ� �ܷ�Ű �÷��̴�.
*/
select level, employee_id, manager_id, lpad(' ', level*2, ' ') || first_name
from employees
start with employee_id = 100
connect by prior  employee_id = manager_id;

select level, employee_id, manager_id, first_name
from employees
start with employee_id = 112
connect by prior  manager_id = employee_id
order by level desc;

-----------------------------------------------------------------------------------
-- connect by level�� ���ӵ� �� ��ȸ�ϱ�
-----------------------------------------------------------------------------------

-- 1���� 10���� 1�� �����ϴ� ���� ��ȸ�ϱ�
select level
from dual
connect by level <= 10;

-- 1���� 10���� 2�� �����ϴ� ���� ��ȸ�ϱ�
select level*2
from dual
connect by level <= 10;

-- �ʱⰪ�� �����ؼ� 1�� �����ϴ� ���� ��ȸ�ϱ�
select level + 10
from dual
connect by level <= 10;

--------------------------------------------------------------------------------------
-- 2004�� ���� �Ի��� �� ��ȸ (�Ի��� ������ �ִ� ��쿡�� ��ȸ)
select to_char(hire_date, 'MM') month, count(*) cnt
      from employees
      where hire_date >= '2004/01/01' and hire_date < '2005/01/01'
      group by to_char(hire_date, 'MM')
order by 1;

-- 1~ 12���� �������� ���� ��ȸ�ϱ�
select lpad(level, 2, '0') month
    from dual
    connect by level <= 12;
    
-- 2004�� ���� �Ի��� �� ��ȸ
with months
as (select lpad(level, 2, '0') month
    from dual
    connect by level <= 12)
select m.month, c.cnt
from (select to_char(hire_date, 'MM') month, count(*) cnt
      from employees
      where hire_date >= '2004/01/01' and hire_date < '2005/01/01'
      group by to_char(hire_date, 'MM')) c, months m
where c.month(+) = m.month
order by m.month;

select to_date('2023/04/01') + level - 1
from dual
connect by level <= to_date('2023/04/25') - to_date('2023/04/01') +1;
