/****** 1) Create a query to calculate the span (in days) between the hire date of the employee with the longest tenure 
and the hire date of the employee with the shortest tenure who is still currently employed at the company.******/
WITH tenure AS (
	Select * , DATEDIFF(day, start_date, COALESCE(end_date, GETDATE())) AS tenure
	FROM [Ahamove].[dbo].[hr]
	Where end_date is Null
)
Select  max(tenure) as the_longest_tenure,
		min(tenure) as the_shortest_tenure
From tenure
