-- 2308. Arrange Table by Gender

-- Main Solution
WITH temp AS (
    SELECT user_id, gender,
           CASE WHEN gender = 'female' THEN 1
                WHEN gender = 'other' THEN 2
                ELSE 3
           END AS gen_temp,
           RANK() OVER (PARTITION BY gender ORDER BY user_id) AS rnk
    FROM Genders
)
SELECT user_id, gender
FROM temp
ORDER BY rnk, gen_temp;

-- Alternative Solution
WITH temp AS (
    SELECT user_id, gender,
           RANK() OVER (PARTITION BY gender ORDER BY user_id) AS rnk
    FROM Genders
)
SELECT user_id, gender
FROM temp
ORDER BY rnk, LENGTH(gender) DESC;
