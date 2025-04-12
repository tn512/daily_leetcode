-- 3087. Find Trending Hashtags

-- Main Solution
WITH temp AS (
    SELECT REGEXP_SUBSTR(tweet, '#\w+') AS hashtag, COUNT(*) AS hashtag_count,
           RANK() OVER (ORDER BY COUNT(*) DESC, REGEXP_SUBSTR(tweet, '#\w+') DESC) AS rnk
    FROM Tweets
    GROUP BY REGEXP_SUBSTR(tweet, '#\w+')
)
SELECT hashtag, hashtag_count
FROM temp
WHERE rnk < 4
ORDER BY hashtag_count DESC, hashtag DESC;

