SELECT * FROM emp_attendance LIMIT 1000;

WITH attendance_ranked AS (
    SELECT 
        employee,
        dates,
        status,
        ROW_NUMBER() OVER (PARTITION BY employee, status ORDER BY dates) AS rn1,
        ROW_NUMBER() OVER (PARTITION BY employee ORDER BY dates) AS rn2
    FROM emp_attendance
),
attendance_grouped AS (
    SELECT 
        employee,
        MIN(dates) AS from_date,
        MAX(dates) AS to_date,
        status
    FROM attendance_ranked
    GROUP BY employee, status, rn2 - rn1
)
SELECT
    employee,
    from_date,
    to_date,
    status
FROM attendance_grouped
ORDER BY employee, from_date;
