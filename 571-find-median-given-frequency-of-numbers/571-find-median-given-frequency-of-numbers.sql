-- 571. Find Median Given Frequency of Numbers

-- Main Solution
WITH temp AS (
    SELECT LEVEL AS rn FROM dual CONNECT BY LEVEL <= (SELECT MAX(frequency) FROM Numbers)
), decom AS (
    SELECT n.num
    FROM Numbers n
    JOIN temp t
    ON t.rn <= n.frequency
), rnum AS (
    SELECT num, ROW_NUMBER() OVER (ORDER BY num) AS row_num,
           (SELECT SUM(frequency) FROM Numbers) AS cnt
    FROM decom
)
SELECT AVG(num) AS median
FROM rnum
WHERE row_num IN (cnt/2, (cnt + 1)/2, (cnt + 2)/2);

-- Alternative Solution
SELECT AVG(n.num) AS median
FROM Numbers n
WHERE n.frequency >= ABS((SELECT SUM(l.frequency) FROM Numbers l WHERE l.num <= n.num)
                        -(SELECT SUM(r.frequency) FROM Numbers r WHERE r.num >= n.num));
