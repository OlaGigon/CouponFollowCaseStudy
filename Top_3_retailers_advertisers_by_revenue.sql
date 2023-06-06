--ranking advertisers by revenue (revenue understood as sum of all commision amount)
WITH t1 AS (
  SELECT o.*, 
  DENSE_RANK() OVER(ORDER BY Revenue DESC) AS ranking
  FROM (SELECT o.*,
        SUM(COMMISSIONAMOUNT) OVER (PARTITION BY ADVERTISERID) AS Revenue
        FROM Orders o) o
)

--choosing top 3 advertisers with their names 
SELECT DISTINCT t1.ADVERTISERID, a.ADVERTISERNAME
FROM t1
LEFT JOIN Advertisers a ON a.ADVERTISERID=t1.ADVERTISERID
WHERE ranking<=3

/*Additional comments to this task: 
1. List of adversisers in incompleted. Not all AdvertiserId's that are in Orders table are present in Advertisers table. 
*/
