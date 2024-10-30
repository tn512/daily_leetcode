-- 578. Get Highest Answer Rate Question

-- Main Solution
with cnt AS (
    SELECT question_id,
       SUM(CASE WHEN action = 'answer' THEN 1 ELSE 0 END) a_c,
       SUM(CASE WHEN action = 'show' THEN 1 ELSE 0 END) s_c
    FROM SurveyLog
    GROUP BY question_id
), max_rnk AS (
    SELECT question_id, a_c/s_c AS rnk
    FROM cnt
    ORDER BY rnk DESC, question_id ASC
)
SELECT question_id AS survey_log 
FROM max_rnk
WHERE ROWNUM = 1;

