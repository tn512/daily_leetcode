-- 1132. Reported Posts II

-- Main Solution
SELECT ROUND(100 * AVG(daily_percent), 2) AS average_daily_percent
FROM (
        SELECT a.action_date,
               COUNT(DISTINCT r.post_id) / COUNT(DISTINCT a.post_id) AS daily_percent
        FROM Actions a
        LEFT JOIN Removals r
        ON a.post_id = r.post_id
        WHERE a.action = 'report'
        and a.extra = 'spam'
        GROUP BY a.action_date
);

