-- 2238. Number of Times a Driver Was a Passenger

-- Main Solution
SELECT dr.driver_id, COUNT(DISTINCT pa.ride_id) AS cnt
FROM Rides dr
LEFT JOIN Rides pa
ON dr.driver_id = pa.passenger_id
GROUP BY dr.driver_id;

