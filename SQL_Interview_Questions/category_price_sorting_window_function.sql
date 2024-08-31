-- Q: There is a table called category_table that includes category, subcategory, and price.
-- For each category (which contains two or more subcategories), find the top two subcategories based on price.
-- For categories with only one subcategory, include it in the output if its price is greater than 50.

-- Data preparation
-- create table
create table if not exists category_table (
    category varchar(50) not null,
    sub_category varchar(50) not null,
    price decimal(10, 2) not null
);

-- insert data
INSERT INTO category_table (category, sub_category, price) VALUES
('Electronics', 'Smartphones', 299.99),
('Electronics', 'Laptops', 899.99),
('Electronics', 'Tablets', 399.99),
('Electronics', 'Headphones', 99.99),
('Furniture', 'Sofas', 499.99),
('Furniture', 'Chairs', 149.99),
('Furniture', 'Tables', 199.99),
('Clothing', 'Men', 79.99),
('Clothing', 'Women', 89.99),
('Clothing', 'Kids', 39.99),
-- Category with only one subcategory, price greater than 50
('Toys', 'Action Figures', 59.99),
-- Category with only one subcategory, price less than 50
('Stationery', 'Pens', 19.99);

-- solution
with t as (
    select
        *,
        dense_rank() over (partition by category order by price desc) as price_rn,
        count(*) over (partition by category) as cnt
    from
        category_table
)
select
    category,
    sub_category,
    price
from
    t
where
    (price_rn  <= 2 and cnt > 1)
    or (cnt = 1 and price > 50);