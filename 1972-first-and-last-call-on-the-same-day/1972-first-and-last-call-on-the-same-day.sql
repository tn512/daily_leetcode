-- 1972. First and Last Call On the Same Day

-- Main Solution
WITH temp AS (
    SELECT caller_id AS user1_id, recipient_id AS user2_id, 
           call_time, TO_CHAR(call_time, 'YYYY-MM-DD') AS day
    FROM Calls
    UNION 
    SELECT recipient_id, caller_id, call_time,
           TO_CHAR(call_time, 'YYYY-MM-DD') AS day
    FROM Calls
), idk AS (
    SELECT DISTINCT user1_id,
           FIRST_VALUE(user2_id) OVER (PARTITION BY user1_id, day ORDER BY call_time) first_user,
           FIRST_VALUE(user2_id) OVER (PARTITION BY user1_id, day ORDER BY call_time DESC) last_user
    FROM temp
)
SELECT DISTINCT user1_id AS user_id
FROM idk
WHERE first_user = last_user;

