/*
is not null�� is null
    - �÷��� ���� null���� ���θ� �Ǵ��ؼ� true, false ���� ��ȯ�ϴ� ������.
    - ����
        select �÷���, �÷���
        from ���̺��   
        where �÷��� = null;    <--- ������ �÷��� ���� null�� ���� ��ȸ�Ѵ�.(���������� ����)
        * ��ȸ����� ����.
        
        select �÷���, �÷���
        from ���̺��
        where �÷��� != null;   <--- ������ �÷��� ���� null�� �ƴ� ���� ��ȸ�Ѵ�.(���������� ����
        * ��ȸ����� ����.
        
        -- ������ �÷��� ���� null�� ���� ��ȸ�Ѵ�.
        select �÷���, �÷���
        from ���̺��   
        where �÷��� is null;   

        -- ������ �÷��� ���� null�� �ƴ� ���� ��ȸ�Ѵ�.
        select �÷���, �÷���
        from ���̺��   
        where �÷��� is not null;   

*/
-- employees ���̺��� �ҼӺμ��� �������� ���� ������ ���̵�, �̸��� ��ȸ�ϱ�
select employee_id, first_name
from employees
where department_id is null;

-- departments ���̺��� �μ� ����ڰ� ���� �μ��� ���̵�, �μ��̸� ��ȸ�ϱ�
SELECT department_id, department_name
from departments
where manager_id is null;

-- employees ���̺��� Ŀ�̼��� �޴� ������ ���̵�, �̸�, �޿�, Ŀ�̼� ���޷� ��ȸ�ϱ�
select employee_id, first_name, salary, COMMISSION_PCT
from employees
where COMMISSION_PCT is not null;

select count(*)
from employees;























