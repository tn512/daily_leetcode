-- 569. Median Employee Salary

-- Main Solution
WITH company_counts AS (
    SELECT company, COUNT(*) AS cnt
    FROM Employee
    GROUP BY company
),
ranked AS (
    SELECT e.id, e.company, e.salary,
           ROW_NUMBER() OVER (PARTITION BY e.company ORDER BY e.salary, e.id) AS row_num,
           c.cnt
    FROM Employee e
    JOIN company_counts c ON e.company = c.company
)
SELECT id, company, salary
FROM ranked
WHERE row_num IN (
    cnt / 2,
    (cnt + 1) / 2,
    (cnt + 2) / 2
);

-- Alternative Solution
SELECT MIN(e1.id) AS id, e1.company, e1.salary
FROM Employee e1, Employee e2
WHERE e1.company = e2.company
GROUP BY e1.company, e1.salary
HAVING SUM(CASE WHEN e2.salary >= e1.salary THEN 1 ELSE 0 END) >= COUNT(*)/2
AND SUM(CASE WHEN e2.salary <= e1.salary THEN 1 ELSE 0 END) >= COUNT(*)/2
ORDER BY e1.company, e1.salary
