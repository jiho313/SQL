-- ����Ŭ 12c ���ĺ��ʹ� "c##���̵�"�� ���� ���°� �������� �����ؾ� �Ѵ�.
-- �Ʒ��� ��ɾ�� "c##"�� ���Խ�Ű�� �ʰ� �������� �����ϰ� �Ѵ�.
ALTER SESSION SET "_ORACLE_SCRIPT" = true;

-- ���� ���� �����ϱ�
-- ������: hr, ��й�ȣ: zxcv1234
-- CREATE USER ������ IDENTIFIED BY ��й�ȣ;
CREATE USER hr identified by zxcv1234;

-- ���� ������ ���� �ο��ϱ�
-- ���ӱ���(��): CONNECT, ���ҽ� ������(��): RESOURCE, �����ڱ���(��): DBA
-- GRANT ����, ���� TO ������;
GRANT CONNECT, RESOURCE, DBA TO hr;