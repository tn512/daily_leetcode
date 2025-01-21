-- 1501. Countries You Can Safely Invest In

-- Main Solution
WITH person_country AS (
    SELECT p.id, c.name
    FROM Person p
    JOIN Country c
    ON SUBSTR(p.phone_number, 0, 3) = c.country_code
), global_avg AS (
    SELECT AVG(duration) gavg
    FROM Calls
), temp AS (
    SELECT p.name, c.duration
    FROM Calls c
    JOIN person_country p
    ON c.caller_id = p.id
    UNION ALL
    SELECT p.name, c.duration
    FROM Calls c
    JOIN person_country p
    ON c.callee_id = p.id
)
SELECT name AS country
FROM temp
GROUP BY name
HAVING AVG(duration) > (SELECT gavg FROM global_avg);

-- Alternative Solution
SELECT c.name AS country
FROM Person p
JOIN Country c
ON SUBSTR(p.phone_number, 0, 3) = c.country_code
JOIN Calls ca
ON p.id IN (ca.caller_id, ca.callee_id)
GROUP BY c.name
HAVING AVG(ca.duration) > (SELECT AVG(duration) FROM Calls);
