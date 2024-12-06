-- 1127. User Purchase Platform

-- Main Solution
WITH temp AS (
    SELECT spend_date, user_id, COUNT(*) cnt
    FROM Spending
    GROUP BY spend_date, user_id
), idk AS (
    SELECT s.*,
       CASE WHEN t.cnt = 2 THEN 'both'
            ELSE s.platform
       END AS cat
    FROM Spending s
    JOIN temp t
    ON s.user_id =  t.user_id
    AND s.spend_date = t.spend_date
), abc AS (
    SELECT spend_date, cat, SUM(amount) AS total_amount, COUNT(DISTINCT user_id) AS total_users
    FROM idk
    GROUP BY spend_date, cat
), base AS (
    SELECT d.spend_date, p.platform
    FROM (
        SELECT DISTINCT spend_date
        FROM Spending
    ) d
    CROSS JOIN (
        SELECT 'mobile' AS platform FROM DUAL
        UNION ALL
        SELECT 'desktop' FROM DUAL
        UNION ALL
        SELECT 'both' FROM DUAL
    ) p
)
SELECT TO_CHAR(b.spend_date, 'YYYY-MM-DD') AS spend_date, 
       b.platform, 
       COALESCE(a.total_amount, 0) AS total_amount, 
       COALESCE(a.total_users, 0) AS total_users
FROM base b
LEFT JOIN abc a
ON a.spend_date = b.spend_date
AND a.cat = b.platform;

