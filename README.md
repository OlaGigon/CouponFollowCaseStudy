# CouponFollowCaseStudy
Data warehouse design and exploration

Suggested design for the solution: 

## 1. Data Storage 

Raw csv files will be stored in Azure Storage Account in Blob Containers. 
For the needs of this case study, I created the Azure Storage Account (inputstorageag) and a landing Container.
Csv files were uploaded manually into landing container. 

For the real business scenario there could be many different ways to upload the files to the storage automatically: e.g.: Function App or Logic App.


## 2. Data Ingestion  

Tool used for data ingestion: Azure Data Factory. 
The process of data ingestion is about copying the csv files into a final tables in a database. 

Main element of the pipeline:

Copy Activity, 
Linked Service to Azure Storage Account, 
Linked Service to Azure SQL Database, 
Dataset for Azure Storage Account (parametrized per csv file), 
Dataset for Database tables (parametrized per csv file).  

In the Copy Activity each CSV file will be mapped and saved in a table created in SQL database.  


## Questions from the case study:  

### How you will schedule the data ingestion (either with a build-in scheduler or a trigger mechanism) 

Storage Event trigger would be used in ADF to trigger the data ingestion process. Whenever a new file arrives in the Storage, the pipeline will be executed and tables in the database will be updated with new values from csv files.  

### How you will implement a trigger to process the arrival of new data in Azure Storage. 

As mentioned in the previous point, I would use the Storage Event trigger in ADF to process the arrival of new files in Azure Storage.  

### How you will host your solution 

I would use Azure architecture. As infrastructure I would use:  

Azure Storage Account gen 2, ADF, Azure SQL database

Remark: 
There are other approaches possible: 
- Snowflake
- Databricks delta tables

## Database diagram
![image](https://github.com/OlaGigon/CouponFollowCaseStudy/assets/44475277/93862292-ce7a-465c-b438-59631d554c32)

In provided csv files PageViews was not complete. It is missing the column that would be used as foreign key to connect with the rest of the tables (e.g. DomainNameID). There is also no candidate for the Primary Key column in this table. (I was thining of Event ID but it is not in format meeting the requirements of Primary Key column). 
