-- 2346. Compute the Rank as a Percentage

-- Main Solution
SELECT student_id, department_id,
       CASE WHEN COUNT(student_id) OVER (PARTITION BY department_id) = 1 THEN 0
       ELSE ROUND(100 * (RANK() OVER (PARTITION BY department_id ORDER BY mark DESC) - 1)
                  / (COUNT(student_id) OVER (PARTITION BY department_id) - 1), 2) END AS percentage
FROM Students;

-- Alternative Solution
SELECT student_id, department_id,
       ROUND(100 * PERCENT_RANK() OVER (PARTITION BY department_id 
                                        ORDER BY mark DESC), 2) AS percentage
FROM Students;
