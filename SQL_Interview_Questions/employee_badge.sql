-- Q2: Absentee
# Assuming you are the database administrator of the company, each employee must
# be associated with a valid access card. A indicates that the access card status
# is active, and 1 indicates inactive. Each employee can have multiple access cards,
# but only one can be active at any given time. By default, the most recently issued
# access card is considered valid. Please answer the following questions based on
# the employee table (including employee ID and name) and the access card table
# (including access card ID, employee ID, status, and badge_seq):

# Tasks:
# 1) Query all employees' valid access cards;
# 2) Update employees' access card status;
# 3) When an employee loses their access card, update its badge status and badge seq

-- Data Preparation
-- create table employees
create table if not exists employees(
    employee_id int not null primary key,
    name varchar(30) not null
);

-- create table badge_infos
create table if not exists badge_infos(
    badge_id int not null primary key,
    employee_id int not null,
    issued_date date not null,
    badge_status varchar(1) not null,
    badge_seq int not null,
    constraint valid_badge_status check ( badge_status in ('A', 'I') ),
    constraint valid_badge_seq check ( badge_seq > 0 ),
    foreign key (employee_id) references employees(employee_id)
);

-- Insert data into employees table
INSERT INTO employees (employee_id, name) VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Charlie Brown'),
(4, 'Diana Prince'),
(5, 'Edward Norton');

-- Insert data into badge_infos table with badge_status
INSERT INTO badge_infos (badge_id, employee_id, issued_date, badge_seq, badge_status) VALUES
(101, 1, '2023-01-15', 1, 'A'),
(102, 2, '2023-02-20', 2, 'A'),
(103, 3, '2023-03-10', 3, 'A'),
(104, 4, '2023-04-25', 1, 'A'),
(105, 5, '2023-05-05', 2, 'A'),
(106, 1, '2023-06-12', 2, 'A'),
(107, 3, '2023-07-18', 4, 'A'),
(108, 2, '2023-08-22', 3, 'A'),
(109, 4, '2023-09-01', 2, 'A'),
(110, 5, '2023-10-11', 3, 'A');

-- Solution
-- Step 1: Query all employees' valid access cards;
create view active_access_card as (
    with cte as (
        select
            badge_id,
            employee_id,
            issued_date,
            badge_status,
            badge_seq,
            row_number() over (partition by employee_id order by issued_date DESC) as rn
        from
            badge_infos
    )
    select
        e.employee_id,
        e.name,
        c.badge_id,
        c.issued_date,
        c.badge_status,
        c.badge_seq
    from
        employees e left join cte c
        on e.employee_id = c.employee_id
    where
        c.rn = 1 and c.rn is not null
    );


-- Step 2: Update employees' access card status;
update badge_infos
set badge_status =
    case
        when badge_id in (
            select
                a.badge_id
            from
                active_access_card a
            ) then 'A'
        else
            'I'
    end;

# review
select * from badge_infos;

-- Step 3: When an employee loses their access card, update its badge status and badge seq
-- Assuming employee_id 5 lost his badge and get a new one.
update badge_infos
set badge_status = 'I',
    badge_seq = badge_seq + 1
where
    badge_id = (
        select
            badge_id
        from (
            select
                badge_id
            from
                badge_infos
            where employee_id = 5
            order by issued_date DESC
            limit 1 offset 1
             ) as subquery
    );

