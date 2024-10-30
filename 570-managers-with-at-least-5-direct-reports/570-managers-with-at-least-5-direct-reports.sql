-- 570. Managers with at Least 5 Direct Reports

-- Main Solution
SELECT name
FROM Employee
WHERE id IN (SELECT managerId
FROM Employee
GROUP BY managerId
HAVING COUNT(id) > 4);

