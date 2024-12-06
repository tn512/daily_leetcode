-- 1107. New Users Daily Count

-- Main Solution
SELECT TO_CHAR(login_date, 'YYYY-MM-DD') AS login_date, COUNT(user_id) AS user_count
FROM (
    SELECT user_id, MIN(activity_date) AS login_date
    FROM Traffic
    WHERE activity = 'login'
    GROUP BY user_id
    HAVING MIN(activity_date) >= TO_DATE('2019-06-30', 'YYYY-MM-DD') - 90)
GROUP BY login_date
ORDER BY login_date;

-- Alternative Solution
SELECT TO_CHAR(activity_date, 'YYYY-MM-DD') AS login_date, 
       COUNT(DISTINCT user_id) AS user_count 
FROM (
    SELECT user_id, activity_date, 
           RANK() OVER (PARTITION BY user_id ORDER BY activity_date ASC) AS rnk 
    FROM Traffic 
    WHERE activity = 'login') t0 
WHERE rnk = 1 
AND activity_date >= TO_DATE('2019-06-30', 'YYYY-MM-DD') - 90 
GROUP BY activity_date
ORDER BY login_date;
