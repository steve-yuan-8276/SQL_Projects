-- View Tbale
SELECT * FROM DEPARTMENTS;
SELECT * FROM TITLES;
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPT_EMP;
SELECT * FROM DEPT_MANAGER;
SELECT * FROM SALARIES;

-- Data Analysis
-- 1.List the employee number, last name, first name, sex, and salary of each employee.
SELECT
	E.EMP_NO as "Employee Number",
	E.FIRST_NAME as "First Name",
	E.LAST_NAME as "Last Name",
	E.SEX as "Sex",
	S.SALARY as "Salary"
FROM
	EMPLOYEES E
	LEFT JOIN SALARIES S ON E.EMP_NO = S.EMP_NO;

-- 2.List the first name, last name, and hire date for the employees who were hired in 
-- 1986.
SELECT
	FIRST_NAME as "First Name",
	LAST_NAME as "Last Name",
	HIRE_DATE as "Hire Date"
FROM
	EMPLOYEES
WHERE
	DATE_PART('year', HIRE_DATE) = 1986
ORDER BY
	HIRE_DATE;

-- 3.List the manager of each department along with their department number, department
-- name, employee number, last name, and first name.

SELECT
	DM.DEPT_NO AS "Department Number",
	D.DEPT_NAME AS "Department Name",
	DM.EMP_NO AS "Employee Number",
	E.LAST_NAME AS "Last Name",
	E.FIRST_NAME AS "First Name"
FROM
	DEPT_MANAGER DM
	LEFT JOIN DEPARTMENTS D ON DM.DEPT_NO = D.DEPT_NO
	LEFT JOIN EMPLOYEES E ON DM.EMP_NO = E.EMP_NO;

-- 4.List the department number for each employee along with that employee’s employee 
-- number, last name, first name, and department name.

SELECT
	DE.DEPT_NO AS "Department Number",
	E.EMP_NO AS "Employee Number",
	E.LAST_NAME AS "Last Number",
	E.FIRST_NAME AS "First Number",
	D.DEPT_NAME AS "Department Name"
FROM
	EMPLOYEES E
	LEFT JOIN DEPT_EMP DE ON E.EMP_NO = DE.EMP_NO
	LEFT JOIN DEPARTMENTS D ON DE.DEPT_NO = D.DEPT_NO;
	
-- 5.List first name, last name, and sex of each employee whose first name is Hercules 
-- and whose last name begins with the letter B.

SELECT
	FIRST_NAME AS "First Name",
	LAST_NAME AS "Last Name",
	SEX AS "Sex"
FROM
	EMPLOYEES
WHERE
	FIRST_NAME = 'Hercules'
	AND LAST_NAME LIKE 'B%';

-- 6.List each employee in the Sales department, including their employee number, last 
-- name, and first name.

SELECT
	E.EMP_NO AS "Employee Number",
	E.LAST_NAME AS "Last Name",
	E.FIRST_NAME AS "First Name"
FROM
	EMPLOYEES E
	LEFT JOIN DEPT_EMP DE ON E.EMP_NO = DE.EMP_NO
	LEFT JOIN DEPARTMENTS D ON DE.DEPT_NO = D.DEPT_NO
WHERE
	D.DEPT_NAME = 'Sales';

-- 7.List each employee in the Sales and Development departments, including their 
-- employee number, last name, first name, and department name.

SELECT
	E.EMP_NO AS "Employee Number",
	E.LAST_NAME AS "Last Name",
	E.FIRST_NAME AS "First Name",
	D.DEPT_NAME AS "Department Name"
FROM
	EMPLOYEES E
	LEFT JOIN DEPT_EMP DE ON E.EMP_NO = DE.EMP_NO
	LEFT JOIN DEPARTMENTS D ON DE.DEPT_NO = D.DEPT_NO
WHERE
	D.DEPT_NAME IN ('Sales', 'Development');

-- 8.List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name).
WITH
	CTE AS (
		SELECT
			LAST_NAME,
			COUNT(1) AS CNT
		FROM
			EMPLOYEES
		GROUP BY
			LAST_NAME
	)
SELECT
	LAST_NAME AS "Last Name",
	CNT AS "Counts"
FROM
	CTE
ORDER BY
	"Counts" DESC;
