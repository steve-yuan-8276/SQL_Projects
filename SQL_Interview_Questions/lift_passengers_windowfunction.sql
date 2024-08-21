-- Question：Fit each lift with appropriate passengers"

-- The relationship between the LIFT and LIFT_PASSENGERS table is such that multiple passengers can attempt to enter the same lift, 
-- but the total weight of the passengers in a lift cannot exceed the lifts' capacity.

-- Your task is to write a SQL query that produces a comma-separated list of passengers who can be accommodated in each lift without 
-- exceeding the lift's capacity. The passengers in the list should be ordered by their weight in increasing order.

-- You can assume that the weights of the passengers are unique within each lift.

-- Data Preparation

-- Create Table:LIFT 
CREATE TABLE LIFT (
    ID INT PRIMARY KEY,
    CAPACITY_KG INT NOT NULL
);

-- Insert data into lift table
INSERT INTO LIFT (ID, CAPACITY_KG) VALUES
(1, 300),
(2, 350);

-- Create table: LIFT_PASSENGERS 
CREATE TABLE LIFT_PASSENGERS (
    PASSENGER_NAME VARCHAR(50) NOT NULL,
    WEIGHT_KG INT NOT NULL,
    LIFT_ID INT,
    FOREIGN KEY (LIFT_ID) REFERENCES LIFT(ID)
);

-- Insert data into table:LIFT_PASSENGERS 
INSERT INTO LIFT_PASSENGERS (PASSENGER_NAME, WEIGHT_KG, LIFT_ID) VALUES
('Rahul', 85, 1),
('Adarsh', 73, 1),
('Riti', 95, 1),
('Dheeraj', 80, 1),
('Vimal', 83, 2),
('Neha', 77, 2),
('Priti', 73, 2),
('Himanshi', 85, 2);


-- Solution: window function
WITH
	T1 AS (
		SELECT
			*,
			SUM(WEIGHT_KG) OVER (
				PARTITION BY
					LP.LIFT_ID
				ORDER BY
					LP.LIFT_ID,
					LP.WEIGHT_KG
			) AS TOTAL_WEIGHT
		FROM
			LIFT_PASSENGERS LP
			LEFT JOIN LIFT L ON LP.LIFT_ID = L.ID
	),
	T2 AS (
		SELECT
			*,
			CASE
				WHEN TOTAL_WEIGHT <= CAPACITY_KG THEN 1
				ELSE 0
			END AS WEIGHT_FLAG
		FROM
			T1
	)
SELECT
	LIFT_ID,
	STRING_AGG(PASSENGER_NAME, ',') AS PASSENGERS
FROM
	T2
WHERE
	WEIGHT_FLAG = 1
GROUP BY
	LIFT_ID
ORDER BY
	LIFT_ID;
