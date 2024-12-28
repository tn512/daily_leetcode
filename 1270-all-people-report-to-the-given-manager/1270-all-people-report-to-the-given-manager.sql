-- 1270. All People Report to the Given Manager

-- Main Solution
SELECT  *
FROM (
    SELECT CASE WHEN e1.manager_id = 1 THEN e1.employee_id
                WHEN e2.manager_id = 1 THEN e1.employee_id
                WHEN e3.manager_id = 1 THEN e1.employee_id
        END AS employee_id
    FROM Employees e1
    LEFT JOIN Employees e2
    ON e1.manager_id = e2.employee_id
    LEFT JOIN Employees e3
    ON e2.manager_id = e3.employee_id
    WHERE e1.employee_id <> 1
    ORDER BY e1.employee_id
)
WHERE employee_id IS NOT NULL;

SELECT e1.employee_id
FROM Employees e1
LEFT JOIN Employees e2
ON e1.manager_id = e2.employee_id
LEFT JOIN Employees e3
ON e2.manager_id = e3.employee_id
WHERE e1.employee_id <> 1 AND e3.manager_id = 1;

-- Alternative Solution
SELECT employee_id
FROM Employees
START WITH manager_id = 1 AND employee_id <> 1
CONNECT BY PRIOR employee_id = manager_id
AND LEVEL <= 3;
