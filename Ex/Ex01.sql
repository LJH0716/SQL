/*select 문
    select 절
    from 절
    where 절
    order by 절
*/

--모든 컬럼 조회하기
select *
from employees;

select *
from departments;

--원하는 컬럼만 조회하기
select employee_id,
        first_name, 
        last_name
from employees;

--예제)
--사원의 이름(first_name)과 전화번호 입사일 연봉을 출력하세요
select first_name, phone_number, hire_date, salary
from employees;

select  first_name 
        ,last_name
        ,salary 
        ,phone_number
        ,hire_date
from employees;

--출력할 때 컬럼명 별명 사용하기
select  first_name "이름"
        ,phone_number "전화번호"
        ,hire_date "입사일"
        ,salary "급여"
from employees;

select  first_name  as 이름 --기본
        ,last_name 성 --닉네임만 적어줘도 가능, 단 영어는 대문자처리해버려서 소문자는 ""해줘야함
        ,salary salary
        ,phone_number "전화번호"
        ,email "이메일"
        ,hire_date "입사일"
from employees;

--연결 연산자(컬럼 붙이기)
select first_name
       ,last_name 
from employees;

select first_name || last_name 
from employees;

select first_name || '      ' ||last_name 
from employees;

select first_name || ' hire date is '|| hire_date as 입사일
from employees;

--산술 연산자 
select  first_name
        ,salary
        ,salary*12
        ,(salary+300)*12
from employees;

select job_id*12
from employees;

select first_name || ' - ' || last_name as 성명
        ,salary as 급여
        ,salary*12 as 연봉
        ,salary*12+5000 as 연봉2
        ,phone_number as 전화번호
from employees;        
    
select first_name
from employees;

/*********where 절*********/
select first_name
from employees 
where department_id = 10;

--예제1
select first_name,salary
from employees
where salary*12 >=15000;

--예제2
select first_name,hire_date
from employees
where hire_date >= '07/01/01';

--예제3
select salary*12
from employees
where first_name = 'Lex';

--조건이 2개 이상 일때 한꺼번에 조회하기--
--연봉이 14000이상 17000이하인 사원의 이름과 연봉 구하기
select  first_name
        ,salary * 12
from employees
where salary >= 14000 
and salary <= 17000;

--연봉이 14000 이하이거나 17000 이상인 사원의 이름과 연봉을 출력하세요
--or 연산자
select  first_name as 이름
        ,salary * 12 as 연봉
from employees
where salary >= 14000 
or salary <= 17000;

