-- 1322. Ads Performance

-- Main Solution
WITH temp AS (
    SELECT ad_id, 
           COUNT(CASE WHEN action = 'Clicked' THEN user_id END) AS total_click,
           COUNT(CASE WHEN action = 'Viewed' THEN user_id END) AS total_view
    FROM Ads
    GROUP BY ad_id
)
SELECT ad_id,
       CASE WHEN total_click + total_view = 0 THEN 0
            ELSE ROUND((total_click / (total_click + total_view)) * 100, 2)
       END AS ctr
FROM temp
ORDER BY ctr DESC, ad_id ASC;

