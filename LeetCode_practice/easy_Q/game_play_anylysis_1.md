Table: Activity
(player_id, event_date) is the primary key of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
Write an SQL query to report the first login date for each player.
Return the result table in any order.

/* Write your T-SQL query statement below */
# window function
with t as(
    SELECT
        player_id,
        event_date,
        rank() over(partition by player_id order by event_date) AS rank
    FROM
        activity
)

SELECT
    player_id,
    event_date AS first_login
FROM
    t
WHERE
    rank = 1
order by player_id;
