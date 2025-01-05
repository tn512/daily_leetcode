-- 1412. Find the Quiet Students in All Exams

-- Main Solution
WITH temp_score AS (
    SELECT exam_id, MAX(score) AS score
    FROM Exam
    GROUP BY exam_id
    UNION ALL
    SELECT exam_id, MIN(score)
    FROM Exam
    GROUP BY exam_id
), temp_student AS (
    SELECT student_id
    FROM Exam e
    JOIN temp_score t
    ON e.exam_id = t.exam_id
    AND e.score = t.score
)
SELECT DISTINCT s.*
FROM Exam e
JOIN Student s
ON s.student_id = e.student_id
WHERE s.student_id NOT IN (SELECT student_id FROM temp_student)
ORDER BY s.student_id;

-- Alternative Solution
WITH rnk_score AS (
    SELECT exam_id, student_id, score,
       RANK() OVER (PARTITION BY exam_id ORDER BY score DESC) AS rnk_desc,
       RANK() OVER (PARTITION BY exam_id ORDER BY score) AS rnk_asc
    FROM Exam
)
SELECT s.student_id, s.student_name
FROM rnk_score r
JOIN Student s
ON s.student_id = r.student_id
GROUP BY s.student_id, s.student_name
HAVING COUNT(CASE WHEN rnk_desc = 1 THEN rnk_desc END) = 0
AND COUNT(CASE WHEN rnk_asc = 1 THEN rnk_asc END) = 0
ORDER BY s.student_id;
