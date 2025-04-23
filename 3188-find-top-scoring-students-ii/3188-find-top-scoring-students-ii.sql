-- 3188. Find Top Scoring Students II

-- Main Solution
WITH taken_course AS (
    SELECT s.student_id
    FROM students s
    LEFT JOIN courses c 
    ON s.major = c.major
    LEFT JOIN enrollments e
    ON e.student_id = s.student_id
    AND e.course_id = c.course_id
    GROUP BY s.student_id
    HAVING COUNT(DISTINCT CASE WHEN c.mandatory = 'Yes' THEN c.course_id END) = COUNT(DISTINCT CASE WHEN c.mandatory = 'Yes' AND e.grade = 'A' THEN e.course_id END)
    AND COUNT(DISTINCT CASE WHEN c.mandatory = 'No' AND e.grade IN ('A', 'B') THEN e.course_id END) > 1
)
SELECT e.student_id
FROM enrollments e
JOIN taken_course t
ON e.student_id = t.student_id
GROUP BY e.student_id
HAVING AVG(GPA) >= 2.5
ORDER BY e.student_id;

