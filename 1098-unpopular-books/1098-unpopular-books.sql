-- 1098. Unpopular Books

-- Main Solution
SELECT b.book_id, b.name
FROM Books b
LEFT JOIN (
    SELECT book_id, SUM(quantity) AS book_sold
    FROM Orders
    WHERE dispatch_date BETWEEN '2018-06-23' AND '2019-06-23'
    GROUP BY book_id
) t
ON b.book_id = t.book_id
WHERE b.available_from < ADD_MONTHS('2019-06-23', -1)
AND (t.book_sold IS NULL OR t.book_sold < 10)
ORDER BY b.book_id;

