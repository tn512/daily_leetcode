-- 1179. Reformat Department Table

-- Main Solution
SELECT id,
       MAX(CASE WHEN month = 'Jan' THEN revenue END) AS Jan_Revenue,
       MAX(CASE WHEN month = 'Feb' THEN revenue END) AS Feb_Revenue,
       MAX(CASE WHEN month = 'Mar' THEN revenue END) AS Mar_Revenue,
       MAX(CASE WHEN month = 'Apr' THEN revenue END) AS Apr_Revenue,
       MAX(CASE WHEN month = 'May' THEN revenue END) AS May_Revenue,
       MAX(CASE WHEN month = 'Jun' THEN revenue END) AS Jun_Revenue,
       MAX(CASE WHEN month = 'Jul' THEN revenue END) AS Jul_Revenue,
       MAX(CASE WHEN month = 'Aug' THEN revenue END) AS Aug_Revenue,
       MAX(CASE WHEN month = 'Sep' THEN revenue END) AS Sep_Revenue,
       MAX(CASE WHEN month = 'Oct' THEN revenue END) AS Oct_Revenue,
       MAX(CASE WHEN month = 'Nov' THEN revenue END) AS Nov_Revenue,
       MAX(CASE WHEN month = 'Dec' THEN revenue END) AS Dec_Revenue
FROM Department
GROUP BY id;

-- Alternative Solution
SELECT * 
FROM Department
PIVOT ( 
  MAX(revenue) for month in ( 
    'Jan' Jan_Revenue,
    'Feb' Feb_Revenue,
    'Mar' Mar_Revenue,
    'Apr' Apr_Revenue,
    'May' May_Revenue,
    'Jun' Jun_Revenue,
    'Jul' Jul_Revenue,
    'Aug' Aug_Revenue,
    'Sep' Sep_Revenue,
    'Oct' Oct_Revenue,
    'Nov' Nov_Revenue,
    'Dec' Dec_Revenue
  )
);
