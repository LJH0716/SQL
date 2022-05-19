/******DCL(Data Control Language, 데이터 제어어)-User 관리******/

--사용자 생성: CREATE USER user IDENTIFIED BY passwd;
--비밀번호 변경: ALTER USER user IDENTIFIED BY passwd;
--사용자 삭제: DROP USER user [CASCADE];

--계정 생성: create user webdb identified by 1234; 
--접속권한 부여: grant resource, connect to webdb;
--계정 비밀번호 변경: alter user webdb identified by webdb;
--계정 삭제 : drop user webdb cascade;


--테이블 생성
/******DDL(Data Definition Language, 데이터 정의어) --> 테이블 관리******/
create table book(book_id number(5)
                  ,title varchar2(50)
                  ,author varchar2(10)
                  ,pub_date date);
                  
alter table book add(pubs varchar2(50));      

alter table book modify (title varchar2(100));

alter table book rename column title to subject;

alter table book drop (author);

rename book to article;

DROP TABLE book;
                  
select *
from article;

--논리설계 ->물리설계 순서로 테이블 생성
--논리설계(ex.작가코드,작가명, 설명) ,물리설계(자료형)

--------------------------------------------------------------------------------
/****DML(Data Manipulation Language, 데이터 조작어) --> 테이블 관리*****/

create table author(
     author_id number(10)
    ,author_name varchar2(100) not null
    ,author_desc varchar2(500)
    ,primary key(author_id)--primary key는 한 테이블에 하나만 존재
    );
    

/*INSERT*/
--묵시적 방법
INSERT INTO author
VALUES (1, '박경리', '토지 작가');

--명시적으로 지정해주는 방법
INSERT INTO author( author_id, author_name )
VALUES (2, '이문열' );

INSERT INTO author( author_id, author_name )
VALUES (3, '기안84' );

select *
from author;

CREATE TABLE book (
                    book_id NUMBER(10),
                    title VARCHAR2(100) NOT NULL,
                    pubs VARCHAR2(100),
                    pub_date DATE,
                    author_id NUMBER(10),
                    PRIMARY KEY(book_id),
                    CONSTRAINT book_fk FOREIGN KEY (author_id)
                    REFERENCES author(author_id)
 );


select *
from book;

--1, 토지, 마로니에북스, 2012-08-15, 1
insert into book
values(1, '토지', '마로니에북스', '2012-08-15', 1);

--2, 삼국지, 민음사, 2002-03-01, 2
insert into book
values(2, '삼국지', '민음사', '2002-03-01', 2);

----------------------------------------------------------------------------------
/*UPDATE*/

UPDATE author
SET author_desc = '삼국지 작가'
WHERE author_id = 2 ;

UPDATE author
SET author_name = '김경리'
    ,author_desc = '토지 작가'
WHERE author_id = 1 ;

--------------------------------------------------------------------------------------
/*DELETE*/

/*DELETE FROM author
WHERE author_id = 1 ;*/
--오류발생 ORA-02292: integrity constraint (WEBDB.BOOK_FK) violated - child record found
--오류나는 이유: book 테이블에서 FK키로 author_id 엮여 있어서 
--해결방법
/*
FOREIGN KEY = 외래키
일반적으로 REFERENCE 테이블의 PK를 참조
REFERENCE 테이블에 없는 값은 삽입 불가
REFERENCE 테이블의 레코드 삭제 시 동작
- ON DELETE CASCADE: 해당하는 FK를 가진 참조행도 삭제 ***
- ON DELETE SET NULL: 해당하는 FK를 NULL로 바꿈 ***
*/


--조건을 만족하는 레코드를 삭제
DELETE FROM author
WHERE author_id = 3 ;

--조건이 없으면 모든 데이터 삭제(주의**,백업!!!)
DELETE FROM author ;


select *
from author;
