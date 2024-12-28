-- 1369. Get the Second Most Recent Activity

-- Main Solution
WITH rn_activity AS (
    SELECT username, activity, startDate, endDate,
           ROW_NUMBER() OVER (PARTITION BY username ORDER BY startDate DESC) AS rn
    FROM UserActivity
)
SELECT r1.username, r1.activity,
       TO_CHAR(r1.startDate, 'YYYY-MM-DD') AS startDate,
       TO_CHAR(r1.endDate, 'YYYY-MM-DD') AS endDate
FROM rn_activity r1
LEFT JOIN rn_activity r2
ON r1.username = r2.username
AND r2.rn = 2
WHERE r2.username IS NULL OR r1.rn = 2;

-- Alternative Solution
WITH rn_activity AS (
    SELECT username, activity, startDate, endDate,
           ROW_NUMBER() OVER (PARTITION BY username ORDER BY startDate DESC) AS rn,
           COUNT(startDate) OVER (PARTITION BY username) AS cnt
    FROM UserActivity
)
SELECT username, activity,
       TO_CHAR(startDate, 'YYYY-MM-DD') AS startDate,
       TO_CHAR(endDate, 'YYYY-MM-DD') AS endDate
FROM rn_activity
WHERE rn = 2 OR cnt = 1;
