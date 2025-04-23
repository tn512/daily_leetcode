-- 3236. CEO Subordinate Hierarchy

-- Main Solution
WITH hier_lvl AS (
    SELECT employee_id, employee_name, LEVEL - 1 AS hierarchy_level, salary
    FROM Employees
    START WITH manager_id IS NULL
    CONNECT BY PRIOR employee_id = manager_id
)
SELECT employee_id AS subordinate_id,
       employee_name AS subordinate_name,
       hierarchy_level,
       salary - (SELECT salary FROM Employees WHERE manager_id IS NULL) AS salary_difference
FROM hier_lvl h
WHERE hierarchy_level > 0
ORDER BY hierarchy_level, subordinate_id;

-- Alternative Solution
WITH hier_lvl (subordinate_id, subordinate_name, hierarchy_level, salary_difference) AS (
    SELECT employee_id AS subordinate_id, 
           employee_name AS subordinate_name, 
           0 AS hierarchy_level,
           salary AS salary_difference
    FROM Employees
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.employee_id AS subordinate_id, 
           e.employee_name AS subordinate_name, 
           h.hierarchy_level + 1 AS hierarchy_level,
           e.salary - (SELECT salary FROM Employees WHERE manager_id IS NULL) AS salary_difference
    FROM Employees e
    JOIN hier_lvl h
    ON e.manager_id = h.subordinate_id
)
SELECT *
FROM hier_lvl
WHERE hierarchy_level > 0
ORDER BY hierarchy_level, subordinate_id;
