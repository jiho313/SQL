-- 상품 정보를 저장하는 테이블과 시퀀스 생성하기 --
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
    sample03 패키지를 생성한다.
    sample03 패키지에 상품정보를 표현하는 클래스를 정의한다.
    sample03 패지키에 상품정보에 대한 crud 기능이 구현된 클래스를 정의한다.
        - 신규 상품정보를 저장하는 기능
        - 모든 상품정보를 조회해서 반환하는 기능
        - 상품번호를 전달받아서 해당하는 상품정보를 반환하는 기능
        - 최소가격, 최대가격을 전달받아서 해당 가격범위에 포함된 상품정보를 반환하는 기능
        - 상품번호를 전달받아서 상품정보를 삭제하는 기능
    sample04 패키지에 상품정보를 관리하는 애플리케이션 클래스를 정의한다.
        - 전제조회, 가격조회, 상세조회, 신규등록, 삭제, 종료 기능을 구현한다.
        
*/