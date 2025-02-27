-- 2388. Change Null Values in a Table to the Previous Value

-- Main Solution
SELECT id,
       CASE WHEN drink IS NOT NULL THEN drink
            ELSE LAG(drink IGNORE NULLS) OVER (ORDER BY ROWNUM)
       END AS drink
FROM CoffeeShop;

