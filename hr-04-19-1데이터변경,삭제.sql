/*
������ �����ϱ�
    - ����
        update ���̺��
        set
            �÷��� = ��,
            �÷��� = ��;
            ������ ���̺��� ��� �࿡ ���ؼ� ������ �÷��� ���� �����Ѵ�.
            
        update ���̺��
        set
            �÷��� = ��,
            �÷��� = ��,
            �÷��� = ��
        where ���ǽ�;
            ������ ���̺��� ���õ� ���ǽ��� true�� �����Ǵ� �࿡ ���ؼ� ������ �÷��� ���� �����Ѵ�.
        
������ �����ϱ�
    - ����
        delete from ���̺��;
            ������ ���̺��� ��� ���� �����Ѵ�.
            
        delete from ���̺��;
        where ���ǽ�;
            ������ ���̺��� ���õ� ���ǽ��� true�� �����Ǵ� ���� ���� �����Ѵ�.
            
*   update, delete �������� ������ ��� ���� commit; ����� �����ؼ� �����ͺ��̽��� �ݿ���Ű��
    �������� ������ �� �ִ�.
        - commit���μ������� �ݿ��� inset, update, delete ��ɿ� ���ؼ��� �ѹ��� ������� �ʴ´�.
    rollback
        - inset, update, delete ��� �������� ������ ���̽��� �ݿ���Ű�� ���� ���� ��ұ�Ų��.
*/

-- �й��� 1000���� �л� �������� �����ϱ�
delete from sample_scores
where student_no = 1000;

-- ��� �л��� �������� �����ϱ�
delete from sample_scores;

-- delete ���� ���� ����� �����ͺ��̽��� �ݿ��� ���� ��ҽ�Ű��
rollback;

-- 100�� �л��� ��������, ��������, �������� �����ϱ�
update sample_scores
set
    kor_score = 100,
    eng_score = 100,
    math_score = 100
where student_no = 1000;

-- 60�� �μ��� �Ҽӵ� ������ �޿��� 10% �λ��Ű��
update employees
set
    salary = salary*1.1
where department_id = 60;

update employees
set
    salary = 10000;
    
rollback;


