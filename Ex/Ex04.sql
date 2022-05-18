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
                
--각 부서별로 최고급여를 받는 사원이름을 출력하세요
--where절로 구하기
select  department_id,
        max(salary)
from employees
group by department_id;


select  first_name,
        salary,
        department_id,
        email
from employees
where (department_id, salary) in ( select  department_id,
                                           max(salary)
                                   from employees
                                   group by department_id  );

--각 부서별로 최고급여를 받는 사원이름을 출력하세요
--테이블로 구하기

select  e.first_name,
        e.salary,
        e.department_id,
        s.department_id,
        s.maxSalary
from employees e, (select department_id, 
                          max(salary) maxSalary
                   from employees
                   group by department_id) s  
where e.department_id = s.department_id
and e.salary = s.maxSalary;                

--------------------------------------------------------------------------------
/*****rownum*****/

--급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.
--정렬을 하면 rownum이 섞인다 -->정렬을 하고 rownum 을 준다
select  rownum,
        employee_id,
        first_name,
        salary
from employees   -- 미리 정렬되어 있는 테이블이면 rownum이 섞이지 않는다
order by salary desc;

-->정렬(정렬된 테이블 사용)하고 rownum을 준다
select  rownum,
        ot.employee_id,
        ot.first_name,
        ot.salary
from (select  employee_id,
              first_name,
              salary
      from employees
      order by salary desc) ot ;


--rownum을 이용해서 원하는 순위의 값을 선택한다(where절)
--where절이 2번 부터이면 데이터가 없다 (rownum이 항상 1이다)
select  rownum ,
        ot.employee_id,
        ot.first_name,
        ot.salary
from (select  employee_id,
              first_name,
              salary
      from employees
      order by salary desc) ot  --정렬도 되어 있고  rownum로 있는 테이블이면?
where rownum >= 2
and rownum <= 5;

-->(1)정렬하고 (2)rownum이 있는 테이블을 사용하고 (3)where절을 쓴다
select  ort.rn,
        ort.first_name,
        ort.salary
from (select  rownum rn,
              ot.employee_id,
              ot.first_name,
              ot.salary
      from (select  employee_id,
                    first_name,
                    salary
            from employees
            order by salary desc) ot   --(1)
      )ort  --(2)
where rn >= 2
and rn<=5;  --(3)
