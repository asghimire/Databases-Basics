-- Built in functions 
-- 6
SELECT [TownID]
      ,[Name]
  FROM [SoftUni].[dbo].[Towns]
 WHERE [Name] LIKE 'M%'
    OR [Name] LIKE 'K%'
    OR [Name] LIKE 'B%'
    OR [Name] LIKE 'E%'

SELECT [TownID]
      ,[Name]
  FROM [SoftUni].[dbo].[Towns]
 WHERE [Name] LIKE '[MKBE]%'
 ORDER BY [Name] ASC

 -- Built in functions 10
SELECT CountryName, IsoCode
  FROM [dbo].[Countries]
 WHERE LEN(CountryName) - LEN(REPLACE(CountryName, 'a','')) >= 3
 --CountryName LIKE '%a%a%a%'
 ORDER BY IsoCode ASC


 --12
SELECT TOP 50 Name, 
       FORMAT(Start, 'yyyy-MM-dd') AS NewDate,
	   CONVERT(DATE, Start, 120) AS NewDate2
  FROM Games
 WHERE YEAR(Start) IN (2011, 2012)
 ORDER BY Start, Name

 -- Data Aggregations
 --09
 SELECT CASE
			WHEN Age <= 10 THEN '[0-10]'
			WHEN Age <= 20 THEN '[11-20]'
			WHEN Age <= 30 THEN '[21-30]'
			WHEN Age <= 40 THEN '[31-40]'
			WHEN Age <= 50 THEN '[41-50]'
			WHEN Age <= 60 THEN '[51-60]'
			ELSE '[61+]'
		END AS AgeGroup,
        COUNT(*) AS WizzardCount
   FROM [dbo].[WizzardDeposits]
  GROUP BY CASE
			WHEN Age <= 10 THEN '[0-10]'
			WHEN Age <= 20 THEN '[11-20]'
			WHEN Age <= 30 THEN '[21-30]'
			WHEN Age <= 40 THEN '[31-40]'
			WHEN Age <= 50 THEN '[41-50]'
			WHEN Age <= 60 THEN '[51-60]'
			ELSE '[61+]'
		END
-- 4

 SELECT MIN(AverageMagicWandSize) MinAverageMagicWandSize 
   FROM
(SELECT DepositGroup, AVG(MagicWandSize) AS AverageMagicWandSize
   FROM [dbo].[WizzardDeposits]
  GROUP BY DepositGroup) AS av
  
  SELECT DepositGroup FROM
  (SELECT DepositGroup, AVG(MagicWandSize) AS AverageMagicWandSize
   FROM [dbo].[WizzardDeposits]
  GROUP BY DepositGroup) as avgm
  WHERE AverageMagicWandSize = ( SELECT MIN(AverageMagicWandSize) MinAverageMagicWandSize 
								   FROM
								(SELECT DepositGroup, AVG(MagicWandSize) AS AverageMagicWandSize
								   FROM [dbo].[WizzardDeposits]
								  GROUP BY DepositGroup) AS av)

-- 17

USE SoftUni
GO

 SELECT DISTINCT sal.DepartmentId, sal.Salary FROM
(SELECT e.DepartmentId, e.Salary, DENSE_RANK() OVER (PARTITION BY e.DepartmentID ORDER BY e.Salary DESC) AS SalaryRank
   FROM [dbo].[Employees] AS e) AS sal
  WHERE sal.SalaryRank = 3


CREATE TABLE Salaries(
Salary DECIMAL(10,2)
)

INSERT INTO Salaries(Salary)
VALUES (50000), (10000), (70000)

SELECT s.Salary, DENSE_RANK() OVER (ORDER BY s.Salary DESC)
  FROM Salaries AS s