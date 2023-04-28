-- ���Ἲ ���������� ������ ���̺� ����
create table sample_users (
    user_no number(4),          
    user_id varchar(20)            not null,
    user_password varchar2(20)     not null,
    user_name varchar2(20)         not null,
    user_tel varchar2(20),
    user_email varchar2(255),
    user_point number(8) default 0,
    user_deleted char(1) default 'n' check (user_deleted in ('y', 'n')),
    user_created_date date default sysdate,
    user_updated_date date default sysdate,
    
    CONSTRAINT sample_users_user_no_uk primary key (user_no),
    CONSTRAINT sample_users_user_id_uk unique (user_id),
    CONSTRAINT sample_users_user_email_uk unique (user_email)
);

create table sample_user_followers (
    user_no number(4),
    follow_user_no number(4),
    follower_created_date date default sysdate,
    
    CONSTRAINT user_follow_userno_fk foreign key (user_no) 
                                        REFERENCES sample_users (user_no),
    CONSTRAINT user_follow_followuserno_fk foreign key (follow_user_no)
                                        REFERENCES sample_users (user_no),
    CONSTRAINT user_follower_pk primary key (user_no, follow_user_no)
);

insert into sample_users (user_no, user_id, user_password, user_name)
values (100, 'hong', 'zcxv1234', 'ȫ�浿');
insert into sample_users (user_no, user_id, user_password, user_name)
values (101, 'kang', 'zcxv1234', '������');
insert into sample_users (user_no, user_id, user_password, user_name)
values (102, 'kim', 'zcxv1234', '������');
insert into sample_users (user_no, user_id, user_password, user_name)
values (103, 'lee', 'zcxv1234', '�̼���');

commit;

insert into sample_user_followers (user_no, follow_user_no) values (100, 101);
insert into sample_user_followers (user_no, follow_user_no) values (100, 102);

-- �ڽ����̺� ���� �����ϰ� �θ����̺��� ���� �۾��� �ؾ��Ѵ�.
delete from sample_users
where user_no = 100;

drop table sample_users;