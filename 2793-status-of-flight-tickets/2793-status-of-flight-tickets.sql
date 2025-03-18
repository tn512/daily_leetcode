-- 2793. Status of Flight Tickets

-- Main Solution
SELECT p.passenger_id,
        CASE WHEN ROW_NUMBER() OVER (PARTITION BY p.flight_id ORDER BY p.booking_time) > f.capacity
                THEN 'Waitlist'
            ELSE 'Confirmed'
        END AS "Status"
FROM Passengers p
JOIN Flights f
ON f.flight_id = p.flight_id
ORDER BY passenger_id;

