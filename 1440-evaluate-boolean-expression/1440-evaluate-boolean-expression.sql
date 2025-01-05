-- 1440. Evaluate Boolean Expression

-- Main Solution
SELECT e.*,
       CASE WHEN operator = '=' AND v_l.value = v_r.value THEN 'true' 
            WHEN operator = '>' AND v_l.value > v_r.value THEN 'true'
            WHEN operator = '<' AND v_l.value < v_r.value THEN 'true'
            ELSE 'false'
       END AS value
FROM Expressions e
JOIN Variables v_l
ON e.left_operand = v_l.name
JOIN Variables v_r
ON e.right_operand = v_r.name;

