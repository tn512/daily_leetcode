-- 1468. Calculate Salaries

-- Main Solution
WITH tax_company AS (
    SELECT company_id,
           CASE WHEN MAX(salary) > 10000 THEN (100 - 49) / 100 
                WHEN MAX(salary) < 1000 THEN (100 - 0) / 100
                ELSE (100 - 24) / 100
           END AS after_tax
    FROM Salaries
    GROUP BY company_id
)
SELECT s.company_id, s.employee_id, s.employee_name,
       ROUND(s.salary * t.after_tax, 0) AS salary
FROM tax_company t
JOIN Salaries s
ON t.company_id = s.company_id;

