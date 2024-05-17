Table: Activit
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device
Write an SQL query to report the device that is first logged in for each player.

Return the result table in any order.

# Write your MySQL query statement below
# distinct
# first_value()
SELECT
    distinct player_id,
    first_value(device_id) over(partition by player_id order by event_date) AS device_id
FROM
    activity; 
