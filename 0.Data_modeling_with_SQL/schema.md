Departments
-
dept_no varchar(5) PK
dept_name varchar(20)

Titles
-
title_id varchar(5) PK
title varchar(20)

Employees
-
emp_no int PK
emp_title_id varchar(5) FK >- Titles.title_id
birth_date date
first_name varchar
last_name varchar
sex varchar(1)
hire_date date

Dept_emp
-
emp_no int PK FK >- Employees.emp_no
dept_no varchar(5) PK FK >- Departments.dept_no

Dept_manager
-
dept_no varchar(5) PK FK >- Departments.dept_no
emp_no int PK FK >- Employees.emp_no

Salaries
-
emp_no int PK FK >- Employees.emp_no
salary int