-- Create table fiscal_years table, includes 3 columns:
-- fiscal_year, start_date, end_date, add proper constraint

-- Solution:

-- create interview database
create database interview_DB;

-- cd interview_DB
use interview_DB;

-- Create table
create table if not exists fiscal_years
(
    fiscal_year int not null primary key,
    start_date date not null,
    end_date date not null,
    constraint valid_start_date check (
        extract(year from start_date) = fiscal_year -1
        and extract(month from start_date) = 10
        and extract(day from start_date) = 1),
    constraint valid_end_date check (
        extract(year from end_date) = fiscal_year
        and extract(month from end_date) = 9
        and extract(day from end_date) = 30)
);