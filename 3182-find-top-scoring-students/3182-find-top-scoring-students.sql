-- 3182. Find Top Scoring Students

-- Main Solution
WITH major_cnt AS (
    SELECT major, COUNT(course_id) AS cnt
    FROM courses
    GROUP BY major
), taken_cnt AS (
    SELECT s.student_id, s.major, COUNT(*) AS cnt
    FROM courses c
    JOIN enrollments e
    ON e.course_id = c.course_id
    AND e.grade = 'A'
    JOIN students s
    ON e.student_id = s.student_id
    AND s.major = c.major
    GROUP BY s.student_id, s.major
)
SELECT t.student_id
FROM taken_cnt t
JOIN major_cnt m
ON t.major = m.major
AND t.cnt = m.cnt
ORDER BY t.student_id;

-- Alternative Solution
SELECT s.student_id
FROM students s
LEFT JOIN courses c 
ON s.major = c.major
LEFT JOIN enrollments e
ON e.student_id = s.student_id
AND e.course_id = c.course_id
GROUP BY s.student_id
HAVING COUNT(DISTINCT c.course_id) = COUNT(DISTINCT e.course_id)
AND MAX(e.grade) = 'A'
ORDER BY s.student_id;
