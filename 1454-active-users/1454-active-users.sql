-- 1454. Active Users

-- Main Solution
WITH island_gap AS (
    SELECT DISTINCT id, login_date,
       DENSE_RANK() OVER (ORDER BY login_date) 
       - DENSE_RANK() OVER (PARTITION BY id ORDER BY login_date) AS gap
    FROM Logins
)
SELECT DISTINCT a.id, a.name
FROM island_gap i
JOIN Accounts a
ON i.id = a.id
GROUP BY a.id, a.name, i.gap
HAVING COUNT(i.login_date) > 4
ORDER BY a.id;

-- Alternative Solution
SELECT DISTINCT l1.id,
       (SELECT name 
        FROM Accounts 
        WHERE id = l1.id) AS name
FROM Logins l1
JOIN Logins l2 
ON l1.id = l2.id 
AND l2.login_date - l1.login_date BETWEEN 1 AND 4
GROUP BY l1.id, l1.login_date
HAVING COUNT(DISTINCT l2.login_date) = 4
ORDER BY l1.id;
