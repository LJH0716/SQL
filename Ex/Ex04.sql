/**************************
SubQuery (하나의 SQL 질의문 속에 다른 SQL 질의문이 포함되어 있는 형태)
**************************/

--‘Den’ 보다 급여를 많은 사람의 이름과 급여는?

select salary
from employees
where first_name ='Den'; --11000


select  first_name
        ,salary
from employees
where salary >= (select salary
                 from employees
                 where first_name ='Den')
order by salary asc;

--예제 1
--급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?

select  first_name
        ,salary
        ,employee_id
from employees
where salary =( select min(salary)
                from employees);

--예제 2
--평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요?

select  first_name
        ,salary
from employees
where salary < ( select avg(salary)
                from employees)
order by salary desc;

/*다중행 SubQuery*/
--부서번호가 110인 직원의 급여와 같은 모든 직원의 사번, 이름, 급여를 출력하세요
--'~와 같은'(IN:=)
select salary
from employees
where department_id = 110; --12008, 8300


select  employee_id
        ,first_name
        ,salary
from employees
where salary in (select salary
                from employees
                where department_id = 110); --12008,8300

