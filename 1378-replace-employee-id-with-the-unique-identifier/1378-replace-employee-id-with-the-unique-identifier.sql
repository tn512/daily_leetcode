-- 1378. Replace Employee ID With The Unique Identifier

-- Main Solution
SELECT u.unique_id, e.name
FROM Employees e
LEFT JOIN EmployeeUNI u
ON e.id = u.id;

