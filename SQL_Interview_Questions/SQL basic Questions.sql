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

-- Q4:how to find duplicates in a table?
select
    employee_id,
    count(*) as cnt
from
    employee_copy
group by employee_id
having count(*) > 1;

-- Q5: how to remove the duplicates in a table?
delete from employee_copy
where employee_id not in (
    select
        employee_id
    from (
            select
                min(employee_id) as employee_id
            from
                employee_copy
            group by name
         ) as sub_query
    );

-- test
INSERT INTO employee_copy (employee_id, name) VALUES
(6, 'Alice Johnson'),
(7, 'Bob Smith'),
(8, 'Charlie Brown'),
(9, 'Diana Prince'),
(10, 'Edward Norton'),
(11, 'Fiona Shrek'),
(12, 'George Jetson'),
(13, 'Harry Potter')

-- review
select * from employee_copy;

