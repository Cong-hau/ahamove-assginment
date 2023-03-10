/******2) Using the employee table, write a query that 
finds the longest period (in days) during which no employee was hired or fired.******/
WITH hire_fire_dates AS (
	SELECT [start_date] AS hire_fire_date, 'hire' AS event_type
	FROM [Ahamove].[dbo].[hr] 
	UNION
	SELECT [end_date] AS hire_fire_date, 'fire' AS event_type
	FROM [Ahamove].[dbo].[hr]
	WHERE [end_date] IS NOT NULL
),
time_between_events AS(
	SELECT hire_fire_date, event_type, 
		LEAD(hire_fire_date) OVER (ORDER BY hire_fire_date) AS next_event_date ---Use LEAD function to calculate the time between each hire/fire event
	FROM hire_fire_dates
) 
SELECT MAX(DATEDIFF(day, hire_fire_date, next_event_date)) AS longest_time_no_hire_fire
FROM time_between_events