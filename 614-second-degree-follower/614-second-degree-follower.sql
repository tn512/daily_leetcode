-- 614. Second Degree Follower

-- Main Solution
SELECT followee AS follower, COUNT(1) AS num
FROM Follow
WHERE followee IN (SELECT DISTINCT follower FROM Follow)
GROUP BY followee
ORDER BY followee;

