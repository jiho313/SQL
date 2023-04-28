-- 오라클 12c 이후부터는 "c##아이디"와 같은 형태고 계정명을 생성해야 한다.
-- 아래의 명령어는 "c##"을 포함시키지 않고 계정명을 정의하게 한다.
ALTER SESSION SET "_ORACLE_SCRIPT" = true;

-- 샘플 계정 생성하기
-- 계정명: hr, 비밀번호: zxcv1234
-- CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER hr identified by zxcv1234;

-- 샘플 계정에 권한 부여하기
-- 접속권한(롤): CONNECT, 리소스 사용권한(롤): RESOURCE, 관리자권한(롤): DBA
-- GRANT 권한, 권한 TO 계정명;
GRANT CONNECT, RESOURCE, DBA TO hr;