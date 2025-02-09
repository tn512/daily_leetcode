-- 2051. The Category of Each Member in the Store

-- Main Solution
WITH temp AS (
    SELECT m.member_id, m.name,
           CASE WHEN COUNT(v.visit_id) = 0 THEN -1
                ELSE 100 * COUNT(p.visit_id) / COUNT(v.visit_id)
           END AS conversion_rate
    FROM Members m
    LEFT JOIN Visits v
    ON m.member_id = v.member_id
    LEFT JOIN Purchases p
    ON p.visit_id = v.visit_id
    GROUP BY m.member_id, m.name
)
SELECT member_id, name,
       CASE WHEN conversion_rate = -1 THEN 'Bronze'
            WHEN conversion_rate < 50 THEN 'Silver'
            WHEN conversion_rate < 80 THEN 'Gold'
            ELSE 'Diamond'
       END AS category
FROM temp;

