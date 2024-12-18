-- 1204. Last Person to Fit in the Bus

-- Main Solution
WITH temp AS (
    SELECT q1.turn, q1.person_name
    FROM Queue q1
    LEFT JOIN Queue q2
    ON q1.turn >= q2.turn
    GROUP BY q1.turn, q1.person_name
    HAVING SUM(q2.weight) <= 1000
)
SELECT person_name
FROM temp
WHERE turn = (SELECT MAX(turn) FROM temp);

-- Alternative Solution
SELECT *
FROM (
    SELECT person_name
    FROM (
        SELECT person_name,
               SUM(weight) OVER (ORDER BY turn) cal_weight
        FROM Queue
        ORDER BY turn DESC
        )
    WHERE cal_weight <= 1000
)
WHERE ROWNUM = 1;
