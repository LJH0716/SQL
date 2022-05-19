--작가 table 생성
create table author(
 author_id number(10),
 author_name varchar2(100) not null,
 author_desc varchar2(500),
 primary key(author_id)
);

/******SEQUENCE(시퀀스)*******/
--연속적인 일렬번호 생성  PK에 주로 사용됨

--작가 sequence 생성
create sequence seq_author_id
increment by 1 --(1씩 증가)
start with 1
nocache;

INSERT INTO author
VALUES (seq_author_id.nextval, '박경리', '토지 작가 ' );

INSERT INTO author 
VALUES (seq_author_id.nextval, '이문열', '삼국지 작가');

INSERT INTO author 
VALUES (seq_author_id.nextval, '기안84', '웹툰작가');


select *
from author;

--현재 생성되어 있는 시퀀스 조회
select * 
from user_sequences;

--현재 시퀀스 조회
select seq_author_id.currval
from dual;

--다음 시퀀스 조회
select seq_author_id.nextval --무조건 다음 번호 실행시켜버림, 임시로 조회 X
from dual;

insert into author 
values (seq_author_id.nextval, '이정화', 'java'); --4가 아니라 5가 됨(다음 시퀀스 조회 때문에)
--PK는 숫자가 연속되지 않을 수도 있음, 빌 수도 있지만 OK, 중복되지만 않으면 됨!

--시퀀스 삭제
drop sequence seq_author_id;

--------------------------------------------------------------------------------------------------------

/****commit/ rollback****/

--commit (최종 반영) : 커밋이 반영하는 데이터 ->  DML(select, insert, update, delete), 다른것들은 다 반영되어있음(ex.시퀀스,테이블..)
									 --->select는 조회하는 거라 commit과 큰 관계없음 
--rollback : 전에 commit한 상태로 돌아감
--tranjaction : db에서의 논리적 작업 단위.장애가 발생했을 때 데이터 복구하는 작업 단위로 쓰이기도 함
                -->(commit이 작업 단위)

