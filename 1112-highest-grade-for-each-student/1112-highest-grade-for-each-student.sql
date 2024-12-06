-- 1112. Highest Grade For Each Student

-- Main Solution
WITH temp AS (
    SELECT *
    FROM Enrollments
    WHERE (student_id, grade) IN (SELECT student_id, MAX(grade)
                                  FROM Enrollments
                                  GROUP BY student_id)
)
SELECT student_id, MIN(course_id) AS course_id, grade
FROM temp
GROUP BY student_id, grade
ORDER BY student_id;

-- Alternative Solution
SELECT student_id, course_id, grade
FROM (SELECT student_id, course_id, grade,
             DENSE_RANK() OVER (PARTITION BY student_id 
                                ORDER BY grade DESC, course_id ASC) AS rnk
      FROM Enrollments)
WHERE rnk = 1;
