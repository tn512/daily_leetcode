-- 1264. Page Recommendations

-- Main Solution
WITH friend AS (
    SELECT user2_id AS friend_id
    FROM Friendship
    WHERE user1_id = 1
    UNION
    SELECT user1_id
    FROM Friendship
    WHERE user2_id = 1
)
SELECT DISTINCT l.page_id AS recommended_page
FROM Friend f
JOIN Likes l
ON f.friend_id = l.user_id
WHERE l.page_id NOT IN (SELECT page_id FROM Likes WHERE user_id = 1);

-- Alternative Solution
WITH friend AS (
    SELECT CASE WHEN user1_id = 1 THEN user2_id
                WHEN user2_id = 1 THEN user1_id 
           END AS friend_id
    FROM Friendship
)
SELECT DISTINCT l.page_id AS recommended_page
FROM Friend f
JOIN Likes l
ON f.friend_id = l.user_id
WHERE l.page_id NOT IN (SELECT page_id FROM Likes WHERE user_id = 1);
