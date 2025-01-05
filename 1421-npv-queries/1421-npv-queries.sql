-- 1421. NPV Queries

-- Main Solution
SELECT q.id, q.year, NVL(n.npv, 0) AS npv
FROM Queries q
LEFT JOIN NPV n
ON q.id = n.id
AND q.year = n.year;

