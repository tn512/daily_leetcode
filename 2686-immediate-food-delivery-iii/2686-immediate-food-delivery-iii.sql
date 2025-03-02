-- 2686. Immediate Food Delivery III

-- Main Solution
SELECT TO_CHAR(order_date, 'YYYY-MM-DD') AS order_date,
       CASE WHEN COUNT(delivery_id) = 0 THEN 0
            ELSE ROUND((COUNT(CASE WHEN order_date = customer_pref_delivery_date 
                        THEN delivery_id 
                   END) 
                  / COUNT(delivery_id)) * 100, 2)
       END AS immediate_percentage
FROM Delivery
GROUP BY order_date
ORDER BY order_date;

