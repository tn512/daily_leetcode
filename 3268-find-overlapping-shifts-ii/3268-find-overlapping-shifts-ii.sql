-- 3268. Find Overlapping Shifts II

-- Main Solution
WITH overlaps AS (
    SELECT DISTINCT s1.employee_id, 
           GREATEST(s1.start_time, s2.start_time) AS overlapping_start, 
           LEAST(s1.end_time, s2.end_time) AS overlapping_end,
           SUM(24 * 60 * (LEAST(s1.end_time, s2.end_time) - GREATEST(s1.start_time, s2.start_time)))
            OVER (PARTITION BY s1.employee_id) AS overlap_duration
    FROM EmployeeShifts s1
    JOIN EmployeeShifts s2
    ON s2.start_time > s1.start_time 
    AND s2.start_time < s1.end_time
    AND s1.employee_id = s2.employee_id
), rank_overlaps AS (
    SELECT DISTINCT e.employee_id,
           COUNT(*) AS cnt,
           RANK() OVER (PARTITION BY e.employee_id ORDER BY COUNT(*) DESC) AS rnk,
           MAX(NVL(o.overlap_duration, 0)) AS total_overlap_duration
    FROM EmployeeShifts e
    LEFT JOIN overlaps o
    ON e.employee_id = o.employee_id
    AND o.overlapping_start >= e.start_time
    AND o.overlapping_end <= e.end_time
    GROUP BY e.employee_id, NVL(o.overlapping_start, e.start_time), NVL(o.overlapping_end, e.end_time)
)
SELECT employee_id, cnt AS max_overlapping_shifts, total_overlap_duration
FROM rank_overlaps
WHERE rnk = 1
ORDER BY employee_id;

