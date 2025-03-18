-- 3052. Maximize Items

-- Main Solution
WITH combined_square AS (
    SELECT item_type, SUM(square_footage) AS com_square, COUNT(*) AS total_items
    FROM Inventory
    GROUP BY item_type
), prime_items AS (
    SELECT item_type, com_square, FLOOR(500000 / com_square) * total_items AS item_count,
           500000 - com_square * FLOOR(500000 / com_square) AS remaining
    FROM combined_square
    WHERE item_type = 'prime_eligible'
)
SELECT item_type, item_count
FROM prime_items
UNION ALL
SELECT item_type, FLOOR((SELECT remaining FROM prime_items) / com_square) * total_items AS item_count
FROM combined_square
WHERE item_type = 'not_prime';

