-- Question：Which customer has visited the same store location twice for consecutive 
-- 2 days and next date shopping amount is higher than previous day
-- Expected Outputs: cusotmer_id, the second day's amount

-- Data Preparation
-- Create table
CREATE TABLE SHOPPING (
	STORE_ID VARCHAR(20),
	LOCATION VARCHAR(20),
	CUSTOMER_ID INT,
	DATE DATE,
	AMOUNT INT
);

-- Insert data
INSERT INTO
	SHOPPING
VALUES
	('S1', 'Hyderabad', 100, '2024-06-10', 56000),
	('S1', 'Bangalore', 101, '2024-06-11', 15800),
	('S1', 'Chennai', 102, '2024-06-13', 12000),
	('S1', 'Hyderabad', 102, '2024-06-14', 18000),
	('S2', 'Hyderabad', 101, '2024-06-11', 80000),
	('S2', 'Bangalore', 101, '2024-06-12', 25000),
	('S2', 'Bangalore', 100, '2024-06-15', 10000),
	('S3', 'Chennai', 102, '2024-06-12', 9000),
	('S3', 'Hyderabad', 100, '2024-06-09', 66000);

-- Solution：
WITH
	CTE AS (
		SELECT
			*,
			LAG(DATE) OVER (PARTITION BY CUSTOMER_ID,LOCATION ORDER BY DATE) AS PRE_DATE,
			LAG(AMOUNT) OVER (PARTITION BY CUSTOMER_ID,LOCATION ORDER BY DATE) AS PRE_AMOUNT
		FROM
			SHOPPING
	)
SELECT
	CUSTOMER_ID,
	AMOUNT
FROM
	CTE
WHERE
	PRE_AMOUNT IS NOT NULL
	AND AMOUNT > PRE_AMOUNT
	AND DATE - PRE_DATE = 1;
	