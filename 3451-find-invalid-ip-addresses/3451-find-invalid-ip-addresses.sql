-- 3451. Find Invalid IP Addresses

-- Main Solution
WITH cnt_ip AS (
    SELECT ip, COUNT(*) AS cnt
    FROM logs
    GROUP BY ip
), single_octet AS (
    SELECT ip, cnt, REGEXP_SUBSTR(ip, '[^.]+', 1, LEVEL) AS octet
    FROM cnt_ip
    CONNECT BY PRIOR ip = ip
    AND REGEXP_SUBSTR(ip, '[^.]+', 1, LEVEL) IS NOT NULL
    AND PRIOR DBMS_RANDOM.VALUE IS NOT NULL
), temp AS (
    SELECT ip, cnt, octet, COUNT(*) OVER (PARTITION BY ip) AS cnt_octet
    FROM single_octet
)
SELECT DISTINCT ip, cnt AS invalid_count
FROM temp
WHERE TO_NUMBER(octet) > 255
OR cnt_octet <> 4
OR octet LIKE '0%'
ORDER BY invalid_count DESC, ip DESC;

