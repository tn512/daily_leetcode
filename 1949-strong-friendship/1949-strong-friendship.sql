-- 1949. Strong Friendship

-- Main Solution
WITH temp AS (
    SELECT user1_id, user2_id
    FROM Friendship
    UNION
    SELECT user2_id, user1_id
    FROM Friendship
)
SELECT t1.user1_id, t1.user2_id, COUNT(t3.user2_id) AS common_friend
FROM Friendship t1
JOIN temp t2
ON t1.user1_id = t2.user1_id
JOIN temp t3
ON t1.user2_id = t3.user1_id
AND t2.user2_id = t3.user2_id
GROUP BY t1.user1_id, t1.user2_id
HAVING COUNT(t3.user2_id) > 2;

