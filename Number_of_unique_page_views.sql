SELECT COUNT(DISTINCT PV.EVENT_ID) AS UniquePageViews
FROM PageViews AS PV

/* Additional comments: 
My concern here was the methodology of assigning EVENT_IDs. Are there changing after every time a given user refreshes the website? Or are there some time criteria after which there is a new event_id for the same user (30 minutes of inactivity etc.)
*/
