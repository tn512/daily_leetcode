-- 601. Human Traffic of Stadium

-- Main Solution
SELECT DISTINCT s1.id, TO_CHAR(s1.visit_date, 'YYYY-MM-DD') AS visit_date, s1.people
FROM Stadium s1, Stadium s2, Stadium s3
WHERE ((s1.id - s2.id = 1 AND s2.id - s3.id = 1)
    OR (s3.id - s2.id = 1 AND s2.id - s1.id = 1)
    OR (s2.id - s1.id = 1 AND s1.id - s3.id = 1))
AND s1.people >= 100
AND s2.people >= 100
AND s3.people >= 100
ORDER BY s1.id

SELECT id, TO_CHAR(visit_date, 'YYYY-MM-DD') AS visit_date, people 
FROM (SELECT id, visit_date, people,
       LEAD(id) OVER (ORDER BY id) AS next_id,
       LEAD(id, 2) OVER (ORDER BY id) AS second_next_id,
       LAG(id) OVER (ORDER BY id) AS prev_id,
       LAG(id, 2) OVER (ORDER BY id) AS second_prev_id
      FROM Stadium
      WHERE people > 99)
WHERE (id + 1 = next_id AND next_id + 1 = second_next_id)
OR (prev_id + 1 = id AND id + 1 = next_id)
OR (second_prev_id + 1 = prev_id AND prev_id + 1 = id)

-- Alternative Solution
WITH temp AS (
    SELECT id, visit_date, people,
           id - ROW_NUMBER() OVER (ORDER BY id) AS id_diff
    FROM Stadium
    WHERE people > 99
) 
SELECT id, TO_CHAR(visit_date, 'YYYY-MM-DD') AS visit_date, people 
FROM temp
WHERE id_diff IN (SELECT id_diff 
                  FROM temp 
                  GROUP BY id_diff
                  HAVING COUNT(id) > 2)
ORDER BY id;
