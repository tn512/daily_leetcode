-- 1393. Capital Gain/Loss

-- Main Solution
SELECT stock_name, 
       SUM(CASE WHEN operation = 'Sell' THEN price
                ELSE price * -1
           END) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name;

