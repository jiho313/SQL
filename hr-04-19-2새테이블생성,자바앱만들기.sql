-- ��ǰ ������ �����ϴ� ���̺�� ������ �����ϱ� --
create SEQUENCE sample_product_seq start with 1000 NOCACHE;

create table sample_product (
    product_no number(4) PRIMARY key,
    product_name varchar2(100) not null,
    product_maker varchar2(100) not null,
    product_price number(8, 0),
    product_discount_rate number(3, 2),
    product_stock number(3, 0),
    product_create_date date default sysdate
);

/*
    sample03 ��Ű���� �����Ѵ�.
    sample03 ��Ű���� ��ǰ������ ǥ���ϴ� Ŭ������ �����Ѵ�.
    sample03 ����Ű�� ��ǰ������ ���� crud ����� ������ Ŭ������ �����Ѵ�.
        - �ű� ��ǰ������ �����ϴ� ���
        - ��� ��ǰ������ ��ȸ�ؼ� ��ȯ�ϴ� ���
        - ��ǰ��ȣ�� ���޹޾Ƽ� �ش��ϴ� ��ǰ������ ��ȯ�ϴ� ���
        - �ּҰ���, �ִ밡���� ���޹޾Ƽ� �ش� ���ݹ����� ���Ե� ��ǰ������ ��ȯ�ϴ� ���
        - ��ǰ��ȣ�� ���޹޾Ƽ� ��ǰ������ �����ϴ� ���
    sample04 ��Ű���� ��ǰ������ �����ϴ� ���ø����̼� Ŭ������ �����Ѵ�.
        - ������ȸ, ������ȸ, ����ȸ, �űԵ��, ����, ���� ����� �����Ѵ�.
        
*/