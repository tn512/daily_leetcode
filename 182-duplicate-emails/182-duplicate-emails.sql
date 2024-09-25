-- 182. Duplicate Emails

-- Main Solution
SELECT email
FROM Person
GROUP BY email
HAVING COUNT(id) > 1;

