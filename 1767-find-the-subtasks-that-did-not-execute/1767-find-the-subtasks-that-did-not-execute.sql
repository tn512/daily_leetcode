-- 1767. Find the Subtasks That Did Not Execute

-- Main Solution
SELECT task_id, LEVEL AS subtask_id
FROM Tasks
CONNECT BY LEVEL <= subtasks_count 
AND PRIOR task_id = task_id
AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
MINUS
SELECT task_id, subtask_id
FROM Executed;

