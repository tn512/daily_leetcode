-- 1867. Orders With Maximum Quantity Above Average

-- Main Solution
WITH temp AS (
    SELECT order_id, MAX(quantity) mx, AVG(quantity) av
    FROM OrdersDetails
    GROUP BY order_id
)
SELECT order_id
FROM temp
WHERE mx > (SELECT MAX(av) FROM temp);

-- Alternative Solution
WITH temp AS (
    SELECT order_id, 
           MAX(quantity) mx, 
           MAX(AVG(quantity)) OVER () mx_av
    FROM OrdersDetails
    GROUP BY order_id
)
SELECT order_id
FROM temp
WHERE mx > mx_av;
