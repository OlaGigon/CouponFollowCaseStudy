WITH t1 as(
select  cast(TRANSACTIONDATE as date) as TransDate, count(distinct ORDERID) as NoOrders
from Orders
group by 1
order by 1 asc
)
SELECT TransDate, SUM(NoOrders) OVER (ORDER BY TransDate asc) as RollingSum
from t1
