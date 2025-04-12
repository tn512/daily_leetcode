-- 3058. Friends With No Mutual Friends

-- Main Solution
WITH friendship AS (
    SELECT user_id1 AS user_id, user_id2 AS friend_id
    FROM Friends
    UNION
    SELECT user_id2 AS user_id, user_id1 AS friend_id
    FROM Friends
), mutual_friends AS (
    SELECT f.*
    FROM Friends f
    LEFT JOIN friendship f1
    ON f.user_id1 = f1.user_id
    AND f.user_id2 <> f1.friend_id
    LEFT JOIN friendship f2
    ON f.user_id2 = f2.user_id
    AND f.user_id1 <> f2.friend_id
    WHERE f1.friend_id = f2.friend_id
)
SELECT *
FROM Friends 
MINUS
SELECT *
FROM mutual_friends;

-- Alternative Solution
WITH friendship AS (
    SELECT user_id1 AS user_id, user_id2 AS friend_id
    FROM Friends
    UNION
    SELECT user_id2 AS user_id, user_id1 AS friend_id
    FROM Friends
)
SELECT f.user_id1, f.user_id2
FROM Friends f
JOIN friendship f1 
ON f.user_id1 = f1.user_id
LEFT JOIN friendship f2 
ON f.user_id2 = f2.user_id
AND f1.friend_id = f2.friend_id
GROUP BY f.user_id1, f.user_id2
HAVING COUNT(f2.friend_id) = 0
ORDER BY f.user_id1, f.user_id2;
