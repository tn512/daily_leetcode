-- 1699. Number of Calls Between Two Persons

-- Main Solution
WITH temp AS (
    SELECT CASE WHEN from_id < to_id THEN from_id ELSE to_id END AS person1,
           CASE WHEN from_id < to_id THEN to_id ELSE from_id END AS person2,
           duration
    FROM Calls
)
SELECT person1, person2, COUNT(duration) AS call_count, SUM(duration) AS total_duration
FROM temp
GROUP BY person1, person2;

-- Alternative Solution
SELECT LEAST(from_id, to_id) AS person1,
       GREATEST(from_id, to_id) AS person2,
       COUNT(duration) AS call_count, 
       SUM(duration) AS total_duration
FROM Calls
GROUP BY LEAST(from_id, to_id), GREATEST(from_id, to_id);
