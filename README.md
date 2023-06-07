# CouponFollowCaseStudy
**Data warehouse design and exploration. Suggested design for the solution:**


## 1. Data Storage 

Raw csv files will be stored in Azure Storage Account in Blob Containers. 
For the need of this case study, I created the Azure Storage Account (inputstorageag) and a landing Container.
Csv files were uploaded manually into landing container. 

For the real business scenario there could be many different ways to upload the files to the storage automatically: e.g.: Function App or Logic App.


## 2. Data Ingestion  

Tool used for data ingestion: Azure Data Factory. 
The process of data ingestion is about copying the csv files into final tables in a database. 

Main element of ADF pipeline:

Databricks activity, 
Linked Service to Azure Storage Account, 
Linked Service to Databricks notebook, 
Dataset for Azure Storage Account (parametrized per csv file).  

ADF will be an orchestrator of the flow. Once triggered, the databricks notebook will be executed. Notebook with code can be found in the repo. 


## Questions from the case study:  

### How you will schedule the data ingestion (either with a build-in scheduler or a trigger mechanism) 

Storage Event trigger would be used in ADF to trigger the data ingestion process. Whenever a new file arrives in the Storage, the pipeline will be started and as part of it, Databricks notebook with code will be launched. 

### How you will implement a trigger to process the arrival of new data in Azure Storage. 

As mentioned in the previous point, I would use the Storage Event trigger in ADF to process the arrival of new files in Azure Storage.  

### How you will host your solution 

I would use Azure architecture. As infrastructure I would use:  

Azure Storage Account gen 2, ADF, Azure SQL database, Databricks

The flow and used services are presented on below diagram: 
![image](https://github.com/OlaGigon/CouponFollowCaseStudy/assets/44475277/bdcb682f-abc8-4cb6-ac66-b4791b1da9f8)


**Remark:** 

I. The other approach is to use the Snowflake 
(unfortunately I couldn't set up Snowflake fully as I wasn't able to install the SnowSQL on my computer) 

II. In the approach I assumed we load data only once. In case of business scenario the mechanism of updating the tables should be included as well (whether the data is replaced in the tables, new data is appended, or whether the history of changes is kept - delta tables) 

## Database diagram
![image](https://github.com/OlaGigon/CouponFollowCaseStudy/assets/44475277/93862292-ce7a-465c-b438-59631d554c32)

In provided csv files the PageViews table was not complete. It was missing the column that would be used as foreign key to connect with the rest of the tables (e.g. DomainNameID). There is also no candidate for the Primary Key column in this table. (I was thinking of Event ID but it is not in format meeting the requirements of Primary Key column). That's why PageViews table on the diagram is not linked with the rest of the tables. 

## Description of the files in repo: 

__CouponFollowCaseStudy - notebook with results.ipynb__ - notebook exported from Databricks. Notebook contain: connecting the storage and fetching the csv's, queries with results for provided tasks, connection with database and writing the tables. (The confidential parts of the scripts, like credentials were removed from code) 

__CreateDatabaseTablesScripts.sql__ - scripts with tables definions

__Query1__ to __Query6__ - queries for the exercises. (Included as well in databricks notebooks)
