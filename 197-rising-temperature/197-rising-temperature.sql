-- 197. Rising Temperature

-- Main Solution
SELECT w1.id
FROM Weather w1, Weather w2
WHERE w1.recordDate = w2.recordDate + 1
AND w1.temperature > w2.temperature;

-- Alternative Solution
WITH temp AS (
    SELECT id, recordDate, temperature,
           LAG(recordDate) OVER (ORDER BY recordDate) AS preDate,
           LAG(temperature) OVER (ORDER BY recordDate) AS pretemperature
    FROM Weather
)
SELECT id
FROM temp
WHERE temperature > pretemperature
AND recordDate = preDate + 1;
