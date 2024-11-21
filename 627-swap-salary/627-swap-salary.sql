-- 627. Swap Salary

-- Main Solution
UPDATE Salary SET sex = CASE WHEN sex = 'm' THEN 'f' ELSE 'm' END;

