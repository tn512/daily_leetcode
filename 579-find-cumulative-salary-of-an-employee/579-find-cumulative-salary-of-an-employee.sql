-- 579. Find Cumulative Salary of an Employee

-- Main Solution
WITH all_months AS(
    SELECT LEVEL as month, NULL as t_salary
    FROM DUAL
    CONNECT BY LEVEL < (SELECT MAX(month) FROM Employee)
), temp AS (
    SELECT * 
    FROM all_months a
    CROSS JOIN (SELECT DISTINCT id FROM Employee)
), idk AS (
    SELECT t.id, t.month, COALESCE(e.salary, NULL) AS sal
    FROM temp t
    LEFT JOIN Employee e
    ON t.id = e.id
    AND t.month = e.month
    WHERE t.month < (SELECT MAX(month) FROM Employee GROUP BY id HAVING id = t.id)
), cuml AS (
    SELECT id, month, sal,
           SUM(sal) OVER (PARTITION BY id 
                            ORDER BY month 
                            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) sum_cum 
    FROM idk
)
SELECT id, month, sum_cum AS salary
FROM cuml
WHERE sal IS NOT NULL
ORDER BY id ASC, month DESC;

-- Alternative Solution
SELECT e1.id, e1.month, NVL(e1.salary, 0) + NVL(e2.salary, 0) + NVL(e3.salary, 0) AS salary
FROM Employee e1
LEFT JOIN Employee e2
ON e1.id = e2.id AND e1.month = e2.month + 1
LEFT JOIN Employee e3
ON e1.id = e3.id AND e1.month = e3.month + 2
WHERE (e1.id, e1.month) NOT IN (SELECT id, MAX(month) FROM Employee GROUP BY id)
ORDER BY e1.id ASC, e1.month DESC;
