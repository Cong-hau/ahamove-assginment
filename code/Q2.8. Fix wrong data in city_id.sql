/******Create copied data set to update wrong date******/
SELECT *
INTO [Ahamove].[dbo].[Cleaned data.v02.01]
FROM [Ahamove].[dbo].[Cleaned data.v02.00]
/******View distinct value in city_id******/
SELECT [city_id]
FROM [Ahamove].[dbo].[Cleaned data.v02.01]
GROUP BY [city_id]
/******Update the wrong data******/
UPDATE [Ahamove].[dbo].[Cleaned data.v02.01]
SET [city_id] = CASE
                WHEN [city_id] = '[DAD]' THEN 'DAD'
                WHEN [city_id] = '[HAN,SGN]' THEN 'HAN'
                WHEN [city_id] = '[HAN]' THEN 'HAN'
                WHEN [city_id] = '[SGN,HAN]' THEN 'SGN'
                WHEN [city_id] = '[SGN]' THEN 'SGN'
                WHEN [city_id] = '[VCA]' THEN 'VCA'
                WHEN [city_id] = '[VII]' THEN 'VII'
                WHEN [city_id] = '[Ljava.lang.String;@7144a64' THEN Null
                WHEN [city_id] = '[Ljava.lang.String;@c68c2d0' THEN Null
                WHEN [city_id] = '[Ljava.lang.String;@db63102' THEN Null
                WHEN [city_id] = '[Ljava.lang.String;@fc0f8f5' THEN Null
                ELSE [city_id]
            END
