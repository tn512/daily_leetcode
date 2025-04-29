-- 3278. Find Candidates for Data Scientist Position II

-- Main Solution
WITH scores AS (
    SELECT DISTINCT p.project_id, c.candidate_id,
           100 + SUM(CASE WHEN c.proficiency > p.importance THEN 10
                          WHEN c.proficiency < p.importance THEN -5
                          ELSE 0
                     END) OVER (PARTITION BY p.project_id, c.candidate_id) AS score,
           COUNT(DISTINCT p.skill) OVER (PARTITION BY p.project_id) AS project_cnt,
           COUNT(c.skill) OVER (PARTITION BY p.project_id, c.candidate_id) AS candidate_cnt
    FROM Projects p
    LEFT JOIN Candidates c
    ON c.skill = p.skill
), rank_scores AS (
    SELECT project_id, candidate_id, score,
           RANK() OVER (PARTITION BY project_id ORDER BY score DESC, candidate_id) AS rnk
    FROM scores
    WHERE project_cnt = candidate_cnt
)
SELECT project_id, candidate_id, score
FROM rank_scores
WHERE rnk = 1
ORDER BY project_id;

