--Practice 05

--문제 1
/*담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의
이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
(45건)
*/

select  first_name
        ,manager_id
        ,commission_pct
        ,salary
from employees
where salary > 3000
and manager_id is not null
and commission_pct is null;

--문제 2 
/*각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여
(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하
세요
-조건절비교 방법으로 작성하세요
-급여의 내림차순으로 정렬하세요
-입사일은 2001-01-13 토요일 형식으로 출력합니다.
-전화번호는 515-123-4567 형식으로 출력합니다.
(11건)
*/

select  employee_id
        ,first_name
        ,salary
        ,to_char(hire_date,'YYYY-MM-DD DAY')
        ,replace(phone_number,'.','-')
        ,department_id
from employees
where (department_id, salary) IN (select  department_id
                                          ,max(salary)
                                  from employees
                                  group by department_id)
order by salary desc;


--문제 3
/*매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다.
-통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.
-매니저별 평균급여가 5000이상만 출력합니다.
-매니저별 평균급여의 내림차순으로 출력합니다.
-매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
-출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매
니저별최대급여 입니다.
(9건)
*/

select  em.manager_id
        ,em.first_name
        ,manag.avg
        ,manag.min
        ,manag.max
from employees em, (select   manager_id
                            ,round(avg(salary),0) avg
                            ,min(salary) min
                            ,max(salary) max
                    from employees
                    where hire_date >= '2005/01/01'
                    group by manager_id
                    having round(avg(salary),0) >= 5000) manag
where em.employee_id = manag.manager_id
order by manag.avg desc;


--문제 4
/*각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명
(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
부서가 없는 직원(Kimberely)도 표시합니다.
(106명)
*/

select  em.employee_id
        ,em.first_name
        ,de.department_name
        ,manag.first_name
from employees em, employees manag, departments de
where em.manager_id = manag.employee_id
and em.department_id = de.department_id(+);


--문제 5
/*2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의
사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
*/


--문제 6
/*가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름
(department_name)은?
*/

select  em.first_name|| ' ' ||last_name as 이름
        ,em.salary
        ,de.department_name
        ,em.hire_date
from employees em, departments de
where hire_date = (select max(hire_date)
                   from employees)
and em.department_id = de.department_id;


--문제 7
/*평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성
(last_name)과 업무(job_title), 연봉(salary)을 조회하시오.
*/

--문제 8
--/*평균 급여(salary)가 가장 높은 부서는? */

--문제 9
/*평균 급여(salary)가 가장 높은 지역은?*/ 

--문제 10
/*평균 급여(salary)가 가장 높은 업무는? */

