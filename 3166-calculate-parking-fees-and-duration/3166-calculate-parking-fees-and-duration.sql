-- 3166. Calculate Parking Fees and Duration

-- Main Solution
WITH fee_temp AS (
    SELECT car_id,
           SUM(fee_paid) AS total_fee_paid,
           ROUND(SUM(fee_paid) / (SUM(exit_time - entry_time) * 24), 2) AS avg_hourly_fee
    FROM ParkingTransactions
    GROUP BY car_id
), lot_rnk AS (
    SELECT car_id, lot_id,
           RANK() OVER (PARTITION BY car_id 
                        ORDER BY SUM(exit_time - entry_time) DESC) AS rnk
    FROM ParkingTransactions
    GROUP BY car_id, lot_id
)
SELECT f.*, l.lot_id AS most_time_lot
FROM fee_temp f
JOIN lot_rnk l
ON f.car_id = l.car_id
AND l.rnk = 1
ORDER BY f.car_id;

