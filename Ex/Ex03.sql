/**********************
* Join
***********************/

/*equi join*/

select *
from employees, departments;

select  employee_id ,
        first_name,
        salary,
        department_name,
        em.department_id "e_did",
        de.department_id "d_did"
from employees em, departments de
where em.department_id = de.department_id;

--모든 직원이름, 부서이름, 업무명 을 출력하세요
select  e.first_name,
        d.department_name,
        j.job_title,
        e.salary,
        e.department_id,
        d.department_id,
        e.job_id,
        j.job_id
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id
and e.salary >= 7000
order by salary desc;

/*left outer join*/

--1.표준 문법(방법1)
select  em.first_name
        ,em.department_id
        ,de.department_name
        ,de.department_id
from employees em left outer join departments de
on em.department_id = de.department_id;

--2.oracle(방법2)
select  em.first_name
        ,em.department_id
        ,de.department_name
        ,de.department_id
from employees em, departments de
where em.department_id = de.department_id(+);

/*right outer join*/

--1.표준 문법(방법 1)
select  em.first_name
        ,em.department_id
        ,de.department_name
        ,de.department_id
from employees em right outer join departments de
on em.department_id = de.department_id;

--2.oracle(방법 2)
select  em.first_name
        ,em.department_id
        ,de.department_name
        ,de.department_id
from employees em, departments de
where em.department_id(+) = de.department_id;

/*full outer join*/
--(em과 de의 합집합), 오라클 표현 방법은 따로 없음
select  em.first_name
        ,em.department_id
        ,de.department_name
        ,de.department_id
from employees em full outer join departments de
on em.department_id = de.department_id;

/******self join******/
--많이 쓰임, 중요!
--같은 employees 테이블에서 join하는 경우 ex.103번 알렉산더의 매니저 정보를 가져올때
--매니저 아이디도 employee_id에 저장되어 있음
select  em.first_name
        ,em.salary
        ,em.phone_number
        ,manag.first_name
        ,manag.phone_number
from employees em, employees manag
where em.manager_id = manag.employee_id;

