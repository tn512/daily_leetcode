-- 2993. Friday Purchases I

-- Main Solution
SELECT CEIL(TO_NUMBER(TO_CHAR(purchase_date, 'DD')) / 7) AS week_of_month, 
       TO_CHAR(MAX(purchase_date), 'YYYY-MM-DD') AS purchase_date, 
       SUM(amount_spend) AS total_amount
FROM Purchases
WHERE TO_CHAR(purchase_date, 'D') = '6'
GROUP BY CEIL(TO_NUMBER(TO_CHAR(purchase_date, 'DD')) / 7)
ORDER BY week_of_month;

-- Alternative Solution
SELECT TO_CHAR(purchase_date, 'WW') - TO_CHAR(TO_DATE('2023-11-01'), 'WW') + 1 AS week_of_month,
       TO_CHAR(purchase_date, 'YYYY-MM-DD') AS purchase_date,
       SUM(amount_spend) AS total_amount
FROM Purchases
WHERE TO_CHAR(purchase_date, 'D') = '6'
GROUP BY purchase_date
ORDER BY week_of_month;
