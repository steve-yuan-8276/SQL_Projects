Table: Orders

order_number is the primary key for this table.
This table contains information about the order ID and the customer ID.

Write an SQL query to find the customer_number for the customer who has placed the largest number of orders.

The test cases are generated so that exactly one customer will have placed more orders than any other customer.

# Write your MySQL query statement below
# group by

SELECT
    customer_number
FROM
    orders
group by customer_number
order by count(*) DESC
limit 1

