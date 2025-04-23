-- 3262. Find Overlapping Shifts

-- Main Solution
SELECT s1.employee_id, COUNT(s2.start_time) AS overlapping_shifts
FROM EmployeeShifts s1
JOIN EmployeeShifts s2
ON s2.start_time > s1.start_time 
AND s2.start_time < s1.end_time
AND s1.employee_id = s2.employee_id
GROUP BY s1.employee_id
ORDER BY s1.employee_id;

