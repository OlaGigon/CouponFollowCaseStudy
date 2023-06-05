with t1 as (
  select o.*, 
  dense_rank() over(order by Revenue desc) as ranking
  from (select o.*,
        sum(COMMISSIONAMOUNT) over (partition by ADVERTISERID) as Revenue
        from Orders o) o
)

select distinct t1.ADVERTISERID, a.ADVERTISERNAME
from t1
left join Advertisers a on a.ADVERTISERID=t1.ADVERTISERID
where ranking<=3
