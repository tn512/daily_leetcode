-- 1917. Leetcodify Friends Recommendations

-- Main Solution
SELECT DISTINCT l1.user_id, l2.user_id AS recommended_id
FROM Listens l1
JOIN Listens l2
ON l1.song_id = l2.song_id
AND l1.day = l2.day
AND l1.user_id <> l2.user_id
LEFT JOIN Friendship f
ON f.user1_id = LEAST(l1.user_id, l2.user_id)
AND f.user2_id = GREATEST(l1.user_id, l2.user_id)
WHERE f.user1_id IS NULL
GROUP BY l1.user_id, l2.user_id, l1.day
HAVING COUNT(DISTINCT l1.song_id) > 2
ORDER BY l1.user_id;

