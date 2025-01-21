-- 1613. Find the Missing IDs

-- Main Solution
SELECT LEVEL AS "ids"
FROM DUAL
CONNECT BY LEVEL <= (SELECT MAX(customer_id) FROM Customers)
MINUS
SELECT customer_id
FROM Customers;

