/******View distinct value in city_id, city******/
SELECT 
	DISTINCT [city_id], [city], count(*)
FROM 
	[Ahamove].[dbo].[Cleaned data.v02.01] 
GROUP BY
	[city_id], [city]
/******View distinct value city******/
SELECT 
	DISTINCT [city], count(*)
FROM 
	[Ahamove].[dbo].[Cleaned data.v02.01] 
GROUP BY
	[city]
/******Update the wrong data******/
UPDATE [Ahamove].[dbo].[Cleaned data.v02.01]
SET [city] = CASE
                --WHEN [city_id] = 'VII' AND [city] is Null THEN 'Nghe An City'
                WHEN [city] = N'Bi√™n H√≤a City' THEN 'Dong Nai City'
                WHEN [city] = 'Binh Loi City' THEN 'Ho Chi Minh City City'
                WHEN [city] = 'Cao Lanh City' THEN 'Dong Thap City'
                WHEN [city] = 'Duc Hoa City' THEN 'Long An City'
               	WHEN [city] = N'ƒê√¥ng Kh√™ City' THEN 'Ho Chi Minh City City'
                WHEN [city] = 'Ha Long City' THEN 'Quang Ninh City'
                WHEN [city] = N'Hu·∫ø City' THEN 'Thua Thien Hue City'
               	WHEN [city] = 'Khu Pho Mot City' THEN 'Ho Chi Minh City City'
               	WHEN [city] = 'Lap Vo City' THEN 'Can Tho City'
               	WHEN [city] = N'Nam ƒê·ªãnh City' THEN 'Hanoi City'
               	WHEN [city] = 'Pleiku City' THEN 'Gia Lai City'
               	WHEN [city] = N'Ph√∫ L·ªôc City' THEN 'Ho Chi Minh City City'
               	WHEN [city] = 'Quan Hai City' THEN 'Ho Chi Minh City City'
               	WHEN [city] = 'Quan Muoi Mot City' THEN 'Ho Chi Minh City City'
               	WHEN [city] = 'Quan Phu Nhuan City' THEN 'Ho Chi Minh City City'
               	WHEN [city] = N'S∆°n La City' THEN 'Son La City'
               	WHEN [city] = 'Tan Tuc City' THEN 'Ho Chi Minh City City'
               	WHEN [city] = N'Thanh H√≥a City' THEN 'Thanh Hoa City'
               	WHEN [city] = 'Thanh Luu City' THEN 'Ha Nam City'
               	WHEN [city] = 'Thu Duc City' THEN 'Ho Chi Minh City City'
               	WHEN [city] = N'V≈©ng T√†u City' THEN 'Ba Ria Vung Tau City'
				--WHEN [city_id] = 'DAD' AND [city] is Null THEN 'Da Nang City'
				--WHEN [city_id] = 'HUI' AND [city] is Null THEN 'Thua Thien Hue City'
				--WHEN [city_id] = 'SGN' AND [city] is Null THEN 'Ho Chi Minh City City'
				--WHEN [city_id] = 'TNG' AND [city] is Null THEN 'Hanoi City'
               	WHEN [city] = 'Bao Loc City' THEN 'Lam Dong City'
               	WHEN [city] = 'Ben Cat City' THEN 'Binh Duong City'
               	WHEN [city] = 'Bien Hoa City' THEN 'Dong Nai City'
               	WHEN [city] = 'Binh Tan City' THEN 'Ho Chi Minh City City'
               	WHEN [city] = 'Ben Cat City' THEN 'Binh Duong City'
               	WHEN [city] = 'Bien Hoa City' THEN 'Dong Nai City'
               	WHEN [city] = N'ƒê·ªëng ƒêa City' THEN 'Hanoi City'
               	WHEN [city] = N'Hai B√†Tr∆∞ng City' THEN 'Hanoi City'
               	WHEN [city] = N'Nh√† B√® City' THEN 'Ho Chi Minh City City'
               	WHEN [city] = 'Phu Tho Hoa City' THEN 'Ho Chi Minh City City'
               	WHEN [city] = 'Quan Bay City' THEN 'Ho Chi Minh City City'
               	WHEN [city] = 'Quan Chin City' THEN 'Ho Chi Minh City City'
               	WHEN [city] = 'Quan Sau City' THEN 'Ho Chi Minh City City'
               	WHEN [city] = N'Th√†nh Ph·ªë Nha Trang City' THEN 'Khanh Hoa City'
               	WHEN [city] = 'Nha Trang City' THEN 'Khanh Hoa City'
               	WHEN [city] = N'Thu·∫≠n An City' THEN 'Binh Duong City'
               	WHEN [city] = N'V≈©ng T√†u City' THEN 'Ba Ria Vung Tau City'
               	WHEN [city] = N'Vƒ©nh Long City' THEN 'Vinh Long City'
               	WHEN [city] = 'Vinh City' THEN 'Nghe An City'
				--WHEN [city_id] = 'BMV' AND [city] is Null THEN 'Dak Lak City'
				--WHEN [city_id] = 'CXR' AND [city] is Null THEN 'Khanh Hoa City'
				--WHEN [city_id] = 'KUL' AND [city] is Null THEN ''
				--WHEN [city_id] = 'TGG' AND [city] is Null THEN 'Dong Nai City'
               	--WHEN [city] = 'XLO' AND [city] is Null THEN ''
               	WHEN [city] = 'Di An City' THEN 'Binh Duong City'
               	WHEN [city] = 'Dinh Quan City' THEN 'Dong Nai City'
               	WHEN [city] = 'Go Vap City' THEN 'Ho Chi Minh City City'
               	WHEN [city] = 'My Binh City' THEN 'Ninh Thuan'
               	WHEN [city] = 'Ninh Giang City' THEN 'Hai Duong City'
				WHEN [city] = N'Qu·∫≠n NƒÉm City' THEN 'Ho Chi Minh City City'
               	WHEN [city] = 'Thuan An City' THEN 'Binh Duong City'
				--WHEN [city_id] = 'HAN' AND [city] is Null THEN 'Ha Noi City'
				--WHEN [city_id] = 'VCA' AND [city] is Null THEN 'Can Tho City'
               	WHEN [city] = 'Dien Ban City' THEN 'Quang Nam City'
               	WHEN [city] = 'Gia Nghia City' THEN 'Dak Nong City'
               	WHEN [city] = N'Qu·∫≠n Hai City' THEN 'Ho Chi Minh City City'
               	WHEN [city] = N'Qu·∫≠n T√¢n Ph√∫ City' THEN 'Ho Chi Minh City City'
               	WHEN [city] = 'Tam Binh City' THEN 'Vinh Long City'
               	WHEN [city] = 'Tan Uyen City' THEN 'Binh Duong City'
               	WHEN [city] = N'Th√†nh Ph·ªë Vƒ©nh Y√™n City' THEN 'Vinh Phuc City'
               	WHEN [city] = N'Th·ªëng Nh·∫•t City' THEN 'Dong Nai City'
               	WHEN [city] = 'Uyen Hung City' THEN 'Binh Duong City'
               	WHEN [city] = N'Y√™n Th√†nh City' THEN 'Nghe An City'
               	WHEN [city] = N'C·∫©m Ph·∫£ City' THEN 'Ha Noi City'
               	WHEN [city] = 'Hanoi City' THEN 'Ha Noi City'
               	WHEN [city] = 'Haiphong City' THEN 'Hai Phong City'
                ELSE [city]
            END
