Table: Cinema

seat_id is an auto-increment primary key column for this table.
Each row of this table indicates whether the ith seat is free or not. 1 means free while 0 means occupied.

Write an SQL query to report all the consecutive available seats in the cinema.

Return the result table ordered by seat_id in ascending order.

The test cases are generated so that more than two seats are consecutively available.

# Write your MySQL query statement below
# cross join
SELECT
    distinct t1.seat_id
FROM
    cinema t1, cinema t2
WHERE
    abs(t1.seat_id - t2.seat_id) = 1
    and (t1.free = 1 and t2.free = 1)
order by t1.seat_id ASC;

