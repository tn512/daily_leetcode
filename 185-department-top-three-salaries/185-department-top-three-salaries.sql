-- 185. Department Top Three Salaries

-- Main Solution
WITH rank_num AS (
    SELECT id, name, salary, departmentId,
           DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rank
    FROM Employee)
SELECT d.name AS Department, r.name AS Employee, r.salary
FROM rank_num r, Department d
WHERE d.id = r.departmentId
AND rank < 4;

-- Alternative Solution
SELECT d.name AS Department, e1.name AS Employee, e1.salary
FROM Employee e1
JOIN Department d ON e1.departmentId = d.id
WHERE 3 > (SELECT COUNT(DISTINCT e2.salary)
           FROM Employee e2
           WHERE e2.salary > e1.salary AND e2.departmentId = d.id);
