--practice 04

--문제 1
/*평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
(56건)
*/

select count(salary)
from employees
where salary <ANY (select avg(salary)
                   from employees);

--문제 2
/*평균급여 이상, 최대급여 이하의 월급을 받는 사원의
직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 오름차
순으로 정렬하여 출력하세요
(51건)
*/

select  employee_id
        ,first_name
        ,e.salary
        ,s.avgsalary
        ,s.maxsalary
from employees e, (select avg(salary) avgsalary
                         ,max(salary) maxsalary
                          from employees) s
where e.salary >= s.avgSalary
and e.salary <= s.maxSalary
order by salary asc;


--문제 3
/*직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소
를 알아보려고 한다.
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주
(state_province), 나라아이디(country_id) 를 출력하세요
(1건)
*/

select  lo.location_id
        ,lo.street_address
        ,lo.postal_code
        ,lo.city
        ,lo.state_province
        ,lo.country_id
from departments de, locations lo, (select department_id
                                    from employees
                                    where first_name ='Steven'
                                    and last_name = 'King') em
where de.location_id = lo.location_id
and de.department_id = em.department_id;


--문제 4
/*job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로
출력하세요 -ANY연산자 사용
(74건)
*/

select  employee_id
        ,first_name
        ,salary
from employees
where salary <ANY(  select  em.salary
                    from employees em
                    where  job_id = 'ST_MAN')
order by salary desc;


--문제 5
/*각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 급여
(salary) 부서번호(department_id)를 조회하세요
단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)
*/

--1.조건절 비교
select  employee_id
        ,first_name
        ,salary
        ,department_id
from employees
where (salary, department_id) in (select max (salary)
                                         ,department_id
                                  from employees
                                  group by department_id)
order by salary desc;

--2.테이블 조인
select employee_id
       ,first_name
       ,e.salary
       ,e.department_id
from employees e, (select max(salary) salary
                          ,department_id
                   from employees
                   group by department_id) s
where e.department_id = s.department_id
and e.salary = s.salary
order by salary desc;

--문제 6
/*각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오
(19건)
*/

select  j.job_title as 업무명
       ,s.salary as 연봉총합
from jobs j, ( select job_id
              ,sum(salary) salary
              from employees
              group by job_id) s
where j.job_id = s.job_id
order by s.salary desc;


--문제 7
/*자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 이름
(first_name)과 급여(salary)을 조회하세요
(38건)
*/

select  em.employee_id
        ,em.first_name
        ,em.salary
from employees em, (select  department_id
                            ,avg(salary) salary
                    from employees
                    group by department_id) s
where em.department_id = s.department_id
and em.salary > s.salary;


--문제 8
/*직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력
하세요
*/
