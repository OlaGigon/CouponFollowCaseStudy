WITH t1 AS (SELECT 
AFFILIATENETWORKNAME
, February
, March
FROM 
(
  --calculating daily average nnumber of orders per month for all of affiliate networks
SELECT SUM(COMMISSIONAMOUNT)/COUNT(DISTINCT CAST(TRANSACTIONDATE AS Date)) AS MonthlyRev, 
CASE WHEN MONTH(TRANSACTIONDATE) =2 THEN 'February' ELSE 'March' END AS MonthName, 
AF.AFFILIATENETWORKNAME
FROM Orders AS O
LEFT JOIN Affiliate_Network AS AF ON AF.AFFILIATENETWORKID = O.AFFILIATENETWORKID
GROUP BY 2, 3
) AS t
--creating a pivot table to compare between months
PIVOT
(
  SUM(MonthlyRev)
  FOR MonthName IN ('February', 'March' )
)
)
SELECT *,
CASE WHEN March>February THEN 'increase' ELSE 'decrease' END AS month_over_month
FROM t1

/* additional comments: 
1. Data that you provided contains different number of days for February and March
(less for March). In order to be able to compare between those two months I calculated daily averages for each month. Otherwise we'd probably see a decreasing trend in March for most of the afiliate networks. 
2. Taking the above mentioned approach doesn't have to be 100% correct as we need to make sure that we take seasonality factors into consideration. I assume that as a web platform you generate more traffic (which results in higher number of orders) during weekends so it should be taken into consideration in month-over-month comparison. In this case and data that you sent we should make sure that there is a same share of weekends in both of the analyzed months.
*/
