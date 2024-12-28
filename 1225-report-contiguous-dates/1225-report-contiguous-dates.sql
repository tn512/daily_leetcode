-- 1225. Report Contiguous Dates

-- Main Solution
WITH all_dates AS (
    SELECT fail_date AS log_date, 'failed' AS period_state
    FROM Failed
    WHERE fail_date BETWEEN '2019-01-01' AND '2019-12-31'
    UNION
    SELECT success_date, 'succeeded'
    FROM Succeeded
    WHERE success_date BETWEEN '2019-01-01' AND '2019-12-31'
), interval_grp AS (
    SELECT log_date, period_state,
       ROW_NUMBER() OVER (ORDER BY log_date) 
       - ROW_NUMBER() OVER (PARTITION BY period_state ORDER BY log_date) AS interval
    FROM all_dates
)
SELECT period_state, TO_CHAR(MIN(log_date), 'YYYY-MM-DD') AS start_date, TO_CHAR(MAX(log_date), 'YYYY-MM-DD') AS end_date
FROM interval_grp
GROUP BY interval, period_state
ORDER BY start_date;

