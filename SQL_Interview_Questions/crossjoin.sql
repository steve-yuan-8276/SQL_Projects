-- Based on given products and transactions table, Find product wise total amount, including products with no sales.

-- create products table and insert data
CREATE TABLE PRODUCTS (
    PID INT,
    PNAME VARCHAR(50),
    PRICE INT
);

INSERT INTO PRODUCTS (PID, PNAME, PRICE) VALUES
    (1, 'A', 1000),
    (2, 'B', 400),
    (3, 'C', 500);

-- create transactions table and insert data
CREATE TABLE TRANSACTIONS (
    PID INT,
    SOLD_DATE DATE,
    QTY INT,
    AMOUNT INT
);

INSERT INTO TRANSACTIONS (PID, SOLD_DATE, QTY, AMOUNT) VALUES
    (1, '2024-02-01', 2, 2000),
    (1, '2024-03-01', 4, 4000),
    (1, '2024-03-15', 2, 2000),
    (3, '2024-04-24', 3, 1500),
    (3, '2024-05-16', 5, 2500);


-- Solutions：
WITH
    PT AS (
        SELECT
            P.PID,
            P.PNAME,
            EXTRACT(YEAR FROM T.SOLD_DATE) AS YEAR,
            EXTRACT(MONTH FROM T.SOLD_DATE) AS MONTH,
            SUM(AMOUNT) AS TOTAL_SALES
        FROM
            PRODUCTS P
            LEFT JOIN TRANSACTIONS T ON P.PID = T.PID
        GROUP BY
            P.PID,
            P.PNAME,
            EXTRACT(YEAR FROM T.SOLD_DATE),
            EXTRACT(MONTH FROM T.SOLD_DATE)
    ),
    ALLMONTHS AS (
        SELECT
            YEAR,
            MONTH,
            P.PID,
            P.PNAME
        FROM
            (VALUES (2024)) AS YEARS (YEAR)
            CROSS JOIN (VALUES
                (1),
                (2),
                (3),
                (4),
                (5),
                (6),
                (7),
                (8),
                (9),
                (10),
                (11),
                (12)
            ) AS MONTHS (MONTH)
            CROSS JOIN PRODUCTS P
    )
SELECT
    AM.PID,
    AM.PNAME,
    AM.YEAR,
    AM.MONTH,
    COALESCE(PT.TOTAL_SALES, 0) AS TOTAL_SALES
FROM
    ALLMONTHS AM
    LEFT JOIN PT ON AM.YEAR = PT.YEAR AND AM.MONTH = PT.MONTH AND AM.PID = PT.PID
ORDER BY
    AM.PID,
    AM.YEAR,
    AM.MONTH;


