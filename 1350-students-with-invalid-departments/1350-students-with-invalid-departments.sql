-- 1350. Students With Invalid Departments

-- Main Solution
SELECT s.id, s.name
FROM Students s
LEFT JOIN Departments d
ON s.department_id = d.id
WHERE d.id IS NULL;

