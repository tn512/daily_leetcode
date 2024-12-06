-- 1113. Reported Posts

-- Main Solution
SELECT extra AS report_reason, COUNT(DISTINCT post_id) AS report_count
FROM Actions
WHERE action_date = TO_DATE('2019-07-05', 'YYYY-MM-DD') - 1
AND action = 'report'
GROUP BY extra;

