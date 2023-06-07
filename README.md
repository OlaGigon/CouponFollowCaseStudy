# CouponFollowCaseStudy
**Data warehouse design and exploration. Suggested design for the solution**


## 1. Data Storage 

Raw csv files will be stored in Azure Storage Account in Blob Containers. 
For the need of this case study, I created the Azure Storage Account (inputstorageag) and a landing container were the csv files were uploaded manually. 

For the real business scenario there could be many different ways to upload the files to the storage automatically: e.g.: Function App or Logic App.


## 2. Data Ingestion  

Tool used for data ingestion: Azure Data Factory. 
The process of data ingestion is about copying the csv files into final tables in a database. 

Main elements of ADF pipeline:

- Databricks activity, 
- Linked Service to Azure Storage Account, 
- Linked Service to Databricks notebook, 
- Dataset for Azure Storage Account (parametrized per csv file).  

ADF will be an orchestrator of the flow. Once triggered, the databricks notebook will be executed. Notebook with code can be found in this repo. 


## Questions from the case study:  

### How you will schedule the data ingestion (either with a build-in scheduler or a trigger mechanism) 

Storage Event trigger would be used in ADF to trigger the data ingestion process. Whenever a new file arrives in the Storage, the pipeline will be started and as part of it, Databricks notebook with code will be launched. 

### How you will implement a trigger to process the arrival of new data in Azure Storage. 

As mentioned in the previous point, I would use the Storage Event trigger in ADF to process the arrival of new files in Azure Storage.  

### How you will host your solution 

I would use Azure architecture. As infrastructure I would use:  
- Azure Storage Account gen 2, 
- ADF, 
- Azure SQL database, 
- Databricks
- Key vault to store the secrets

The flow and used services are presented on below diagram: 
![image](https://github.com/OlaGigon/CouponFollowCaseStudy/assets/44475277/bdcb682f-abc8-4cb6-ac66-b4791b1da9f8)


**Remark:** 

I. The other approach is to use the Snowflake 
(unfortunately I couldn't set up Snowflake fully as I wasn't able to install the SnowSQL on my computer).
The architecture diagram is presented below: 
![image](https://github.com/OlaGigon/CouponFollowCaseStudy/assets/44475277/e39733de-8430-4a31-b212-2e4df98794f4)

With Snowflake the ingestion of files from Azure Storage would be managed by Snowpipe. 
To automate loading of new files, Azure Event Grid will be used. Whenever new file arrives to the Blob Storage, an event message will be created and transferred to Snowflake and Snowpipe will be triggered. Snowpipe will be parametrized to save the files content into dedicated tables in Snowflake DataWarehouse.   

II. For this case study I assumed we load data only once. In case of real business scenario the mechanism of updating the tables with new data should be included as well in the scripts (Key aspect is if the data in tables should be replaced or appended, whether the data of update should be tracked in tables).

## Database diagram
Diagram was prepared in SSMS which I used to connect to the Azure SQL Database that I created. 
![image](https://github.com/OlaGigon/CouponFollowCaseStudy/assets/44475277/93862292-ce7a-465c-b438-59631d554c32)

In provided csv files the PageViews table was not complete. It was missing the column that would be used as foreign key to connect with the rest of the tables (e.g. DomainNameID). There is also no candidate for the Primary Key column in this table. (I was thinking of Event ID but it is not in format meeting the requirements of Primary Key column). That's why PageViews table on the diagram is not linked with the rest of the tables. 

## Description of the files in repo: 

__CouponFollowCaseStudy - notebook with results.ipynb__ - notebook exported from Databricks. Notebook contains: 
- connection to the storage and fetch of the csv files, 
- queries along with their results for required tasks, 
- connection with database and upload of the data to the SQL tables. 

The confidential parts of the scripts, like credentials, connection strings were removed from the code.

__CreateDatabaseTablesScripts.sql__ - scripts with tables definions

__Query1__ to __Query6__ - queries for the exercises. (Included also in the Databricks notebooks).
