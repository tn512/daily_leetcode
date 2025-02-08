-- 2010. The Number of Seniors and Juniors to Join the Company II

-- Main Solution
WITH senior_temp AS (
    SELECT employee_id, experience, salary,
           70000 - SUM(salary) OVER (ORDER BY salary, employee_id) AS cum_salary,
           ROW_NUMBER() OVER (ORDER BY salary, employee_id) AS rn
    FROM Candidates
    WHERE experience = 'Senior'
), junior_temp AS (
    SELECT employee_id, experience, salary,
           (SELECT NVL(MIN(cum_salary), 70000) 
            FROM senior_temp 
            WHERE cum_salary > 0) 
           - SUM(salary) OVER (ORDER BY salary, employee_id) AS cum_salary,
           ROW_NUMBER() OVER (ORDER BY salary, employee_id) AS rn
    FROM Candidates
    WHERE experience = 'Junior'
)
SELECT employee_id
FROM senior_temp
WHERE cum_salary > 0
UNION
SELECT employee_id
FROM junior_temp
WHERE cum_salary > 0;

