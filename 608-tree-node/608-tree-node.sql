-- 608. Tree Node

-- Main Solution
SELECT DISTINCT t1.id,
       CASE WHEN t1.p_id IS NULL THEN 'Root' 
            WHEN t2.p_id IS NULL THEN 'Leaf' 
            ELSE 'Inner' END AS "type"
FROM Tree t1
LEFT JOIN Tree t2
ON t1.id = t2.p_id;

-- Alternative Solution
SELECT id,
       CASE WHEN p_id IS NULL THEN 'Root'
            WHEN id IN (SELECT DISTINCT p_id FROM Tree) THEN 'Inner'
            ELSE 'Leaf'
       END AS type
FROM Tree;
