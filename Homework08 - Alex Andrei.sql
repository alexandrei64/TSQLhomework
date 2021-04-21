/*
Database Development SIIT
Homework 08 - Using Table Expressions
Created by Alex Andrei
*/

-- HANDS ON LAB

-- Use the AdventureWorks2012 database.

USE AdventureWorks2012;
GO

/*
1. Display the total number of sales orders per year for each sales representative 
in the Adventure Works database. 
Table: Sales.SalesOrderHeader
*/

SELECT DISTINCT(deriv.SalesPersonID), OrderYr, TotalOrders
FROM
	(
	SELECT 
		YEAR(OrderDate) as OrderYr, 
		SalesPersonID, 
		count(SalesOrderID) OVER (PARTITION BY SalesPersonID) AS TotalOrders
	FROM Sales.SalesOrderHeader
	) AS deriv
ORDER BY deriv.SalesPersonID, deriv.OrderYr;
GO

/*
2. Display the average number of sales orders for all years for the sales representatives
in the Adventure Works database. 
Table: Sales.SalesOrderHeader
*/

SELECT 
	DISTINCT SalesPersonID, 
	AVG(SalesOrderID) OVER (PARTITION BY SalesPersonID) AS AVG_Orders
FROM Sales.SalesOrderHeader
ORDER BY SalesPersonID;
GO

/*
3. Create a view named Person.IndividualsWithEmail that will display the name and the 
email of a person.
Tables: Person.Person, Person.EmailAddress
Columns: BusinessEntityID, Title, FirstName, MiddleName, LastName, EmailAddress
*/

DROP VIEW IF EXISTS Person.IndividualsWithEmail;
GO

CREATE VIEW Person.IndividualsWithEmail
AS
SELECT p.BusinessEntityID, p.Title, p.FirstName, p.MiddleName, p.LastName, ea.EmailAddress
FROM Person.Person p
JOIN Person.EmailAddress ea 
ON p.BusinessEntityID = ea.BusinessEntityID;
GO

SELECT * FROM Person.IndividualsWithEmail;
GO

/*
4. Create a table valued function named Sales.GetLastOrdersForCustomer that receives as
arguments a CustomerID and a number of orders and returns the last orders for that customer.
Table: Sales.SalesOrderHeader
Columns Returned:  SalesOrderID, OrderDate, PurchaseOrderNumber
Arguments: @CustomerID int, @NumberOfOrders int
*/

DROP FUNCTION IF EXISTS Sales.GetLastOrdersForCustomer;
GO

CREATE FUNCTION Sales.GetLastOrdersForCustomer (@CustomerID INT, @NumberOfOrders INT)
RETURNS TABLE
AS 
RETURN(
SELECT
	TOP (@NumberOfOrders) SalesOrderID, 
	OrderDate, 
	PurchaseOrderNumber
FROM Sales.SalesOrderHeader soh
WHERE soh.CustomerID = @CustomerID
ORDER BY soh.OrderDate
);
GO

SELECT * FROM Sales.GetLastOrdersForCustomer(29811,10)
GO

/*
5. Create a view named HumanResources.EmployeeHireDate that will display the name and the date 
when an employee was hired.
Tables: Person.Person, HumanResources.Employee
Columns: FirstName, LastName, HireDate
*/

DROP VIEW IF EXISTS HumanResources.EmployeeHireDate;
GO

CREATE VIEW HumanResources.EmployeeHireDate
AS
SELECT p.FirstName, p.LastName, e.HireDate
FROM Person.Person p
JOIN HumanResources.Employee e
ON p.BusinessEntityID = e.BusinessEntityID;
GO

SELECT * FROM HumanResources.EmployeeHireDate;
GO

-- END OF HOMEWORK ---------------------------

PRINT 'HOMEWORK COMPLETE';
GO