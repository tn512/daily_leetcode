-- 1076. Project Employees II

-- Main Solution
WITH temp AS (
    SELECT project_id, COUNT(employee_id) cnt
    FROM Project
    GROUP BY project_id
    ORDER BY cnt DESC
)
SELECT project_id
FROM temp
WHERE cnt = (SELECT cnt FROM temp WHERE ROWNUM = 1);

