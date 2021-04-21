/*
Database Development SIIT
Module 5 Exercises
Created by Alex Andrei
*/


--We will use the AdventureWorks2012  or the TSQL database.

USE [TSQL];
GO

/*
1: Write a SELECT statement to return columns that contain:
The current date and time. Use the alias currentdatetime.
Just the current date. Use the alias currentdate.
Just the current time. Use the alias currenttime.
Just the current year. Use the alias currentyear.
Just the current month number. Use the alias currentmonth.
Just the current day of month number. Use the alias currentday.
Just the current week number in the year. Use the alias currentweeknumber.
The name of the current month based on the currentdatetime column. Use the alias currentmonthname.
*/

SELECT 
SYSDATETIME () AS 'currentdatetime',
CONVERT(date, SYSDATETIME ()) as 'currentdate',
CONVERT(time, SYSDATETIME ()) as 'currenttime',
DATEPART(year, SYSDATETIME ()) as 'currentyear',
DATEPART(month, SYSDATETIME ()) as 'currentmonth',
DATEPART(day, SYSDATETIME ()) as 'currentday',
DATEPART(wk, SYSDATETIME ()) as 'currentweeknumber',
DATENAME(month, SYSDATETIME ()) as 'currentmonthname'
GO

/*
2: Write December 11, 2015 as a column with a data type of date. Use the different possibilities inside
the T-SQL language (cast, convert, specific function, and so on) and use the alias somedate.
*/

SELECT CAST('2015-12-11' AS DATE) AS [When did John "Hot Rod" Williams die?]

/*
3: Write a SELECT statement to return columns that contain:
A date and time value that is three months from the current date and time. Use the alias threemonths.
The number of days between the current date and the first column (threemonths). Use the alias diffdays.
The number of weeks between April 4, 1992, and September 16, 2011. Use the alias diffweeks.
The first day in the current month, based on the current date and time. Use the alias firstday.
*/

--FROM Colleague:

	SELECT DATEADD(MONTH,-3,GETDATE()) AS THREEMONTHS
	SELECT DATEDIFF(DAY,DATEADD(MONTH,-3,GETDATE()),GETDATE()) AS DiffDays
	SELECT DATEDIFF(WEEK,CONVERT(DATE,'1992-04-04'),CONVERT(DATE,'2011-09-16')) AS DiffWeeks
	SELECT CAST(DATEADD(DAY,-DATEPART(DAY,GETDATE()-1),GETDATE()) AS DATE) AS FirstDay

/*
4: Write a SELECT statement with these columns:
Current date and time.
First date of the current month.
Last date of the current month.
*/

SELECT
SYSDATETIME () AS 'currentdatetime',
DATEFROMPARTS (YEAR(SYSDATETIME()), MONTH(SYSDATETIME()), 1) AS 'SOM',
EOMONTH (sysdatetime()) AS 'EOM'
GO

/*
5: Write a SELECT statement against the Sales.Orders table and retrieve the orderid, custid, and orderdate columns.
Filter the results to include only orders placed in the last five days of the order month. 
*/

SELECT orderid, custid, orderdate
FROM Sales.Orders
WHERE orderdate 
    BETWEEN DATEADD (DAY, -4, EOMONTH(orderdate))
    AND EOMONTH (orderdate);
GO

/*
6: Write a SELECT statement against the Sales.Orders and Sales.OrderDetails tables and retrieve all the distinct values 
for the productid column. Filter the results to include only orders placed in the first 10 weeks of the year 2007.
*/

SELECT *
FROM Sales.OrderDetails sod
JOIN Sales.Orders so
ON sod.orderid = so.orderid
WHERE DATEPART(wk,orderdate)<=10;
GO

/*
7: Write a SELECT statement against the Sales.Customers table and retrieve the contactname and city columns. 
Concatenate both columns so that the new column looks like this: Allen, Michael (city: Berlin)
*/

SELECT
CONCAT (contactname, ' (city: ', city,')')
FROM Sales.Customers;
GO

/*
8: Write a SELECT statement to retrieve the contactname and contacttitle columns from the Sales.Customers table.
Return only rows where the first character in the contact name is ‘A’ through ‘G’.
*/

SELECT
    contactname,
    contacttitle
FROM Sales.Customers
WHERE contactname LIKE '[A-G]%';
GO

/*
9: In the TSQL database. Write a SELECT statement to retrieve the custid column from the Sales.Customers table.
Add a new calculated column to create a string representation of the custid as a fixed-width (six characters)
customer code, prefixed with the letter C and leading zeros. For example, the custid value 1 should look like C00001.
*/

SELECT 
DISTINCT ('C' + RIGHT('00000' + CAST(custid AS VARCHAR(5)), 5))
AS CustID
FROM Sales.CustOrders 
ORDER BY CustID ASC;
GO

--Teacher's way
SELECT 'C' + RIGHT(CAST(10000+custid as char(6)),5)
FROM Sales.Customers;
GO

--check
select custid from Sales.Customers
order by custid asc;

-- END MODULE 5 EXERCISES --------------------------------------------------------------------------------------------------