-- 3057. Employees Project Allocation

-- Main Solution
WITH avg_team_workload AS (
    SELECT p.project_id, p.employee_id, p.workload, e.name,
           AVG(p.workload) OVER (PARTITION BY e.team) AS avg_workload
    FROM Project p
    JOIN Employees e
    ON p.employee_id = e.employee_id
)
SELECT employee_id, project_id, 
       name AS employee_name, 
       workload AS project_workload
FROM avg_team_workload
WHERE workload > avg_workload
ORDER BY employee_id, project_id;

