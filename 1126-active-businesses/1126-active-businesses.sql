-- 1126. Active Businesses

-- Main Solution
WITH avg_act AS (
    SELECT event_type, AVG(occurrences) as av
    FROM Events
    GROUP BY event_type
), temp AS (
    SELECT e.business_id
    FROM Events e
    JOIN avg_act a
    ON e.event_type = a.event_type
    WHERE e.occurrences > a.av
)
SELECT *
FROM temp
GROUP BY business_id
HAVING COUNT(1) > 1;

-- Alternative Solution
WITH avg_act AS (
    SELECT event_type, AVG(occurrences) as av
    FROM Events
    GROUP BY event_type
)
SELECT e.business_id
FROM Events e
JOIN avg_act a
ON e.event_type = a.event_type
GROUP BY e.business_id
HAVING SUM(CASE WHEN e.occurrences > a.av THEN 1 ELSE 0 END) > 1;
