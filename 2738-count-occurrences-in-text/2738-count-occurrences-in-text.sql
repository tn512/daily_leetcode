-- 2738. Count Occurrences in Text

-- Main Solution
SELECT 'bear' AS word,
       COUNT(CASE WHEN content LIKE '% bear %' THEN file_name END) AS count
FROM Files
UNION
SELECT 'bull' AS word,
       COUNT(CASE WHEN content LIKE '% bull %' THEN file_name END) AS count
FROM Files;

