/****** Total booking (both success and cancel book because to focus on analizing applying promo_code behavior)  ******/ --888--
SELECT * 
FROM [Ahamove].[dbo].[Cleaned data.v02.01] 
WHERE [event_type] = 'PlaceOrder_book_btn' -- [event_type] = 'PlaceOrder_book_without_coupon_btn' when apply promo_code is failed, but still order

/****** Total apply promo_code (dont care app promo_code fail or success)  ******/ --292---
SELECT * 
FROM [Ahamove].[dbo].[Cleaned data.v02.01] 
WHERE [event_type] = 'PlaceOrder_book_btn' and [promo_code] is NOT NULL

/****** Total do not apply promo_code  ******/ --596---
SELECT * 
FROM [Ahamove].[dbo].[Cleaned data.v02.01]  
WHERE [event_type] = 'PlaceOrder_book_btn' and [promo_code] is NULL 

/****** Group application promo_code by city  ******/
SELECT count(*) , [city] --Ha Noi and HCM is highest apply promo code, but the cause could be HN and HCM have highest order volumn
FROM [Ahamove].[dbo].[Cleaned data.v02.01] 
WHERE [event_type] = 'PlaceOrder_book_btn' and [promo_code] is NOT NULL
GROUP BY [city]

SELECT  promo_book.[city], 
		promo_book.num_book_with_promo, 
		total_book.num_booking,
		ROUND((CAST(promo_book.num_book_with_promo AS FLOAT)/CAST(total_book.num_booking AS FLOAT))*100.0, 2) as percentage
FROM (
	SELECT count(*) as num_book_with_promo, [city]
	FROM [Ahamove].[dbo].[Cleaned data.v02.01] 
	WHERE [event_type] = 'PlaceOrder_book_btn' and [promo_code] is NOT NULL
	GROUP BY [city]
	) promo_book
JOIN (
	SELECT count(*) as num_booking, [city]
	FROM [Ahamove].[dbo].[Cleaned data.v02.01] 
	WHERE [event_type] = 'PlaceOrder_book_btn'
	GROUP BY [city]
	) total_book
ON promo_book.[city] = total_book.[city]


/****** Use inner join to view all interation of user who order with promo code  ******/
SELECT t1.*
INTO user_order_promo_code
FROM [Ahamove].[dbo].[Cleaned data.v02.01] t1
INNER JOIN (
	SELECT * 
	FROM [Ahamove].[dbo].[Cleaned data.v02.01] 
	WHERE [event_type] = 'PlaceOrder_book_btn' and [promo_code] is NOT NULL
	) t2
ON t1.[user_id] = t2.[user_id]

/****** Use inner join to view all INTERACTION of user who order with out promo code  ******/
SELECT t1.*
INTO user_order_without_promo_code
FROM [Ahamove].[dbo].[Cleaned data.v02.01] t1
INNER JOIN (
	SELECT * 
	FROM [Ahamove].[dbo].[Cleaned data.v02.01]  
	WHERE [event_type] = 'PlaceOrder_book_btn' and [promo_code] is NULL 
	) t2
ON t1.[user_id] = t2.[user_id]

/****** user WHO order both with/ with out promo code  ******/
SELECT *
FROM (
	SELECT *	
	FROM [Ahamove].[dbo].[Cleaned data.v02.01] 
	WHERE [event_type] = 'PlaceOrder_book_btn' and [promo_code] is NOT NULL
	) t1
INNER JOIN (
	SELECT * 
	FROM [Ahamove].[dbo].[Cleaned data.v02.01]  
	WHERE [event_type] = 'PlaceOrder_book_btn' and [promo_code] is NULL 
	) t2
ON t1.[user_id] = t2.[user_id]


/****** Frequent using between user app promo_code and do not  ******/
SELECT 'user_apply_promo' as user_type,
	count(*) as Num_interation, 
	COUNT(DISTINCT user_id) as total_user,
	COUNT(*)/COUNT(DISTINCT user_id) as frequent_using
FROM [Ahamove].[dbo].[user_order_promo_code]
UNION
SELECT 'user_no_apply_promo' as user_type,
	count(*) as Num_interation, 
	COUNT(DISTINCT user_id) as total_user,
	COUNT(*)/COUNT(DISTINCT user_id) as frequent_using
FROM [Ahamove].[dbo].[user_order_without_promo_code]


/****** Cancel ratio : user use promo have cancel ratio higher, means they are more price-sensitive******/
WITH counts AS (
	SELECT COUNT(CASE WHEN event_type = 'PlaceOrder_cancel' then 1 ELSE NULL END) as Num_cancel, 
		COUNT(CASE WHEN event_type = 'PlaceOrder_book_btn' then 1 ELSE NULL END) as Num_book
	FROM [Ahamove].[dbo].[user_order_promo_code]
)
SELECT Num_cancel, Num_book, 
	ROUND(CAST(Num_cancel as FLOAT)/CAST(Num_book as FLOAT)*100.0, 2) as Percentage_cancel
FROM counts

WITH counts AS (
	SELECT COUNT(CASE WHEN event_type = 'PlaceOrder_cancel' then 1 ELSE NULL END) as Num_cancel, 
		COUNT(CASE WHEN event_type = 'PlaceOrder_book_btn' then 1 ELSE NULL END) as Num_book
	FROM [Ahamove].[dbo].[user_order_without_promo_code]
)
SELECT Num_cancel, Num_book, 
	ROUND(CAST(Num_cancel as FLOAT)/CAST(Num_book as FLOAT)*100.0, 2) as Percentage_cancel
FROM counts

/****** Time on app  ******/
WITH time as (
	SELECT user_id, min(event_timestamp) as min, max(event_timestamp) as max,
	DATEDIFF(second, min(event_timestamp), max(event_timestamp)) as long
	FROM [Ahamove].[dbo].[user_order_promo_code]
	GROUP BY user_id
)
SELECT count(user_id) as total_user, sum(long) as sum, sum(long)/count(user_id) as avg_time_on_app
FROM time

WITH time as (
	SELECT user_id, min(event_timestamp) as min, max(event_timestamp) as max,
	DATEDIFF(second, min(event_timestamp), max(event_timestamp)) as long
	FROM [Ahamove].[dbo].[user_order_without_promo_code]
	GROUP BY user_id
)
SELECT count(user_id) as total_user, sum(long) as sum, sum(long)/count(user_id) as avg_time_on_app
FROM time

	




