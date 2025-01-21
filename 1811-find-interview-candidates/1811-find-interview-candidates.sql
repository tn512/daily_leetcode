-- 1811. Find Interview Candidates

-- Main Solution
WITH contests_cleaned AS (
    SELECT *
    FROM Contests
    UNPIVOT(
        user_id
        FOR medal IN (
            gold_medal AS 'gold',
            silver_medal AS 'silver',
            bronze_medal AS 'bronze'
        )
    )
), consecutive_temp AS (
    SELECT user_id,
           contest_id,
           DENSE_RANK() OVER (ORDER BY contest_id) 
           - ROW_NUMBER() OVER (PARTITION BY user_id 
                                ORDER BY contest_id) AS gap
    FROM contests_cleaned
), temp AS (
    SELECT DISTINCT user_id
    FROM consecutive_temp
    GROUP BY user_id, gap
    HAVING COUNT(contest_id) > 2
    UNION ALL
    SELECT user_id
    FROM contests_cleaned
    WHERE medal = 'gold'
    GROUP BY user_id
    HAVING COUNT(contest_id) > 2
)
SELECT name, mail
FROM Users
WHERE user_id IN (SELECT * FROM temp);

