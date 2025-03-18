-- 2989. Class Performance

-- Main Solution
SELECT DISTINCT FIRST_VALUE(assignment1 + assignment2 + assignment3) 
        OVER (ORDER BY assignment1 + assignment2 + assignment3 DESC)
       - FIRST_VALUE(assignment1 + assignment2 + assignment3) 
          OVER (ORDER BY assignment1 + assignment2 + assignment3) AS difference_in_score
FROM Scores;

-- Alternative Solution
SELECT MAX(assignment1 + assignment2 + assignment3)
       - MIN(assignment1 + assignment2 + assignment3) AS difference_in_score
FROM Scores;
