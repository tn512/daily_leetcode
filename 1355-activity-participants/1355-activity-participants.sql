-- 1355. Activity Participants

-- Main Solution
WITH cnt_activity AS (
    SELECT activity, COUNT(*) AS cnt
    FROM Friends
    GROUP BY activity)
SELECT activity 
FROM cnt_activity 
WHERE cnt NOT IN (SELECT MAX(cnt) FROM cnt_activity
                  UNION ALL
                  SELECT MIN(cnt) FROM cnt_activity);

-- Alternative Solution
WITH rnk_activity AS (
    SELECT activity,
           RANK() OVER (ORDER BY COUNT(id)) rank_asc,
           RANK() OVER (ORDER BY COUNT(id) DESC) rank_desc
    FROM Friends
    GROUP BY activity)
SELECT activity
FROM rnk_activity
WHERE rank_asc <> 1 AND rank_desc <> 1;
