---total DAU---3351
SELECT COUNT(DISTINCT [user_id]) as DAU, CAST([event_timestamp] as date) as DATE
FROM [Ahamove].[dbo].[Cleaned data.v02.01]
GROUP BY CAST([event_timestamp] as date)

---total DAU group by Service--- Null is 3351 means all users have null service
--Need to determine who is only null service and who is have both.
SELECT COUNT(DISTINCT [user_id]) as DAU, [service], CAST([event_timestamp] as date) as DATE
FROM [Ahamove].[dbo].[Cleaned data.v02.01]
GROUP BY CAST([event_timestamp] as date), [service]

---DAU group by Non Null Service---
SELECT COUNT(DISTINCT [user_id]) as DAU, [service], CAST([event_timestamp] as date) as DATE
FROM [Ahamove].[dbo].[Cleaned data.v02.01]
WHERE [service] IS NOT NULL
GROUP BY CAST([event_timestamp] as date), [service]

SELECT COUNT(DISTINCT [user_id]) as DAU, SUBSTRING([service],5,LEN([service])) AS SERVICE, CAST([event_timestamp] as date) as DATE
FROM [Ahamove].[dbo].[Cleaned data.v02.01]
WHERE [service] IS NOT NULL
GROUP BY CAST([event_timestamp] as date), SUBSTRING([service],5,LEN([service]))

---total DAU Group by non null service--724 if seem user book multiple time service as 1 time.
SELECT COUNT(DISTINCT [user_id]) as DAU, CAST([event_timestamp] as date) as DATE
FROM [Ahamove].[dbo].[Cleaned data.v02.01]
WHERE [service] IS NOT NULL
GROUP BY CAST([event_timestamp] as date)

--Who is nerver get service?
SELECT t1.*
INTO [null_service]
FROM (
	SELECT [user_id], SUBSTRING([service],5,LEN([service])) as SERVICE, CAST([event_timestamp] as date) as DATE
	FROM [Ahamove].[dbo].[Cleaned data.v02.01]
	WHERE [service] IS NULL
	GROUP BY [user_id], CAST([event_timestamp] as date), SUBSTRING([service],5,LEN([service]))
	) AS t1
LEFT JOIN (
	SELECT [user_id], SUBSTRING([service],5,LEN([service])) as SERVICE, CAST([event_timestamp] as date) as DATE
	FROM [Ahamove].[dbo].[Cleaned data.v02.01]
	WHERE [service] IS NOT NULL
	GROUP BY [user_id], CAST([event_timestamp] as date), SUBSTRING([service],5,LEN([service]))
	) t2
ON t1.[user_id] = t2.[user_id]
WHERE t2.[user_id] IS NULL

DROP TABLE [null_service]

--total DAU of actual null city--2627 = 3351 - 724
SELECT COUNT(DISTINCT [user_id]) as DAU, [SERVICE], [DATE]
FROM [null_service]
GROUP BY [DATE], [SERVICE]

/******DAT GROUP BY SERVICE******/
SELECT COUNT(DISTINCT [user_id]) as DAU, SUBSTRING([service],5,LEN([service])) AS SERVICE, CAST([event_timestamp] as date) as DATE
FROM [Ahamove].[dbo].[Cleaned data.v02.01]
WHERE [service] IS NOT NULL
GROUP BY CAST([event_timestamp] as date), SUBSTRING([service],5,LEN([service]))
UNION 
SELECT COUNT(DISTINCT [user_id]) as DAU, COALESCE([SERVICE], 'Did not book'), [DATE]
FROM [null_service]
GROUP BY [DATE], [SERVICE]
ORDER BY DAU DESC	

--Result is 808 booked times + 2627 Users did not book > 3351 unique user a day, means there are many user book multiple time.
--DAU is unique user, would confuse booked times, occur non unique a day.