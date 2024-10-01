-- 196. Delete Duplicate Emails

-- Main Solution
DELETE FROM Person p1 
WHERE EXISTS (SELECT 1 FROM Person p2 
              WHERE p1.email = p2.email and p1.id > p2.id)

-- Alternative Solution
DELETE FROM Person p1
WHERE p1.id NOT IN (SELECT MIN(p2.id) 
                    FROM Person p2 
                    GROUP BY p2.email);
