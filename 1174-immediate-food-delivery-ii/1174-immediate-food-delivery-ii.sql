-- 1174. Immediate Food Delivery II

-- Main Solution
SELECT CASE WHEN COUNT(delivery_id) = 0 THEN 0
            ELSE ROUND((COUNT(CASE WHEN order_date = customer_pref_delivery_date 
                        THEN delivery_id END) 
                       /COUNT(delivery_id)) * 100, 2)
       END AS immediate_percentage
FROM Delivery
WHERE (customer_id, order_date) IN (SELECT customer_id, MIN(order_date) 
                                  FROM Delivery 
                                  GROUP BY customer_id);

-- Alternative Solution
WITH temp AS (
    SELECT DISTINCT customer_id,
       FIRST_VALUE(order_date) OVER (PARTITION BY customer_id ORDER BY order_date ASC) AS order_date,
       FIRST_VALUE(customer_pref_delivery_date) OVER (PARTITION BY customer_id ORDER BY order_date ASC) AS cp_delivery_date
    FROM Delivery
)
SELECT CASE WHEN COUNT(customer_id) = 0 THEN 0
            ELSE ROUND((COUNT(CASE WHEN order_date = cp_delivery_date 
                        THEN customer_id END) 
                       /COUNT(customer_id)) * 100, 2)
       END AS immediate_percentage
FROM temp;
