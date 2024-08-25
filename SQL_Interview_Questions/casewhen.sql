-- Return players and their total runs scored, those who did at least two half-centuries and did not out for a duck.
-- explanation：
-- half-centuries: score between 50 and 99 runs in a single innings.
-- Did not get out for a duck: The player has never been dismissed for zero runs (a "duck") in any innings.

-- Data Preparation

-- Create table
CREATE TABLE MATCHES (MATCH_ID INT, PLAYER_ID INT, RUNS_SCORED INT);

-- insert data
INSERT INTO
	MATCHES
VALUES
	(1, 208, 28),
	(2, 105, 0),
	(3, 201, 75),
	(4, 310, 48),
	(5, 402, 52),
	(6, 208, 58),
	(7, 105, 78),
	(8, 402, 25),
	(9, 310, 0),
	(10, 201, 90),
	(11, 208, 84),
	(12, 105, 102);

-- Create table
CREATE TABLE PLAYERS (ID INT PRIMARY KEY, NAME VARCHAR(20));
-- insert data
INSERT INTO
	PLAYERS
VALUES
	(208, 'Dekock'),
	(105, 'Virat'),
	(201, 'Miller'),
	(310, 'Warner'),
	(402, 'Buttler');


-- Solutions:
with t1 as (
	select
		m.match_id, 
		m.PLAYER_ID, 
		m.RUNS_SCORED,
		p.name,
		case
			when runs_scored between 50 and 99 then 1
			else 0 end as runs_flag,
		case
			when runs_scored = 0 then 1
			else 0 end as duck_flag
	from
		matches m left join players p 
		on m.player_id = p.id
), t2 as (
	select
		name,
		sum(runs_scored) as runs,
		sum(runs_flag) as sum_runsflag,
		sum(duck_flag) as sum_duckflag
	from 
		t1	
	group by name
)

select
	name,
	runs
from
	t2
where
	sum_runsflag >= 2
	and sum_duckflag = 0
