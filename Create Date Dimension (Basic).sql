USE [master]
GO


DECLARE @Start_Date   DATE = '2000-01-01'
DECLARE @End_Date     DATE = '2050-12-31'


SELECT CONVERT(INT, CONVERT(VARCHAR(8), [Date].[Date], 112))                                        AS [Date_ID]

      ,CONVERT(DATE, [Date].[Date])                                                                 AS [Date]

      ,CONVERT(SMALLINT, DATEPART(MONTH, [Date].[Date]))                                            AS [Month_ID]
      ,LEFT(DATENAME(MONTH, [Date].[Date]), 3)                                                      AS [Month]

      ,CONVERT(INT, CONVERT(VARCHAR(6), [Date].[Date], 112))                                        AS [Year_Month_ID]
      ,CONCAT(LEFT(DATENAME(MONTH, [Date].[Date]), 3), ' ''', RIGHT(YEAR([Date].[Date]), 2))        AS [Year_Month]

      ,CONVERT(INT, YEAR([Date].[Date]))                                                            AS [Year]

  FROM 

       (

         SELECT DATEADD(DAY, [Day].[Day] - 1, @Start_Date) AS [Date]
           FROM 
         
                (
                  SELECT TOP (DATEDIFF(DAY, @Start_Date, DATEADD(DAY, 1, @End_Date))) ROW_NUMBER() OVER (ORDER BY [A].[object_id]) AS [Day]
                    FROM [sys].[all_objects] AS [A]
         
                         CROSS JOIN [sys].[all_objects] AS [B]
         
                   ORDER BY [A].[object_id]
         
                ) AS [Day]

       ) AS [Date];
GO