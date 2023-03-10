---total DAU---3351
SELECT 
	COUNT(DISTINCT [user_id]) as DAU, CAST([event_timestamp] as date) as DATE
FROM 
	[Ahamove].[dbo].[Cleaned data.v02.01]
GROUP BY 
	CAST([event_timestamp] as date)
---total DAU group by City---
SELECT COUNT(DISTINCT [user_id]) as DAU, [city], CAST([event_timestamp] as date) as DATE
FROM [Ahamove].[dbo].[Cleaned data.v02.01]
WHERE [city] IS NOT NULL
GROUP BY CAST([event_timestamp] as date), [city]
---total DAU of non null city--2052
SELECT 
	COUNT(DISTINCT [user_id]) as DAU, CAST([event_timestamp] as date) as DATE
FROM 
	[Ahamove].[dbo].[Cleaned data.v02.01]
WHERE [city] IS NOT NULL
GROUP BY 
	CAST([event_timestamp] as date)
--total DAU of null city--3135 it include user_id have both non-null & null city. Need to eleminate it to find who unknown city
SELECT 
	COUNT(DISTINCT [user_id]) as DAU, [city], CAST([event_timestamp] as date) as DATE
FROM 
	[Ahamove].[dbo].[Cleaned data.v02.01]
WHERE 
	[city] IS NULL
GROUP BY 
	CAST([event_timestamp] as date), [city]
--Who is unknown city?
SELECT t1.*
INTO [null_city]
FROM (
	SELECT [user_id], [city], CAST([event_timestamp] as date) as DATE
	FROM [Ahamove].[dbo].[Cleaned data.v02.01]
	WHERE [city] IS NULL
	GROUP BY [user_id], CAST([event_timestamp] as date), [city]
	) t1
LEFT JOIN (
	SELECT [user_id], [city], CAST([event_timestamp] as date) as DATE
	FROM [Ahamove].[dbo].[Cleaned data.v02.01]
	WHERE [city] IS NOT NULL
	GROUP BY [user_id], CAST([event_timestamp] as date), [city]
	) t2
ON t1.[user_id] = t2.[user_id]
WHERE t2.[user_id] IS NULL

DROP TABLE [null_city]
--total DAU of actual null city--1299 = 3351 - 2052
SELECT COUNT(DISTINCT [user_id]) as DAU, [city], [DATE]
FROM [null_city]
GROUP BY [DATE], [city]

/******DAT GROUP BY CITY******/
SELECT COUNT(DISTINCT [user_id]) as DAU, [city], CAST([event_timestamp] as date) as DATE
FROM [Ahamove].[dbo].[Cleaned data.v02.01]
WHERE [city] IS NOT NULL
GROUP BY CAST([event_timestamp] as date), [city]
UNION 
SELECT COUNT(DISTINCT [user_id]) as DAU, COALESCE([city], 'Unknow'), [DATE]
FROM [null_city]
GROUP BY [DATE], [city]
ORDER BY DAU DESC	