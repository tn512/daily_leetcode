-- 3126. Server Utilization Time

-- Main Solution
WITH session_temp AS (
    SELECT server_id, status_time, session_status,
           ROW_NUMBER() OVER (PARTITION BY server_id, session_status ORDER BY ROWNUM) AS session_id
    FROM Servers
)
SELECT FLOOR(SUM(ses_stop.status_time - ses_start.status_time)) AS total_uptime_days
FROM session_temp ses_start
JOIN session_temp ses_stop
ON ses_start.server_id = ses_stop.server_id
AND ses_start.session_id = ses_stop.session_id
AND ses_stop.session_status = 'stop'
AND ses_start.session_status = 'start';

