-- 1075. Project Employees I

-- Main Solution
WITH temp AS (
    SELECT p.*, e.experience_years
    FROM Project p
    JOIN Employee e
    ON p.employee_id = e.employee_id
)
SELECT project_id, ROUND(AVG(experience_years), 2) AS average_years
FROM temp
GROUP BY project_id;

