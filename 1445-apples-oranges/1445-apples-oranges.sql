-- 1445. Apples & Oranges

-- Main Solution
SELECT TO_CHAR(sale_date, 'YYYY-MM-DD') AS sale_date, 
       SUM(CASE WHEN fruit = 'apples' THEN sold_num
                ELSE sold_num * -1
           END) AS diff
FROM Sales
GROUP BY sale_date
ORDER BY sale_date;

