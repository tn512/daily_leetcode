-- 2372. Calculate the Influence of Each Salesperson

-- Main Solution
SELECT p.salesperson_id, p.name, NVL(SUM(s.price), 0) AS total
FROM Salesperson p
LEFT JOIN Customer c
ON p.salesperson_id = c.salesperson_id
LEFT JOIN Sales s
ON s.customer_id = c.customer_id
GROUP BY p.salesperson_id, p.name;

