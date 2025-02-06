-- 1907. Count Salary Categories

-- Main Solution
SELECT 'Low Salary' AS category, 
       COUNT(CASE WHEN income < 20000 THEN account_id END) AS accounts_count
FROM Accounts
UNION
SELECT 'Average Salary', COUNT(CASE WHEN income >= 20000 AND income <= 50000 THEN account_id END)
FROM Accounts
UNION
SELECT 'High Salary', COUNT(CASE WHEN income > 50000 THEN account_id END)
FROM Accounts;

