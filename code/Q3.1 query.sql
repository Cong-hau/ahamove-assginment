/****** 1) Create a query to calculate the span (in days) between the hire date of the employee with the longest tenure 
and the hire date of the employee with the shortest tenure who is still currently employed at the company.******/

WITH tenure AS (
	Select * , DATEDIFF(day, start_date, COALESCE(end_date, GETDATE())) AS tenure
	FROM [Ahamove].[dbo].[hr]
)
Select  max(tenure) as the_longest_tenure,
		min(tenure) as the_shortest_tenure
From tenure
---Get employees are being employed---
SELECT *, ISNULL(CONVERT(varchar(10), end_date, 120), 'Yes') as currently_employed
FROM [Ahamove].[dbo].[hr]
WHERE end_date is Null