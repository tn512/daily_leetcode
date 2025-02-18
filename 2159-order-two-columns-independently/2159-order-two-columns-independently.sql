-- 2159. Order Two Columns Independently

-- Main Solution
WITH first_col_temp AS (
    SELECT first_col,
           ROW_NUMBER() OVER (ORDER BY first_col) AS rn
    FROM Data
), second_col_temp AS (
    SELECT second_col,
           ROW_NUMBER() OVER (ORDER BY second_col DESC) AS rn
    FROM Data
)
SELECT f.first_col, s.second_col
FROM first_col_temp f
JOIN second_col_temp s
ON f.rn = s.rn;

