-- 262. Trips and Users

-- Main Solution
WITH trips_clean AS (
    SELECT t.*
    FROM Trips t, Users c, Users d
    WHERE t.client_id = c.users_id
    AND t.driver_id = d.users_id
    AND d.banned = 'No'
    AND c.banned = 'No'
    AND request_at BETWEEN '2013-10-01' AND '2013-10-03'
),
counts AS (
    SELECT request_at, 
           COUNT(id) AS all_count,
           SUM(CASE WHEN status LIKE 'cancelled%' THEN 1 ELSE 0 END) AS can_count
    FROM trips_clean
    GROUP BY request_at
)
SELECT a.request_at AS Day,
       ROUND(a.can_count / a.all_count, 2) AS "Cancellation Rate"
FROM counts a;

