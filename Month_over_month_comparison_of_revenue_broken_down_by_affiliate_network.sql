with t1 as (select 
AFFILIATENETWORKNAME
, February
, March

from 
(
select SUM(COMMISSIONAMOUNT)/Count(Distinct Cast(TRANSACTIONDATE as Date)) as MonthlyRev, 
CASE WHEN MONTH(TRANSACTIONDATE) =2 THEN 'February' else 'March' end as MonthName, 
AF.AFFILIATENETWORKNAME
from Orders as O
LEFT JOIN Affiliate_Network as AF on AF.AFFILIATENETWORKID = O.AFFILIATENETWORKID
group by 2, 3
) as t

PIVOT
(
  SUM(MonthlyRev)
  FOR MonthName IN ('February', 'March' )
)
)

select *,
CASE WHEN March>February then 'increase' else 'decrease' end as month_over_month
from t1
