/*
데이터 변경하기
    - 형식
        update 테이블명
        set
            컬럼명 = 값,
            컬럼명 = 값;
            지정된 테이블에서 모든 행에 대해서 지정된 컬럼의 값을 변경한다.
            
        update 테이블명
        set
            컬럼명 = 값,
            컬럼명 = 값,
            컬럼명 = 값
        where 조건식;
            지정된 테이블에서 제시된 조건식이 true로 판정되는 행에 대해서 지정된 컬럼의 값을 변경한다.
        
데이터 삭제하기
    - 형식
        delete from 테이블명;
            지정된 테이블에서 모든 행을 삭제한다.
            
        delete from 테이블명;
        where 조건식;
            지정된 테이블에서 제시된 조건식이 true로 판정되는 행을 전부 삭제한다.
            
*   update, delete 구문으로 삭제한 모든 행은 commit; 명령을 실행해서 데이터베이스에 반영시키기
    전까지는 복구할 수 있다.
        - commit으로수행결과가 반영된 inset, update, delete 명령에 대해서는 롤백이 적용되지 않는다.
    rollback
        - inset, update, delete 명령 수행결과를 데이터 베이스에 반영시키는 것을 전부 취소기킨다.
*/

-- 학번이 1000번인 학생 성적정보 삭제하기
delete from sample_scores
where student_no = 1000;

-- 모든 학생의 성적정보 삭제하기
delete from sample_scores;

-- delete 구문 실행 결과의 데이터베이스의 반영을 전부 취소시키기
rollback;

-- 100번 학생의 국어점수, 수학점수, 영어점수 변경하기
update sample_scores
set
    kor_score = 100,
    eng_score = 100,
    math_score = 100
where student_no = 1000;

-- 60번 부서에 소속된 직원의 급여를 10% 인상시키기
update employees
set
    salary = salary*1.1
where department_id = 60;

update employees
set
    salary = 10000;
    
rollback;


