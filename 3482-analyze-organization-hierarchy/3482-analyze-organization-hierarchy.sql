-- 3482. Analyze Organization Hierarchy

-- Main Solution
WITH org_hierarchy (orig_employee_id, orig_employee_name, 
                    employee_id, employee_name,
                    manager_id, salary, org_level) AS (
    -- Base case: Starting from all employees and setting the initial level
    SELECT employee_id AS orig_employee_id,
           employee_name AS orig_employee_name,
           employee_id, employee_name, manager_id, salary,
           1 AS org_level
    FROM Employees

    UNION ALL

    -- Recursive step: Traverse through each manager's subordinates
    SELECT P.orig_employee_id, P.orig_employee_name,
           CH.employee_id, CH.employee_name, CH.manager_id, CH.salary,
           P.org_level + 1
    FROM org_hierarchy P
    JOIN Employees CH 
    ON CH.manager_id = P.employee_id
), CEO_hierarchy AS (
    -- Identify the CEO hierarchy (starting point of the organization)
    SELECT org_hierarchy.employee_id AS sub_employee_id,
           org_hierarchy.employee_name,
           org_hierarchy.org_level AS sub_level
    FROM org_hierarchy
    INNER JOIN Employees ON org_hierarchy.orig_employee_id = Employees.employee_id
    WHERE Employees.manager_id IS NULL
)
-- Final query: Aggregate results for each top-level employee
SELECT org_hierarchy.orig_employee_id AS employee_id,
       org_hierarchy.orig_employee_name AS employee_name,
       CEO_hierarchy.sub_level AS "level",
       COUNT(*) - 1 AS team_size,
       SUM(org_hierarchy.salary) AS budget
FROM org_hierarchy
JOIN CEO_hierarchy 
ON org_hierarchy.orig_employee_id = CEO_hierarchy.sub_employee_id
GROUP BY org_hierarchy.orig_employee_id,
         org_hierarchy.orig_employee_name,
         CEO_hierarchy.sub_level
ORDER BY "level" ASC, budget DESC, employee_name;

