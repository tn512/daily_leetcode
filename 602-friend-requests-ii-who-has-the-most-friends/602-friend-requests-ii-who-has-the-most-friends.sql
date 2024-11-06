-- 602. Friend Requests II: Who Has the Most Friends

-- Main Solution
WITH temp AS (
    SELECT requester_id AS id, COUNT(1) AS cnt
    FROM RequestAccepted
    GROUP BY requester_id
    UNION ALL
    SELECT accepter_id AS id, COUNT(1) AS cnt
    FROM RequestAccepted
    GROUP BY accepter_id
)
SELECT * 
FROM (SELECT id, SUM(cnt) AS num
      FROM temp
      GROUP BY id
      ORDER BY SUM(cnt) DESC)
WHERE ROWNUM = 1;

-- Alternative Solution
WITH temp AS (
    SELECT requester_id AS id, COUNT(1) AS cnt
    FROM RequestAccepted
    GROUP BY requester_id
    UNION ALL
    SELECT accepter_id AS id, COUNT(1) AS cnt
    FROM RequestAccepted
    GROUP BY accepter_id
)
SELECT id, num
FROM (SELECT id, SUM(cnt) AS num,
             MAX(SUM(cnt)) OVER() AS mx
      FROM temp
      GROUP BY id
      ORDER BY SUM(cnt) DESC)
WHERE num = mx;
