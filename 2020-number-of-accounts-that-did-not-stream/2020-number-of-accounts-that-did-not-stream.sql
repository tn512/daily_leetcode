-- 2020. Number of Accounts That Did Not Stream

-- Main Solution
SELECT COUNT(su.account_id) AS accounts_count
FROM Subscriptions su
LEFT JOIN Streams st
ON st.account_id = su.account_id
AND EXTRACT(YEAR FROM st.stream_date) = '2021'
WHERE st.account_id IS NULL
AND su.end_date >= '2021-01-01';

