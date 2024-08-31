-- Q：Consecutive login days
-- Assuming there is a user login log table that records the login
-- times of users every day. Count the start date, end date, and
-- number of consecutive login days for each user.

-- Data Preparation
-- create table
create table if not exists consecutive_login (
    user_id int not null,
    login_date date not null
);

-- insert data
-- user 1
INSERT INTO consecutive_login (user_id, login_date) VALUES
(1, '2024-01-01'),
(1, '2024-01-02'),
(1, '2024-01-03'),
(1, '2024-01-04'),
(1, '2024-01-05');

-- user 2
INSERT INTO consecutive_login (user_id, login_date) VALUES
(2, '2024-01-03'),
(2, '2024-01-04'),
(2, '2024-01-06');

-- user 3
INSERT INTO consecutive_login (user_id, login_date) VALUES
(3, '2024-01-05'),
(3, '2024-01-06'),
(3, '2024-01-07');

select * from consecutive_login;

-- Solution:
with t as (
    select
        user_id,
        login_date,
        date_sub(login_date, interval (row_number() over (partition by user_id order by login_date)) day ) as day_group
    from
        consecutive_login
)

select
    user_id,
    min(login_date) as start_date,
    max(login_date) as end_date,
    count(user_id) as consecutive_days
from
    t
group by user_id, day_group
having count(user_id) > 1
order by user_id;