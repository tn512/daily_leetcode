-- 1435. Create a Session Bar Chart

-- Main Solution
WITH temp AS (
    SELECT session_id,
           CASE WHEN duration / 60 < 5  THEN '[0-5>'
                WHEN duration / 60 < 10  THEN '[5-10>'
                WHEN duration / 60 < 15  THEN '[10-15>'
                ELSE '15 or more'
           END AS bin
    FROM Sessions
    UNION ALL
    SELECT NULL, '[0-5>' FROM DUAL
    UNION ALL
    SELECT NULL, '[5-10>' FROM DUAL
    UNION ALL
    SELECT NULL, '[10-15>' FROM DUAL
    UNION ALL
    SELECT NULL, '15 or more' FROM DUAL
)
SELECT bin, COUNT(session_id) AS total
FROM temp
GROUP BY bin;

