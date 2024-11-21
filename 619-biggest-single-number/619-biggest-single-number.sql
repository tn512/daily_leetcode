-- 619. Biggest Single Number

-- Main Solution
WITH temp AS (
    SELECT * 
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(1) = 1
)
SELECT MAX(num) AS num
FROM temp;

