select ROUND(SUM(COMMISSIONAMOUNT)/SUM(SALEAMOUNT), 5) as CommisionRate 
from Orders