--입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하기
--between 연산자(두 값을 모누 포함하는 경우 사용,경계 값 미포함하는 경우에는 사용불가,and 사용
select  first_name as 이름
        ,hire_date as 입사일
from employees
where hire_date between '04/01/01' 
and '05/12/31';

--in 연산자
select  first_name
        ,last_name
        ,salary
from employees
where first_name 
in ('Neena', 'Lex', 'John');

select  first_name
        ,last_name
        ,salary
from employees
where first_name ='Neena'
or first_name ='Lex'
or first_name ='John';

--예제
select  first_name
        ,salary
from employees
where salary
in(2100, 3100, 4100, 5100) ;

--Like 연산자로 비슷한 것들 모두 찾기
select first_name, last_name, salary
from employees
where first_name like 'L%';
--%는 임의의 길이의 문자열

select first_name, last_name, salary
from employees
where first_name like 'L___'; 
--_는 한 글자 길이

--예제 1
select  first_name
        ,salary
from employees
where first_name like '%am%';

--예제 2
select  first_name
        ,salary
from employees
where first_name like '_a%';

--예제 3
select  first_name
from employees
where first_name like '___a%';

--예제 4
select  first_name
from employees
where first_name like '_a__';

--null(아무런 값도 정해지지 않음, 0이 아님, 0도 값이 정해진 것)
-->어떤 데이터 타입에도 사용 가능, not null이나 primary key 속성에는 사용 불가
--1. null
select  first_name
        ,salary
        ,commission_pct
        ,salary*commission_pct
from employees
where commission_pct is null;
--2. not null
select  first_name
        ,salary
        ,commission_pct
        ,salary*commission_pct
from employees
where commission_pct is not null;

--예제 1
--커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select  first_name
        ,salary
        ,commission_pct
from employees
where commission_pct is not null;

--예제 2
--담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
select  first_name
from employees
where manager_id is null 
and commission_pct is null;

select  first_name
        ,salary
from employees
where salary>=10000;

/*******order by 절 이용해 정렬*********/
select  first_name
        ,salary
from employees
order by salary desc;
--내림차순

select  first_name
        ,salary
from employees
where salary>=9000
order by salary asc;
--오름차순(기본 적용, 생략 가능)

--예제 1
--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요

select  department_id
        ,salary
        ,first_name
from employees
order by department_id asc;

--예제 2
--급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select  first_name
        ,salary
from employees
where salary >= 1000
order by salary desc;

--예제 3 **
--정렬 여러 개 일때
--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요
select  department_id
        ,salary
        ,first_name
from employees
order by department_id asc, salary desc;
--앞에서부터 처리, 앞의 값이 같을 때 그 다음 조건 정렬 수행

/***************************
단일행 함수
***************************/
--<1.문자함수>

--문자함수(initcap:첫글자만 대문자로 변경)
select  email
        ,initcap(email) as email2
        ,department_id
from employees
where department_id = 100;

--문자함수 LOWER(컬럼명;모두 소문자 변경) / UPPER(컬럼명;모두 대문자 변경)
select  first_name
        ,lower(first_name) as lower
        ,upper(first_name) as upper
from employees
where department_id = 100;

--문자함수 SUBSTR(컬럼명,시작위치,글자수)
-->주어진 문자열에서 특정 길이의 문자열 구함
select  first_name
        ,substr(first_name,1,3)
        ,substr(first_name,-3,2)
from employees
where department_id = 100;

--문자함수  LPAD(컬럼명, 자리수, ‘채울문자’) / RPAD(컬럼명, 자리수, ‘채울문자’)
-->LPAD() :왼쪽 공백에 특별한 문자로 채우기
-->RPAD() :오른쪽 공백에 특별한 문자로 채우기
select first_name, 
lpad(first_name,10,'*'), 
rpad(first_name,10,'*')
from employees;

--문자함수  REPLACE (컬럼명, 문자1, 문자2)
-->컬럼명에서 문자1을 문자2로 바꾸는 함수
select first_name, 
replace(first_name, 'a', '*') 
from employees
where department_id =100;
--응용
select first_name, 
replace(first_name, 'a', '*'), 
replace(first_name, substr(first_name, 2, 3), '***')
from employees
where department_id =100;

--dual 로 테스트 해볼 수 있음(가상의 테이블)
select replace('abcdefg', 'bc','******')
from dual;

select substr('920716-2345678',8,2)
from dual;

----------------------------------------------------------------------------
--<2.숫자함수>

--숫자함수 ROUND(숫자, 출력을 원하는 자리수) 
-->주어진 숫자의 반올림
select  round(123.346, 2) "r2",
        round(123.456, 0) "r0",
        round(123.456, -1) "r-1"
from dual;

--숫자함수  TRUNC(숫자, 출력을 원하는 자리수) 
-->주어진 숫자를 버림
select  trunc(123.346, 2) "r2",
        trunc(123.456, 0) "r0",
        trunc(123.456, -1) "r-1"
from dual;

---------------------------------------------------------------------------------
--<3.날짜함수>

--날짜함수 – SYSDATE()
-->현재날짜와 시간을 출력
select sysdate
from dual;

select sysdate
from employees;

select months_between(sysdate, hire_date) 
from employees
where department_id = 110;

-------------------------------------------------------------------------
--<4.변환함수>

-- TO_CHAR(숫자, ‘출력모양’) 숫자형  문자형으로 변환

-->1.6자리까지 표시
select first_name, 
to_char(salary*12, '999999') "SAL"
from employees
where department_id =110;
-->2.빈자리를 0으로 채우기
select first_name, 
to_char(salary*12, '0999999') "SAL"
from employees
where department_id =110;
-->3.$ 표시를 붙여서 표시
select first_name, 
to_char(salary*12, '$999999') "SAL"
from employees
where department_id =110;
-->4.소수점 이하 표시
select first_name, 
to_char(salary*12, '9999999.99') "SAL"
from employees
where department_id =110;
-->5.천 단위 구분 기호 표시
select first_name, 
to_char(salary*12, '$999,999') "SAL"
from employees
where department_id =110;

-- TO_CHAR(날짜, ‘출력모양’) 날짜형  문자형으로 변환
select sysdate, 
to_char(sysdate, 'YYYY'),
to_char(sysdate, 'YY'),
to_char(sysdate, 'MM'),
to_char(sysdate, 'DD'),
to_char(sysdate, 'DAY'),
to_char(sysdate, 'HH24'),
to_char(sysdate, 'HH'),
to_char(sysdate, 'MI'),
to_char(sysdate, 'SS'),
to_char(sysdate, 'YYYY"년" MM"월" DD"일"'),
to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
from dual;

-- NVL(컬럼명, null일때값)/NVL2(컬럼명, null아닐때값, null일때 값)
select  first_name,
        commission_pct,
        nvl(commission_pct, 0),
        nvl2(commission_pct, 100, 0)
from employees;



