-- 1990. Count the Number of Experiments

-- Main Solution
WITH base AS (
    SELECT *
    FROM (SELECT 'Android' AS platform FROM DUAL
          UNION SELECT 'IOS' FROM DUAL
          UNION SELECT 'Web' FROM DUAL)
    CROSS JOIN (SELECT 'Reading' AS experiment_name FROM DUAL
                UNION SELECT 'Sports' FROM DUAL
                UNION SELECT 'Programming' FROM DUAL)
)
SELECT b.platform, b.experiment_name, COUNT(e.experiment_id) AS num_experiments
FROM base b 
LEFT JOIN Experiments e
ON b.platform = e.platform
AND b.experiment_name = e.experiment_name
GROUP BY b.platform, b.experiment_name;

