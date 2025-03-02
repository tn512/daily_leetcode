-- 2720. Popularity Percentage

-- Main Solution
WITH friendship AS (
    SELECT user1 AS user1, user2 AS friend
    FROM Friends
    UNION
    SELECT user2, user1 
    FROM Friends
)
SELECT DISTINCT user1, 
       ROUND(100 * COUNT(*) OVER (PARTITION BY user1)
       / COUNT(DISTINCT user1) OVER (), 2) AS percentage_popularity
FROM friendship
ORDER BY user1;

-- Alternative Solution
WITH friendship AS (
    SELECT user1 AS user1, user2 AS friend
    FROM Friends
    UNION
    SELECT user2, user1 
    FROM Friends
)
SELECT user1, 
       ROUND(100 * COUNT(friend) / COUNT(user1) OVER (), 2) AS percentage_popularity
FROM friendship
GROUP BY user1
ORDER BY user1;
