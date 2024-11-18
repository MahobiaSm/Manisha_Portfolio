use employees_mod;
select from_date from t_dept_emp
where from_date > '1990-01-01';

## Task 1 Create a visualization that provides a breakdown between the male and female employees working in the company each year, starting from 1990.

select
 year(d.from_date) as Calander_year,
e.gender, count(e.emp_no) as Num_of_employees
from t_employees e
join t_dept_emp d on d.emp_no = e.emp_no
group by Calander_year, gender
having calander_year >= 1990 ;

## Compare the number of male managers to the number of female managers from different departments for each year, starting from 1990.
  
  select d.dept_name,
  dm.emp_no,
  ee.gender,
  dm.from_date, 
  dm.to_date,
  e.calander_year,
  Case when year(dm.to_date) >= e.calander_year and year( dm.from_date) <= e.calander_year then 1 else 0 
  end as Active 
  
  From (select year(hire_date) as calander_year
  from t_employees 
  group by calander_year) e 
  cross join 
  t_dept_manager dm 
  join  t_departments d on d.dept_no = dm.dept_no
  join t_employees ee on ee.emp_no = dm.emp_no
  order by dm.emp_no, calander_year;
  
  
  
  
  
  

