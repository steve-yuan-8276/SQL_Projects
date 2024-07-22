-- Big4 SQL Question

-- Prepare: Create table
CREATE TABLE EMPLOYEE_ABC (
	E_ID INT,
	E_NAME VARCHAR(20),
	E_SALARY INT,
	E_AGE INT,
	E_GENDER VARCHAR(20),
	E_DEPT VARCHAR(20)
);

-- Insert the Data
INSERT INTO
	EMPLOYEE_ABC
VALUES
	(1, 'Sam', 95000, 45, 'Male', 'Operations'),
	(2, 'Bob', 80000, 21, 'Male', 'Support'),
	(3, 'Anne', 125000, 25, 'Female', 'Analytics'),
	(4, 'Julia', 73000, 30, 'Female', 'Analytics'),
	(5, 'Matt', 159000, 33, 'Male', 'Sales'),
	(6, 'Jeff', 112000, 27, 'Male', 'Operations'); 

-- check status
select * from employee_abc

-- Try to solve these questions
-- 1.Fetch all the data from table employee_abc sorted by the employee's name in desc order
SELECT
	*
FROM
	EMPLOYEE_ABC
ORDER BY
	E_NAME DESC;

-- 2. Fetch the details of the employee with highest salary in the company.
SELECT
	*
FROM
	EMPLOYEE_ABC
ORDER BY
	E_SALARY DESC
LIMIT
	1;

SELECT
	*
FROM
	EMPLOYEE_ABC
WHERE
	E_SALARY = (
		SELECT
			MAX(E_SALARY)
		FROM
			EMPLOYEE_ABC
	);

-- 3.Find the number of employees whose age between 25 and 35
SELECT
	*
FROM
	EMPLOYEE_ABC
WHERE
	E_AGE > 25
	AND E_AGE < 35;

-- 4. What's the average age of all emoloyees in the company, rounded off to 2 decimal places?
SELECT
	ROUND(AVG(E_AGE), 2)
FROM
	EMPLOYEE_ABC;

-- 5.What's the maximum and average salary of employee in each department?
SELECT
	E_DEPT,
	MAX(E_SALARY),
	AVG(E_SALARY)
FROM
	EMPLOYEE_ABC
GROUP BY
	E_DEPT
ORDER BY
	E_DEPT;

-- 6.Total number of employees working in each department?
SELECT
	E_DEPT,
	COUNT(1)
FROM
	EMPLOYEE_ABC
GROUP BY
	E_DEPT
ORDER BY
	E_DEPT;

-- 7. Suppose the company has announced a salary increment of 20% for all the employees. Write an SQL 
--query to print the employee details and the corresponding incremented salary.

SELECT
	E_ID,
	E_NAME,
	E_AGE,
	E_GENDER,
	E_DEPT,
	ROUND((E_SALARY * 1.2), 2) AS INCREMENTED_SALARY
FROM
	EMPLOYEE_ABC
ORDER BY
	INCREMENTED_SALARY DESC;