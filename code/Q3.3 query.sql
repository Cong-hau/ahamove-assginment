/******3) Create a query that returns each employee along with the maximum number of employees who worked for the company during their tenure, 
and the first date on which this maximum number was reached.******/
DROP TABLE IF EXISTS temp_table
SELECT *
INTO temp_table
FROM [Ahamove].[dbo].[hr] AS T1
JOIN (
    SELECT SUM(count) OVER (ORDER BY reached_date) AS max_people, reached_date --Use sum over to find max num of employess, then join original data
    FROM (
        SELECT [start_date] AS reached_date, 1 as count
        FROM [Ahamove].[dbo].[hr]
        UNION ALL
        SELECT [end_date] AS reached_date, -1 as count
        FROM [Ahamove].[dbo].[hr]
        WHERE [end_date] IS NOT NULL
        ) T2
    ) T2 ON T2.reached_date = T1.[start_date] OR T2.reached_date = T1.[end_date]

SELECT DISTINCT a.*
FROM temp_table a
INNER JOIN (
	SELECT id, max(max_people) as max_people
	FROM temp_table
	GROUP BY id
) b
ON a.id = b.id AND a.max_people = b.max_people
ORDER BY start_date

