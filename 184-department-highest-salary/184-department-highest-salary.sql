-- 184. Department Highest Salary

-- Main Solution
WITH max_salary AS (
    SELECT departmentId, MAX(salary) AS salary
    FROM Employee
    GROUP BY departmentId)
SELECT d.name AS Department, e.name AS Employee, m.salary AS Salary
FROM Employee e, Department d, max_salary m
WHERE e.departmentId = d.id
AND e.departmentId = m.departmentId
AND e.salary = m.salary;

