-- 615. Average Salary: Departments VS Company

-- Main Solution
WITH temp AS (
    SELECT s.amount, e.department_id, 
           TO_CHAR(pay_date, 'YYYY-MM') AS pay_month
    FROM Salary s, Employee e
    WHERE s.employee_id = e.employee_id
), avg_dept AS (
    SELECT pay_month, department_id, AVG(amount) AS avg_d
    FROM temp
    GROUP BY department_id, pay_month
), avg_all AS (
    SELECT pay_month, AVG(amount) AS avg_a
    FROM temp
    GROUP BY pay_month
)
SELECT d.pay_month, d.department_id,
       CASE WHEN d.avg_d > a.avg_a THEN 'higher' 
            WHEN d.avg_d < a.avg_a THEN 'lower' 
            ELSE 'same'
       END AS comparison
FROM avg_dept d, avg_all a
WHERE d.pay_month = a.pay_month;

-- Alternative Solution
WITH temp AS (
    SELECT s.amount, e.department_id, 
           TO_CHAR(pay_date, 'YYYY-MM') AS pay_month
    FROM Salary s, Employee e
    WHERE s.employee_id = e.employee_id
), idk AS (
    SELECT DISTINCT pay_month, department_id,
       AVG(amount) OVER (PARTITION BY pay_month, department_id) AS avg_d,
       AVG(amount) OVER (PARTITION BY pay_month) AS avg_a
    FROM temp
) SELECT pay_month, department_id,
         CASE WHEN avg_d > avg_a THEN 'higher' 
              WHEN avg_d < avg_a THEN 'lower' 
              ELSE 'same'
         END AS comparison
FROM idk;
