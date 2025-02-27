-- 2362. Generate the Invoice

-- Main Solution
WITH invoice_detail AS (
    SELECT pur.invoice_id, pur.product_id, pur.quantity, pur.quantity * pro.price AS price,
           SUM(pur.quantity * pro.price) OVER (PARTITION BY invoice_id) AS total
    FROM Purchases pur
    JOIN Products pro
    ON pur.product_id = pro.product_id
), temp AS (
    SELECT product_id, quantity, price,
           RANK() OVER (ORDER BY total DESC, invoice_id) AS rnk
    FROM invoice_detail
)
SELECT product_id, quantity, price
FROM temp
WHERE rnk = 1;

