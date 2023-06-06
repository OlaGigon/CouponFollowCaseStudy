--first calculate the number of orders per day
WITH t1 AS(
SELECT  CAST(TRANSACTIONDATE AS date) AS TransDate, COUNT(DISTINCT ORDERID) AS NoOrders
FROM Orders
GROUP BY 1
ORDER BY 1 ASC
)
--calcualting rolling sum 
SELECT TransDate, NoOrders, SUM(NoOrders) OVER (ORDER BY TransDate ASC) AS RollingSum
FROM t1
