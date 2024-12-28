-- 1280. Students and Examinations

-- Main Solution
WITH base AS (
    SELECT *
    FROM Students
    CROSS JOIN Subjects
)
SELECT b.student_id, b.student_name, b.subject_name, COUNT(e.subject_name) AS attended_exams
FROM base b
LEFT JOIN Examinations e
ON b.student_id = e.student_id
AND b.subject_name = e.subject_name
GROUP BY b.student_id, b.student_name, b.subject_name
ORDER BY b.student_id, b.student_name;

