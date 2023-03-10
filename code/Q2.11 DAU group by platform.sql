/******View unique platform value******/
SELECT DISTINCT [PLATFORM], count(*)
FROM [Ahamove].[dbo].[Cleaned data.v02.01]
GROUP BY [PLATFORM]
/******DAU group by Platform******/ --3383 > 3351, means there are user use multiple platform 
SELECT COUNT(DISTINCT [user_id]) as DAU, COALESCE([PLATFORM], 'Unknown') AS PLATFORM, CAST([event_timestamp] as date) as DATE
FROM [Ahamove].[dbo].[Cleaned data.v02.01]
GROUP BY CAST([event_timestamp] as date), [PLATFORM]
ORDER BY DAU DESC   
