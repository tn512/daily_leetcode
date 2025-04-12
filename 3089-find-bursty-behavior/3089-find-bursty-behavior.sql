-- 3089. Find Bursty Behavior

-- Main Solution
WITH temp AS (
    SELECT user_id, 
        COUNT(post_id) OVER (PARTITION BY user_id) / 4 AS avg_weekly_posts,
        COUNT(post_id) OVER (PARTITION BY user_id
                                ORDER BY post_date
                                RANGE BETWEEN INTERVAL '6' DAY PRECEDING AND CURRENT ROW) AS cnt_con
    FROM Posts
    WHERE post_date BETWEEN '2024-02-01' AND '2024-02-28'
)
SELECT user_id, MAX(cnt_con) AS max_7day_posts, avg_weekly_posts
FROM temp
GROUP BY user_id, avg_weekly_posts
HAVING avg_weekly_posts * 2 <= MAX(cnt_con)
ORDER BY user_id;

