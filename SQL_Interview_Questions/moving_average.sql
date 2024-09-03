-- Q: moving_average, moving_total

-- Data preparation
create table if not exists products(
    id int auto_increment not null primary key,
    product_name varchar(50) not null,
    sell_date date not null,
    quantity int not null
);

INSERT INTO products (product_name, sell_date, quantity) VALUES
-- Product A
('Product A', '2024-01-01', 12),
('Product A', '2024-01-02', 8),
('Product A', '2024-01-03', 15),
('Product A', '2024-01-04', 5),
('Product A', '2024-01-06', 20),
('Product A', '2024-01-07', 18),
('Product A', '2024-01-09', 22),
('Product A', '2024-01-11', 17),
('Product A', '2024-01-13', 13),
('Product A', '2024-01-15', 25),
('Product A', '2024-01-17', 19),
('Product A', '2024-01-19', 30),
('Product A', '2024-01-21', 21),
('Product A', '2024-01-23', 10),
('Product A', '2024-01-25', 15),
('Product A', '2024-01-27', 20),
('Product A', '2024-01-29', 30),
('Product A', '2024-02-01', 40),
('Product A', '2024-02-05', 25),
('Product A', '2024-02-10', 35),

-- Product B
('Product B', '2024-01-02', 7),
('Product B', '2024-01-03', 9),
('Product B', '2024-01-05', 6),
('Product B', '2024-01-06', 13),
('Product B', '2024-01-08', 14),
('Product B', '2024-01-09', 20),
('Product B', '2024-01-11', 24),
('Product B', '2024-01-13', 17),
('Product B', '2024-01-15', 22),
('Product B', '2024-01-17', 11),
('Product B', '2024-01-19', 8),
('Product B', '2024-01-21', 12),
('Product B', '2024-01-24', 18),
('Product B', '2024-01-27', 25),
('Product B', '2024-01-29', 30),
('Product B', '2024-02-02', 22),
('Product B', '2024-02-06', 28),

-- Product C
('Product C', '2024-01-02', 4),
('Product C', '2024-01-03', 9),
('Product C', '2024-01-04', 8),
('Product C', '2024-01-06', 10),
('Product C', '2024-01-07', 7),
('Product C', '2024-01-09', 12),
('Product C', '2024-01-11', 14),
('Product C', '2024-01-13', 11),
('Product C', '2024-01-14', 9),
('Product C', '2024-01-16', 13),
('Product C', '2024-01-18', 5),
('Product C', '2024-01-20', 10),
('Product C', '2024-01-22', 15),
('Product C', '2024-01-24', 20),
('Product C', '2024-01-26', 25),
('Product C', '2024-01-28', 18),
('Product C', '2024-01-30', 22),
('Product C', '2024-02-03', 18),
('Product C', '2024-02-07', 22);


-- Query moving total and moving average quantity of each product
-- Assuming the sell_date are consecutive days
select
    product_name,
    sum(quantity) over (partition by product_name order by sell_date rows between 6 preceding and current row) as 7days_moving_total,
    avg(quantity) over (partition by product_name order by sell_date rows between 6 preceding and current row) as 7days_moving_total
from
    products;

-- Assuming the sell_date aren't consecutive days.
select
    p1.product_name,
    p1.sell_date,
    (
        select sum(p2.quantity)
        from products p2
        where p1.product_name = p2.product_name
        and p2.sell_date between date_sub(p1.sell_date, interval 6 day) and p1.sell_date
    ) as 7days_total_sum,
        (
        select avg(p2.quantity)
        from products p2
        where p1.product_name = p2.product_name
        and p2.sell_date between date_sub(p1.sell_date, interval 6 day) and p1.sell_date
    ) as 7days_total_sum
from
    products p1
group by p1.product_name, p1.sell_date
order by p1.product_name, p1.sell_date;

-- Total_sum_by_week
select
    product_name,
    year(sell_date) as year,
    week(sell_date) as week,
    sum(quantity)
from
    products
group by product_name, year(sell_date), week(sell_date)
order by product_name, year(sell_date), week(sell_date);

