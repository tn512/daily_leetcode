-- 626. Exchange Seats

-- Main Solution
SELECT s1.id,
       CASE WHEN MOD(s1.id, 2) = 0 THEN s3.student
            WHEN s1.id = (SELECT MAX(id) FROM Seat) THEN s1.student
            ELSE s2.student
       END AS student
FROM Seat s1
LEFT JOIN Seat s2
ON s1.id = s2.id - 1
LEFT JOIN Seat s3
ON s1.id = s3.id + 1
ORDER BY s1.id;

-- Alternative Solution
WITH seat_cnt AS(
    SELECT COUNT(*) AS cnt FROM Seat
)
SELECT CASE WHEN MOD(id, 2) = 0 THEN id - 1
            WHEN id = cnt THEN id
            ELSE id + 1
       END AS id,
       student
FROM Seat, seat_cnt
ORDER BY id;

SELECT id, 
       NVL(CASE WHEN MOD(id, 2) = 0 THEN LAG(student) OVER(ORDER BY id)
            ELSE LEAD(student) OVER(ORDER BY id)
       END, student) AS student
FROM Seat;
