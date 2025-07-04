-- 3421. Find Students Who Improved

-- Main Solution
WITH temp AS (
    SELECT DISTINCT student_id, subject, 
           FIRST_VALUE(score) OVER (PARTITION BY student_id, subject ORDER BY exam_date) AS first_score, 
           FIRST_VALUE(score) OVER (PARTITION BY student_id, subject ORDER BY exam_date DESC) AS latest_score
    FROM Scores
)
SELECT *
FROM temp
WHERE latest_score > first_score
ORDER BY student_id, subject;

