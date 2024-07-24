--Find the products whose sales are increasing every year. 
CREATE TABLE PRODUCTS (
	PRODUCT_ID INT PRIMARY KEY,
	PRODUCT_NAME VARCHAR(50),
	CATEGORY VARCHAR(50)
);

INSERT INTO
	PRODUCTS (PRODUCT_ID, PRODUCT_NAME, CATEGORY)
VALUES
	(1, 'Laptops', 'Electronics'),
	(2, 'Jeans', 'Clothing'),
	(3, 'Chairs', 'Home Appliances');

CREATE TABLE SALES (
	PRODUCT_ID INT,
	YEAR INT,
	TOTAL_SALES_REVENUE DECIMAL(10, 2),
	PRIMARY KEY (PRODUCT_ID, YEAR),
	FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCTS (PRODUCT_ID)
);

INSERT INTO
	SALES (PRODUCT_ID, YEAR, TOTAL_SALES_REVENUE)
VALUES
	(1, 2019, 1000.00),
	(1, 2020, 1200.00),
	(1, 2021, 1100.00),
	(2, 2019, 500.00),
	(2, 2020, 600.00),
	(2, 2021, 900.00),
	(3, 2019, 300.00),
	(3, 2020, 450.00),
	(3, 2021, 400.00);


-- Check
select * from products;
select * from sales;


-- Solution1:
WITH CTE1 AS (
    SELECT
        P.PRODUCT_ID,
        P.PRODUCT_NAME,
        P.CATEGORY,
        S.YEAR,
        S.TOTAL_SALES_REVENUE
    FROM
        PRODUCTS P
        LEFT JOIN SALES S ON P.PRODUCT_ID = S.PRODUCT_ID
),
CTE2 AS (
    SELECT
        PRODUCT_ID,
        PRODUCT_NAME,
        CATEGORY,
        YEAR,
        TOTAL_SALES_REVENUE,
        LAG(TOTAL_SALES_REVENUE) OVER (
            PARTITION BY PRODUCT_ID
            ORDER BY YEAR
        ) AS PREV_YEAR_SALES
    FROM
        CTE1
),
CTE3 AS (
    SELECT
        PRODUCT_ID,
        PRODUCT_NAME,
        CATEGORY,
        COUNT(*) AS TOTAL_YEARS,
        SUM(CASE
            WHEN TOTAL_SALES_REVENUE > PREV_YEAR_SALES THEN 1
            ELSE 0
        END) AS INCREASING_YEARS
    FROM
        CTE2
    WHERE PREV_YEAR_SALES IS NOT NULL
    GROUP BY
        PRODUCT_ID,
        PRODUCT_NAME,
        CATEGORY
)
SELECT
    PRODUCT_ID,
    PRODUCT_NAME,
    CATEGORY
FROM
    CTE3
WHERE
    TOTAL_YEARS = INCREASING_YEARS;


-- Solution2:
WITH cte AS (
    SELECT 
        product_id, 
        total_sales_revenue,
        LEAD(total_sales_revenue) OVER (PARTITION BY product_id ORDER BY year) AS nxt_rev
    FROM sales
),
cte2 AS (
    SELECT 
        p.product_id,
        MAX(p.product_name) AS product_name,
        MAX(p.category) AS product_category
    FROM 
        cte c
    JOIN 
        products p ON c.product_id = p.product_id
    WHERE 
        c.product_id NOT IN (
            SELECT 
                product_id 
            FROM 
                cte 
            WHERE 
                total_sales_revenue > nxt_rev
        )
    GROUP BY 
        p.product_id
)
SELECT 
    product_id, 
    product_name, 
    product_category 
FROM 
    cte2;