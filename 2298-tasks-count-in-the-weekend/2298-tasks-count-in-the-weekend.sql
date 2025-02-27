-- 2298. Tasks Count in the Weekend

-- Main Solution
SELECT COUNT(CASE WHEN TO_CHAR(submit_date, 'D') IN ('1', '7') THEN task_id END) AS weekend_cnt,
       COUNT(CASE WHEN TO_CHAR(submit_date, 'D') NOT IN ('1', '7') THEN task_id END) AS working_cnt
FROM Tasks;

