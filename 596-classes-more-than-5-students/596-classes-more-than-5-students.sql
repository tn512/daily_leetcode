-- 596. Classes More Than 5 Students

-- Main Solution
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;

