-- 3328. Find Cities in Each State II

-- Main Solution
SELECT state,
       LISTAGG(city, ', ') WITHIN GROUP (ORDER BY city) AS cities,
       COUNT(CASE WHEN SUBSTR(state, 1, 1) = SUBSTR(city, 1, 1)
                  THEN city 
             END) AS matching_letter_count
FROM cities
GROUP BY state
HAVING COUNT(city) > 2
AND COUNT(CASE WHEN SUBSTR(state, 1, 1) = SUBSTR(city, 1, 1) THEN city END) > 0
ORDER BY matching_letter_count DESC, state;

