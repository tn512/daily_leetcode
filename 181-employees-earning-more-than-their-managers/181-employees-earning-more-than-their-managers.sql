-- 181. Employees Earning More Than Their Managers

-- Main Solution
SELECT e.name AS Employee
FROM Employee e, Employee m
WHERE e.managerId = m.id
AND m.salary < e.salary

