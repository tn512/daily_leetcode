-- 3124. Find Longest Calls

-- Main Solution
WITH rnk AS (
    SELECT co.first_name, ca.type,
           ROW_NUMBER() OVER (PARTITION BY type 
                              ORDER BY ca.duration DESC, co.first_name DESC) AS rn,
           SUBSTR(
            TO_CHAR(
                NUMTODSINTERVAL(ca.duration, 'SECOND'),
                'HH24:MI:SS'), 
            12, 8) AS duration_formatted
    FROM Calls ca
    JOIN Contacts co
    ON ca.contact_id = co.id
)
SELECT first_name, type, duration_formatted
FROM rnk
WHERE rn < 4
ORDER BY type DESC, 
         duration_formatted DESC, 
         first_name DESC;

