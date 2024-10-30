-- 585. Investments in 2016

-- Main Solution
WITH temp AS (
    SELECT i.*, CONCAT(i.lat, i.lon) lat_lon
    FROM Insurance i
), filtered AS (
    SELECT DISTINCT t1.*
    FROM temp t1
    LEFT JOIN temp t2
    ON t1.tiv_2015 = t2.tiv_2015
    AND t1.pid != t2.pid
    LEFT JOIN temp t3
    ON t1.lat_lon = t3.lat_lon
    AND t1.pid != t3.pid
    WHERE t2.pid IS NOT NULL
    AND t3.pid IS NULL
)
SELECT SUM(tiv_2016) AS tiv_2016
FROM filtered;

-- Alternative Solution
SELECT SUM(tiv_2016) AS tiv_2016 FROM (
    SELECT pid, tiv_2015, tiv_2016, lat, lon,
       COUNT(*) OVER (PARTITION BY tiv_2015) tiv_count,
       COUNT(*) OVER (PARTITION BY lat, lon) loc_count
    FROM Insurance)
WHERE loc_count = 1
AND tiv_count > 1;
