-- 3103. Find Trending Hashtags II 

-- Main Solution
WITH all_hashtags AS (
    SELECT tweet_id, REGEXP_SUBSTR(tweet, '#\w+', 1, LEVEL) AS hashtag
    FROM Tweets
    CONNECT BY REGEXP_SUBSTR(tweet, '#\w+', 1, LEVEL) IS NOT NULL
    AND PRIOR tweet_id = tweet_id
    AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
), rnk_hashtags AS (
    SELECT hashtag, COUNT(*) AS "count",
           RANK() OVER (ORDER BY COUNT(*) DESC, hashtag DESC) AS rnk
    FROM all_hashtags
    GROUP BY hashtag
)
SELECT hashtag, "count"
FROM rnk_hashtags
WHERE rnk < 4;

