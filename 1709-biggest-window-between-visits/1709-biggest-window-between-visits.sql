-- 1709. Biggest Window Between Visits

-- Main Solution
WITH temp AS (
    SELECT user_id,
           NVL(LEAD(visit_date) OVER (PARTITION BY user_id 
                                      ORDER BY visit_date), TO_DATE('2021-1-1')) 
           - visit_date AS window
    FROM UserVisits
)
SELECT user_id, MAX(window) AS biggest_window
FROM temp
GROUP BY user_id
ORDER BY user_id;

-- Alternative Solution
WITH temp AS (
    SELECT user_id,
           LEAD(visit_date, 1, '2021-1-1') OVER (PARTITION BY user_id ORDER BY visit_date)
           - visit_date AS window
    FROM UserVisits
)
SELECT user_id, MAX(window) AS biggest_window
FROM temp
GROUP BY user_id
ORDER BY user_id;
