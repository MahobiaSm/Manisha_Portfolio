USE employees;
COMMIT;
DELIMITER $$
CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = 0; 
	END IF; 
END $$

DELIMITER ;
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';
    
INSERT INTO salaries VALUES ('10001', -92891, '2010-06-22', '9999-01-01');
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001';
    
    DELIMITER $$

CREATE TRIGGER trig_upd_salary
BEFORE UPDATE ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = OLD.salary; 
	END IF; 
END $$

DELIMITER ;
UPDATE salaries 
SET 
    salary = 98765
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';

SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';
  
  UPDATE salaries 
SET 
    salary = - 50000
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';
SELECT SYSDATE();
SELECT DATE_FORMAT(SYSDATE(), '%y-%m-%d') as today;

DELIMITER $$

CREATE TRIGGER trig_ins_dept_mng
AFTER INSERT ON dept_manager
FOR EACH ROW
BEGIN
	DECLARE v_curr_salary int;
    
    SELECT 
		MAX(salary)
	INTO v_curr_salary FROM
		salaries
	WHERE
		emp_no = NEW.emp_no;

	IF v_curr_salary IS NOT NULL THEN
		UPDATE salaries 
		SET 
			to_date = SYSDATE()
		WHERE
			emp_no = NEW.emp_no and to_date = NEW.to_date;

		INSERT INTO salaries 
			VALUES (NEW.emp_no, v_curr_salary + 20000, NEW.from_date, NEW.to_date);
    END IF;
END $$

DELIMITER ;
INSERT INTO dept_manager VALUES ('111534', 'd009', date_format(sysdate(), '%y-%m-%d'), '9999-01-01');
SELECT 
    *
FROM
    dept_manager
WHERE
    emp_no = 111534;
    
SELECT 
    *
FROM
    salaries
WHERE
    emp_no = 111534;
ROLLBACK;

Delimiter $$
create trigger trig_hire_date
before insert on employees
for each row
begin 
if new.hire_date > date_format(sysdate(),'%y-%m-%d') then 
set new.hire_date = date_format(sysdate(), '%y-%m-%d' );
end if;
 end$$
 Delimiter ;
 
 insert employees values ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');  
 select * from employees order by emp_no desc;
 
 Alter table employees
   Drop index i_hire_date ;
 
 select * from salaries
 where salary > 89000;
 
 create index i_salary on salaries (salary);
  select * from salaries;
 use employees;

select e.emp_no,
e.first_name, e.last_name,
case when dm.emp_no is not null then 'Manager'
else 'Employee'
end as 'is manager'
from employees e
left join dept_manager dm on dm.emp_no = e.emp_no
where e.emp_no > '109990' ;

SELECT dm.emp_no,  e.first_name,  e.last_name,  
MAX(s.salary) - MIN(s.salary) AS salary_difference,  
    CASE  
          WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more then $30,000'  
          ELSE 'Salary was NOT raised by more then $30,000'  
   END AS salary_raise  
FROM  dept_manager dm  
JOIN  
employees e ON e.emp_no = dm.emp_no  
JOIN  
salaries s ON s.emp_no = dm.emp_no  
GROUP BY s.emp_no;  

SELECT  dm.emp_no,  e.first_name,  e.last_name,  
MAX(s.salary) - MIN(s.salary) AS salary_difference,  
IF(MAX(s.salary) - MIN(s.salary) > 30000, 'Salary was raised by more then $30,000', 'Salary was NOT raised by more then $30,000') AS salary_increase  
FROM  dept_manager dm  
JOIN  employees e ON e.emp_no = dm.emp_no  
JOIN  salaries s ON s.emp_no = dm.emp_no  
  GROUP BY s.emp_no;
   
select e.emp_no, e.first_name, e.last_name,
case  when max(de.to_date) > sysdate() then 'Is still Employed'
else 'Not an Employee anymore'
end as Current_Employee
from employees e
join dpt_emp de
on de.emp_no = e.emp_no
group by de.emp_no
limit 100;

select* from dept_emp;

SELECT

    e.emp_no,

    e.first_name,

    e.last_name,

    CASE

        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'

        ELSE 'Not an employee anymore'

    END AS current_employee

FROM

    employees e

        JOIN

    dept_emp de ON de.emp_no = e.emp_no

GROUP BY de.emp_no

LIMIT 100;

SELECT     
    dm.emp_no,
    e.first_name,
    e.last_name,
    e.hire_date,
    MIN(s.salary) AS min_salary,
    MAX(s.salary) AS max_salary,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
		WHEN MAX(s.salary) - MIN(s.salary) <= 10000 AND MAX(s.salary) - MIN(s.salary) > 0 
    THEN 'insignificant'
        WHEN MAX(s.salary) - MIN(s.salary) > 10000 THEN 'significant'
        ELSE 'salary decrease'
	END as salary_raise
FROM 
dept_manager dm
JOIN
employees e ON dm.emp_no = e.emp_no
JOIN
salaries s ON s.emp_no = dm.emp_no
WHERE dm.emp_no > 10005
GROUP BY s.emp_no, e.first_name, e.last_name, e.hire_date 
ORDER BY dm.emp_no;

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) >= '2025-01-01' THEN 'Currently working'
        ELSE 'No longer with the company'
    END AS current_status
FROM
    employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY e.emp_no, e.first_name, e.last_name;







  
  
  
  
  
  

 
 
 

 







