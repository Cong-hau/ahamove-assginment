/******Script for count all row******/
SELECT 
	count(*)
FROM 
	[Ahamove].[dbo].[Cleaned data.v02.00]
/******Script for count unique rows both timestamp and user id******/
SELECT 
	count(*) 
FROM 
	(Select distinct [event_timestamp], [user_id]
	FROM [Ahamove].[dbo].[Cleaned data.v02.00]) as InternalQuery
/******View duplicates record******/
SELECT 
	[event_timestamp], [user_id], COUNT(*) as Num_Duplicates
FROM 
	[Ahamove].[dbo].[Cleaned data.v02.00]
GROUP BY 
	[event_timestamp], [user_id]
HAVING 
	COUNT(*) > 1
/******Delete duplicates record******/
DELETE Dup
FROM
	(
	SELECT *
	, DupRank = ROW_NUMBER() OVER (
				  PARTITION BY [event_timestamp], [user_id]
				  ORDER BY (SELECT NULL)
				)
	FROM [Ahamove].[dbo].[Cleaned data.v02.00]
	) AS Dup
WHERE DupRank > 1

