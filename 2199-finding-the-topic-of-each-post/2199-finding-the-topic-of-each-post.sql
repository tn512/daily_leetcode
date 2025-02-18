-- 2199. Finding the Topic of Each Post

-- Main Solution
WITH base AS (
    SELECT *
    FROM (SELECT topic_id, ' ' || LOWER(word) || ' ' AS word FROM Keywords)
    CROSS JOIN (SELECT post_id, ' ' || LOWER(content) || ' ' AS content FROM Posts)
), temp AS (
    SELECT DISTINCT post_id, topic_id
    FROM base
    WHERE INSTR(content, word) > 0
)
SELECT p.post_id, NVL(LISTAGG(t.topic_id, ',') WITHIN GROUP (ORDER BY t.topic_id), 'Ambiguous!') AS topic
FROM Posts p
LEFT JOIN temp t
ON t.post_id = p.post_id
GROUP BY p.post_id;

-- Alternative Solution
WITH temp AS (
    SELECT DISTINCT p.post_id, k.topic_id
    FROM Posts p
    LEFT JOIN Keywords k
    ON ' ' || LOWER(p.content) || ' ' LIKE '% ' || LOWER(k.word) || ' %'
)
SELECT post_id, 
       NVL(LISTAGG(topic_id, ',') WITHIN GROUP (ORDER BY topic_id)
           , 'Ambiguous!') AS topic
FROM temp
GROUP BY post_id;
