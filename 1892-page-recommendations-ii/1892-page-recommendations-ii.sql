-- 1892. Page Recommendations II

-- Main Solution
WITH temp AS (
    SELECT CASE WHEN l.user_id = f.user1_id THEN f.user2_id 
                ELSE f.user1_id 
           END AS user_id,
           l.page_id
    FROM Likes l
    JOIN Friendship f
    ON l.user_id IN (f.user1_id, f.user2_id)
)
SELECT t.user_id, t.page_id, COUNT(*) AS friends_likes
FROM temp t
LEFT JOIN Likes l
ON l.user_id = t.user_id
AND l.page_id = t.page_id
WHERE l.user_id IS NULL
GROUP BY t.user_id, t.page_id;

