--------------------------------------------------------------------------------------------
-- �������� ����
--------------------------------------------------------------------------------------------
-- not null ��������
create table sample_user_1 (
    name varchar2(1000) not null,
    tel varchar2(20) not null
);

-- ���̺��� �̸�, ���������� ���� �÷�, �������� ��Ī
create table sample_user_2 (
    name varchar2(1000) constraint user_name_nn not null,
    tel varchar2(20) constraint user_tel_nn not null
);
-- not null�̶� insert�Ұ�
insert into sample_user_2 (name) values ('ȫ�浿');

-- * not null �������ǿ� ���ؼ��� �������� ��Ī�� ������ �ʾƵ� �ȴ�.
-- * not null �������� ����� ���� �޼����� ���̺�, �÷� ������ ���ԵǾ� �ֱ� �����̴�.


-- unique ��������
create table sample_user_3 (
    name varchar2(100) not null,
    email varchar2(255) unique
);

create table sample_user_4 (
    name varchar2(100) not null,
    email varchar2(255) constraint sampleuser_email_uk unique
);

-- ���������� ��Ī�� ���ļ��� �ȵȴ�.
create table sample_user_5 (
    name varchar2(100) not null,
    email varchar2(255),
    CONSTRAINT sampleuser5_email_uk unique (email)
);

insert into sample_user_3 (name, email) values ('ȫ�浿', 'hong@gmail.com');
insert into sample_user_4 (name, email) values ('ȫ�浿', 'hong@gmail.com');

-- primary key ��������
create table sample_user_6 (
    user_no number(5) primary key
);

create table sample_user_7 (
    user_no number(5) CONSTRAINT sampleuser7_userno_pk primary key
);

-- �����̸Ӹ� Ű ���� �� �� �÷� ���
create table sample_user_8 (
    user_no number(5),
    user_name varchar2(100),
    CONSTRAINT sampleuser8_userno_pk primary key (user_no)
);

create table sample0_credit (
    user_no number(5),
    order_no number(5),
    create_date date default sysdate,
    CONSTRAINT sampleuser9_userno_pk primary key (user_no, order_no)
);  

-- check ��������
create table sample10_scores (
    name varchar2(20),
    kor number(3) check (kor >= 0 and kor <= 100),
    eng number(3) check (eng >= 0 and eng <= 100),
    math number(3) check (math >= 0 and math <= 100),
    passed char(1) check (passed in ('Y', 'N')),
    greade char(1) check (grade in('��', '��', '��', '��', '��'))
);

-- �ܷ�Ű ��������
create table sample_parent_1 (
    dept_no number(3) primary key,
    dept_name varchar2(100) not null
);

create table sample_child_1 (
    emp_no number(3) primary key,
    empt_name varchar2(20) not null,
    dept_no number(3) references sample_parent_1 (dept_no)
);

create table sample_parent_2 (
    dept_no number(3) primary key,
    dept_name varchar2(100) not null
);

create table sample_child_2 (
    emp_no number(3) primary key,
    empt_name varchar2(20) not null,
    dept_no number(3),
    
    constraint samplechild_depno_fk foreign key (emp_dept_no)
                                    references sample_parent_2(dept_no)
);



