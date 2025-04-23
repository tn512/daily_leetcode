-- 3204. Bitwise User Permissions Analysis

-- Main Solution
WITH temp AS (
    SELECT user_id, permissions,
           ROW_NUMBER() OVER(ORDER BY user_id) AS row_num
    FROM user_permissions
), recursive_cte(row_num, common_perms, any_perms) AS (
    -- Initialize with the first row
    SELECT row_num, 
           permissions AS common_perms,
           permissions AS any_perms
    FROM temp
    WHERE row_num = 1
    UNION ALL
    -- Recursively accumulate the AND and OR operations
    SELECT u.row_num,
           BITAND(r.common_perms, u.permissions) AS common_perms,
           r.any_perms + u.permissions - BITAND(r.any_perms, u.permissions) AS any_perms
    FROM temp u
    JOIN recursive_cte r
    ON u.row_num = r.row_num + 1
)
SELECT common_perms, any_perms
FROM recursive_cte
WHERE row_num = (SELECT MAX(row_num) FROM temp);

