-- 2988. Manager of the Largest Department

-- Main Solution
WITH rnk_dep AS (
    SELECT dep_id, RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
    FROM Employees
    GROUP BY dep_id
)
SELECT e.emp_name AS manager_name, r.dep_id
FROM rnk_dep r
JOIN Employees e
ON e.dep_id = r.dep_id
AND r.rnk = 1
AND e.position = 'Manager'
ORDER BY r.dep_id;

