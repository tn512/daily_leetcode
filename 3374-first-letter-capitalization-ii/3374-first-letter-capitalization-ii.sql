-- 3374. First Letter Capitalization II

-- Main Solution
WITH rec_cte AS (
    SELECT content_id, content_text,
           REGEXP_SUBSTR(new_text, '[^ ]+', 1, LEVEL) AS converted_single_text
    FROM (
        SELECT content_id, content_text, 
               REPLACE(content_text, '-', ' -') AS new_text
        FROM user_content
    )
    CONNECT BY REGEXP_SUBSTR(new_text, '[^ ]+', 1, LEVEL) IS NOT NULL
        AND PRIOR content_id = content_id
        AND PRIOR SYS_GUID() IS NOT NULL
), clean_dash AS (
    SELECT content_id, content_text,
           REPLACE(converted_single_text, '-', '') AS converted_single_text,
           CASE WHEN converted_single_text LIKE '%-%' THEN 1
                ELSE 0
           END AS flag_dash
    FROM rec_cte
), capitalized_text AS (
    SELECT content_id, content_text, flag_dash,
           UPPER(SUBSTR(converted_single_text, 1, 1))
           || LOWER(SUBSTR(converted_single_text, 2, 
                           LENGTH(converted_single_text))) AS capitalized_single_text
    FROM clean_dash
), temp AS (
    SELECT content_id, content_text,
           DECODE(flag_dash, 1, '-' || capitalized_single_text, capitalized_single_text) AS single_text,
           ROWNUM AS text_id
    FROM capitalized_text
)
SELECT content_id, content_text AS original_text,
       REPLACE(LISTAGG(single_text, ' ') WITHIN GROUP (ORDER BY text_id),
               ' -', '-') AS converted_text
FROM temp
GROUP BY content_id, content_text;

-- Alternative Solution
SELECT content_id, 
       content_text AS original_text, 
       INITCAP(content_text) AS converted_text 
FROM user_content;
