-- 1341. Movie Rating

-- Main Solution
WITH rating_cnt AS (
    SELECT u.name
    FROM MovieRating mr
    JOIN Users u
    ON mr.user_id = u.user_id
    GROUP BY u.name
    ORDER BY COUNT(*) DESC, u.name ASC
), avg_rating AS (
    SELECT m.title
    FROM MovieRating mr
    JOIN Movies m
    ON mr.movie_id = m.movie_id
    WHERE TO_CHAR(mr.created_at, 'YYYY-MM') = '2020-02'
    GROUP BY m.title
    ORDER BY AVG(rating) DESC, m.title ASC
)
SELECT name AS results
FROM (SELECT * FROM rating_cnt)
WHERE ROWNUM = 1
UNION ALL
SELECT * 
FROM (SELECT * FROM avg_rating)
WHERE ROWNUM = 1;

