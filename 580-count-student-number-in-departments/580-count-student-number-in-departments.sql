-- 580. Count Student Number in Departments

-- Main Solution
SELECT dept_name, COUNT(student_id) AS student_number
FROM Department d
LEFT JOIN Student s
ON d.dept_id = s.dept_id
GROUP BY d.dept_name
ORDER BY student_number DESC, dept_name ASC

