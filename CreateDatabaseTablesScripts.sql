--Create tables with primary keys defined

CREATE TABLE [dbo].[Advertisers](
	[ADVERTISERID] [int] NOT NULL,
	[ADVERTISERNAME] [nvarchar](max) NOT NULL,
	[AFFILIATENETWORKID] [int] NOT NULL,
PRIMARY KEY ([ADVERTISERID])
)
GO;


CREATE TABLE [dbo].[AffiliateNetwork](
	[AFFILIATENETWORKID] [int] NOT NULL,
	[AFFILIATENETWORKNAME] [nvarchar](max) NOT NULL,
PRIMARY KEY ([AFFILIATENETWORKID])
) 
GO;


CREATE TABLE [dbo].[Clicks](
	[CLICKID] [int] NOT NULL,
	[DOMAINNAME] [nvarchar](max) NOT NULL,
	[OFFER_ID] [int] NOT NULL,
	[COUPONFOLLOW_SESSION_ID] [int] NULL,
	[PARTNERWEBSITEID] [int] NOT NULL,
PRIMARY KEY ([CLICKID])
) 
GO;


CREATE TABLE [dbo].[CouponCodes](
	[COUPONCODEID] [int] NOT NULL,
	[DOMAINNAMEID] [int] NOT NULL,
	[COUPON_CODE] [nvarchar](max) NOT NULL,
	[ISEXCLUSIVE] [bit] NOT NULL,
	[EXPIREDATE] [datetime] NOT NULL,
	[CATCLASTSAVINGON] [datetime] NOT NULL,
PRIMARY KEY ([COUPONCODEID])
)
GO;


CREATE TABLE [dbo].[DomainNames](
	[DOMAINNAMEID] [int] NOT NULL,
	[DOMAINNAME] [nvarchar](max) NOT NULL,
PRIMARY KEY([DOMAINNAMEID])
)
GO;


CREATE TABLE [dbo].[Orders](
	[ORDERID] [int] NOT NULL,
	[CLICKID] [int] NOT NULL,
	[CREATEDON] [datetime] NOT NULL,
	[TRANSACTIONDATE] [datetime] NOT NULL,
	[SALEAMOUNT] [float] NOT NULL,
	[COMMISSIONAMOUNT] [float] NOT NULL,
	[CURRENCY] [nvarchar](max) NOT NULL,
	[AFFILIATENETWORKID] [int] NOT NULL,
	[ADVERTISERID] [int] NOT NULL,
PRIMARY KEY ([ORDERID])
)
GO;


CREATE TABLE [dbo].[PageViews](
	[EVENT_ID] [nvarchar](max) NOT NULL,
	[EMAIL_PROFILE_ID] [nvarchar](max) NOT NULL,
	[CAMPAIGN_ID] [nvarchar](max) NOT NULL,
	[DOMAIN_NAME] [nvarchar](max) NOT NULL,
	[USER_SESSION_ID] [nvarchar](max) NOT NULL,
	[PAGE_VIEW_AT_PT] [datetime] NOT NULL,
	[PAGE_TITLE] [nvarchar](max) NOT NULL,
	[CITY] [nvarchar](max) NOT NULL,
	[COUNTRY] [nvarchar](max) NOT NULL,
	[REGION_NAME] [nvarchar](max) NOT NULL,
	[BROWSER_NAME] [nvarchar](max) NOT NULL,
	[OPERATING_SYSTEM_VERSION] [nvarchar](max) NOT NULL,
	[DEVICE_NAME] [nvarchar](max) NOT NULL
)
GO;
--in PageViews there was no candidate for the primary key


CREATE TABLE [dbo].[PartnerWebsites](
	[PARTNERWEBSITEID] [int] NOT NULL,
	[NAME] [nvarchar](max) NOT NULL,
PRIMARY KEY ([PARTNERWEBSITEID])
)
GO;


CREATE TABLE [dbo].[Promotions](
	[PROMOTIONID] [int] NOT NULL,
	[DOMAINNAMEID] [int] NOT NULL,
	[EXPIREDATE] [datetime] NOT NULL,
PRIMARY KEY([PROMOTIONID])
)
GO;

--Adding Foreign keys to created tables

ALTER TABLE [dbo].[Advertisers]  WITH CHECK ADD FOREIGN KEY([AFFILIATENETWORKID])
REFERENCES [dbo].[AffiliateNetwork] ([AFFILIATENETWORKID])
GO;

ALTER TABLE [dbo].[Clicks]  WITH CHECK ADD FOREIGN KEY([OFFER_ID])
REFERENCES [dbo].[Promotions] ([PROMOTIONID])
GO;

ALTER TABLE [dbo].[Clicks]  WITH CHECK ADD FOREIGN KEY([PARTNERWEBSITEID])
REFERENCES [dbo].[PartnerWebsites] ([PARTNERWEBSITEID])
GO;

ALTER TABLE [dbo].[CouponCodes]  WITH CHECK ADD FOREIGN KEY([DOMAINNAMEID])
REFERENCES [dbo].[DomainNames] ([DOMAINNAMEID])
GO;

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([ADVERTISERID])
REFERENCES [dbo].[Advertisers] ([ADVERTISERID])
GO;

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([AFFILIATENETWORKID])
REFERENCES [dbo].[AffiliateNetwork] ([AFFILIATENETWORKID])
GO;

ALTER TABLE [dbo].[Orders]  WITH CHECK ADD FOREIGN KEY([CLICKID])
REFERENCES [dbo].[Clicks] ([CLICKID])
GO;

ALTER TABLE [dbo].[Promotions]  WITH CHECK ADD FOREIGN KEY([DOMAINNAMEID])
REFERENCES [dbo].[DomainNames] ([DOMAINNAMEID])
GO;
