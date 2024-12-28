-- 1364. Number of Trusted Contacts of a Customer

-- Main Solution
WITH temp AS (
    SELECT cus1.customer_id, cus1.customer_name, 
           COUNT(con.contact_name) AS contacts_cnt,
           COUNT(cus2.customer_id) AS trusted_contacts_cnt
    FROM Customers cus1
    LEFT JOIN Contacts con
    ON cus1.customer_id = con.user_id
    LEFT JOIN Customers cus2
    ON cus2.email = con.contact_email
    GROUP BY cus1.customer_id, cus1.customer_name
)
SELECT i.invoice_id, t.customer_name, i.price, t.contacts_cnt, t.trusted_contacts_cnt
FROM Invoices i
JOIN temp t
ON i.user_id = t.customer_id
ORDER BY i.invoice_id;

