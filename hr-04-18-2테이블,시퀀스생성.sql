-- 샘플 테이블 작성하기
/*
    create table 테이블명 {
        컬럼명 데이터타입(사이즈),
        컬러명 데이터타입(사이즈)  default 기본값
    )
    오라클의 데이터 타입    
        * number(p, s) - 숫자 타입 타입
        * varchar2 - 가변길이 문자 데이터
        * date - 날짜/시간 데이터 타입
    제약조건
        * primary key - 행을 대표하는 컬럼이다. 
                      - 반드시 값이 존재해야 하고, 그 값은 테이블 전체에서 고유해야 한다.
        * not null - null 값을 허용하지 않는다.
    날짜함수
        * sysdate - 시스템의 현재 날짜와 시간정보를 반환한다.
                  - 반환값은 date 타입의 값이다.
*/
create table smaple_scores(
-- ()괄호 안은 값의 크기
  student_no number(4,0) primary key, 
  student_name varchar2(20) not null, 
  kor_score number(3,0) default 0,
  eng_score number(3,0) default 0,
  math_score number(3,0) default 0,  
  create_date date default sysdate
);

/*
    샘플 시퀀스 추가하기 -> 일련번호 발생기
        - 시퀀스 객체는 일련번호를 발행하는 데이터베이스 객체다.
        - 형식
            create sequence 시퀀스이름;
                * 1부터 시작하고 1씩 증가되는 일련번호를 발행하는 시퀀스 객체 생성
                
            create sequence 시퀀스이름 start with 시작값
                * 지정된 시작값부터 시작하고 1씩 증가되는 일련번호를 발행하는 시퀀스 객체 생성
            
            create sequence 시퀀스이름 start with 시작값 increment by 증감값;
                * 지정된 시작값부터 시작하고 지정된 증감값만큼 매번 변경된 일련번호를 발행하는 시퀀스 객체 생성
                
            create sequence 시퀀스이름 start with 시작값 increment by 증감값 nocache;
                * 지정된 시작값부터 시작하고 지정된 증감값만큼 매번 변경된 일련번호를 발행하는 시퀀스 객체 생성
                * 캐시를 사용하지 않는 시퀀스 객체를 생성  
        - 일려번호의 발행
            시퀀스이름.nextval - 새로운 일련번호를 반환한다. 매개변수가 없으면 ()를 적지 않아도 된다.
            
*/



/*
데이터 추가
    - 테이블에 새로운 행을 추가한다.
    - 형식
        insert into 테이블명 (컬럼명, 컬럼명, 컬럼명)
        values (값, 값, 값);
        * 컬럼의 순서는 테이블의 컬럼 순서와 상관없이 작성할 수 있다.
        * 컬럼의 갯수와 값의 갯수가 일치하고, 컬럼의 순서에 맞게 값이 설정되어야 한다.
        * primary key, not null 제약조건이 지정된 컬럼은 반드시 값이 설정되어야 한다.
        * 기본값이 지정되어 있는 컬럼은 생략하면 지정된 기본값이 컬럼의 값이 된다.
        * values()에 모든 컬럼의 값들이 빠짐없이 정의되어 있고, 값들의 순서가 컬럼의 순서와
          일치하는 경우 컬럼명은 생략할 수 있다.(절대로 생략하지 말자!!!!)
          
*/

insert into sample_scores
(student_no, student_name, kor_score, eng_score, math_score, create_date)
values
(100,'강감찬',100,90,90,'2023/04/17');

insert into sample_scores
values(101, '김유신', 100, 80, 80, '2023/04/17');

insert into sample_scores
(student_no, student_name, kor_score, eng_score, math_score)
values(102, '이순신', 80, 80, 80);

commit;

--------------------------------------------------------------------------------------------------
-- 시퀀스 생성하기
--------------------------------------------------------------------------------------------------
create sequence sample_student_seq start with 1000 nocache;
--------------------------------------------------------------------------------------------------
-- 시퀀스에서 새로운 일련번호 발행하기
--------------------------------------------------------------------------------------------------
select sample_student_seq.nextval
-- 1행 1열로 이루어진 dual객체
from dual; 

--------------------------------------------------------------------------------------------------
-- 새로운 행을 추가할 때 시퀀스에서 일련번호 발행받기
--------------------------------------------------------------------------------------------------
insert into sample_scores
(student_no, student_name, kor_score, eng_score, math_score)
values
(sample_student_seq.nextval, '류관순', 70, 70, 80);

select student_no, student_name, kor_score, eng_score, math_score,
       kor_score + eng_score + math_score as total_score,
       round ((kor_score + eng_score + math_score)/3, 1) as average
from sample_scores;












