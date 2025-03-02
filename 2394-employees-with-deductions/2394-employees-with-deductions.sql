-- 2394. Employees With Deductions

-- Main Solution
SELECT e.employee_id
FROM Employees e
LEFT JOIN Logs l
ON e.employee_id = l.employee_id
GROUP BY e.employee_id, e.needed_hours
HAVING NVL(SUM(CEIL((l.out_time - l.in_time) * 24 * 60)), 0) < e.needed_hours * 60;

