-- 1988. Find Cutoff Score for Each School

-- Main Solution
SELECT s.school_id, NVL(MIN(e.score), -1) AS score
FROM Schools s
LEFT JOIN Exam e
ON s.capacity >= student_count
GROUP BY s.school_id;

