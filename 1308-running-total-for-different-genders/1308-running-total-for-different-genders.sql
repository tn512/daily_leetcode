-- 1308. Running Total for Different Genders

-- Main Solution
SELECT gender, TO_CHAR(day, 'YYYY-MM-DD') AS day,
       SUM(score_points) OVER (PARTITION BY gender
           ORDER BY day) AS total
FROM Scores;

-- Alternative Solution
SELECT s1.gender, TO_CHAR(s1.day, 'YYYY-MM-DD') AS day, SUM(s2.score_points) AS total
FROM Scores s1
LEFT JOIN Scores s2
ON s1.gender = s2.gender
AND s1.day >= s2.day
GROUP BY s1.day, s1.gender
ORDER BY s1.gender, s1.day;
