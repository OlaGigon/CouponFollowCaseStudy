--calculating number of page views per domain
WITH t1 AS(
SELECT DOMAIN_NAME, COUNT(DISTINCT EVENT_ID) AS PageView
FROM PageViews
GROUP BY 1),

--ranking domains by number of page views
t2 AS(
SELECT DOMAIN_NAME, RANK() OVER( ORDER BY PageView DESC) AS ranking
FROM t1)

--identifying top 3 domains
SELECT * FROM t2 WHERE ranking <=3

/*Additional comments to this task: 
1. The description of task states that I should identify top 3 advertisers by number of page views. I wasn't sure whether domain is the same thing as advertiser (though they have similar and matching names)
but otherwise it is impossible to perform this task (it is impossible to link PageViews table with Advertisers table due to missing key in Orders table - DomainNameID)
2. Even if there was a DomainNameID key in the Orders table I think that we still wouldn't get correct data as we would end up counting ONLY these Page Views that led to Orders and I'm sure you loose a part of users at each stage of the funnel (PageView -> Click -> Order). In order to get a AdvertiserName there should be a foreign key (advertiserID) in the PageViews table.
*/
