-- 597. Friend Requests I: Overall Acceptance Rate

-- Main Solution
WITH all_requests AS (
    SELECT COUNT(*) AS cnt_all
    FROM (SELECT DISTINCT sender_id, send_to_id
          FROM FriendRequest)
), accepted_requests AS (
    SELECT COUNT(*) AS cnt_accepted
    FROM (SELECT DISTINCT requester_id, accepter_id
          FROM RequestAccepted)
)
SELECT CASE WHEN cnt_all = 0
            THEN 0.0
            ELSE ROUND(cnt_accepted / cnt_all, 2)
       END AS accept_rate
FROM all_requests, accepted_requests;

