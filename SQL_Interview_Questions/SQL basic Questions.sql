-- SQL basic Questions

-- Q1：How to copy all rows from an existed table
create table employee_copy as
select * from employees;

-- review
select * from employee_copy;

-- Q2: How to create a new table by copying the schema from an existed table
create table emp_copy_schema like employees;

-- review
select * from emp_copy_schema;

-- Q3: how to get first 4 letter from a string?
-- method 1
select left(name, 4) from employee_copy;
-- method 2
select substring(name, 1, 4) from employee_copy;