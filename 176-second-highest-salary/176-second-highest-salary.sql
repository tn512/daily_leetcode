-- 176. Second Highest Salary

-- Main Solution
WITH rank AS (
    SELECT id, salary, 
           DENSE_RANK() OVER (ORDER BY salary DESC) row_num
    FROM Employee
)
SELECT DISTINCT salary AS "SecondHighestSalary"
FROM rank
WHERE row_num = 2
UNION ALL
SELECT NULL AS "SecondHighestSalary"
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM rank WHERE row_num = 2
);

-- Alternative Solution
SELECT (
    SELECT MAX(salary) 
    FROM Employee
    WHERE salary < (SELECT MAX(salary) FROM Employee)) AS SecondHighestSalary
FROM DUAL;
