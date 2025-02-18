-- 2112. The Airport With the Most Traffic

-- Main Solution
WITH all_flights_cnt AS (
    SELECT departure_airport AS airport_id, flights_count
    FROM Flights
    UNION ALL
    SELECT arrival_airport, flights_count
    FROM Flights
), rank_flights AS (
    SELECT airport_id,
           RANK() OVER (ORDER BY SUM(flights_count) DESC) AS rnk
    FROM all_flights_cnt
    GROUP BY airport_id
)
SELECT airport_id
FROM rank_flights
WHERE rnk = 1;

