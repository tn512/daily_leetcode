-- 3140. Consecutive Available Seats II

-- Main Solution
WITH consecutive_seq AS (
    SELECT seat_id, free,
           seat_id - ROW_NUMBER() OVER (ORDER BY seat_id) AS gap
    FROM Cinema
    WHERE free = 1
), rnk_seq AS (
    SELECT gap, COUNT(*) AS consecutive_seats_len,
        MIN(seat_id) AS first_seat_id,
        MAX(seat_id) AS last_seat_id,
        RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
    FROM consecutive_seq
    GROUP BY gap
)
SELECT first_seat_id, last_seat_id, consecutive_seats_len
FROM rnk_seq
WHERE rnk = 1
ORDER BY first_seat_id;

