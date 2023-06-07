SELECT ROUND(SUM(COMMISSIONAMOUNT)/SUM(SALEAMOUNT), 5) AS CommisionRate 
FROM Orders

/* Additional comments: 
1. I was thinking of using AVG(COMMISSIONAMOUNT/SALEAMOUNT) but in this case I wouldn't take weights of Sale Amount into consideration and as a consequence I wouldn't differentiate between them.
*/
