-- 1173. Immediate Food Delivery I

-- Main Solution
SELECT CASE WHEN COUNT(delivery_id) = 0 THEN 0
       ELSE ROUND((COUNT(CASE WHEN order_date = customer_pref_delivery_date 
                        THEN delivery_id 
                   END) 
                  / COUNT(delivery_id)) * 100, 2)
       END AS immediate_percentage
FROM Delivery;

