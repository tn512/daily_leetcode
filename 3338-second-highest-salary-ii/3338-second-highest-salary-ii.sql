-- 3338. Second Highest Salary II

-- Main Solution
WITH rank_salary AS (
    SELECT emp_id, dept,
           DENSE_RANK() OVER (PARTITION BY dept 
                              ORDER BY salary DESC) AS rnk
    FROM employees
)
SELECT emp_id, dept
FROM rank_salary
WHERE rnk = 2
ORDER BY emp_id;

-- Alternative Solution
SELECT e1.emp_id, e1.dept
FROM employees e1
JOIN employees e2
ON e1.dept = e2.dept
AND e1.salary < e2.salary
GROUP BY e1.emp_id, e1.dept
HAVING COUNT(DISTINCT e2.salary) = 1
ORDER BY e1.emp_id;
