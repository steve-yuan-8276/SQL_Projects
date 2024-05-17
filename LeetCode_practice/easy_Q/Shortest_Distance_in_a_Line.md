Table: Point

+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
+-------------+------+
x is the primary key column for this table.
Each row of this table indicates the position of a point on the X-axis.

Write an SQL query to report the shortest distance between any two points from the Point table.

# Write your MySQL query statement below
# self join
# sub query
with t as(
    SELECT
        abs(t2.x - t1.x) AS distance
    FROM
        point t1, point t2
    WHERE
        t1.x != t2.x
)

SELECT
    min(distance) AS shortest
FROM
    t

