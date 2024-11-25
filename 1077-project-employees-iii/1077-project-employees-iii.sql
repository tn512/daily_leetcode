-- 1077. Project Employees III

-- Main Solution
WITH temp AS (
    SELECT p.*, e.experience_years
    FROM Project p
    JOIN Employee e
    ON p.employee_id = e.employee_id
)
SELECT project_id, employee_id
FROM temp
WHERE (project_id, experience_years) IN (SELECT project_id, MAX(experience_years)
                          FROM temp
                          GROUP BY project_id);

-- Alternative Solution
SELECT project_id, employee_id
FROM (
    SELECT p.project_id, e.employee_id,
           RANK() OVER (PARTITION BY p.project_id ORDER BY e.experience_years DESC) AS rnk
    FROM Project p
    JOIN Employee e
    ON p.employee_id = e.employee_id)
WHERE rnk = 1;
