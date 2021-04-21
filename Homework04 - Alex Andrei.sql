/*
Database Development SIIT
Module 4 Exercises
Created by Alex Andrei
*/


USE AdventureWorks2012;
GO

/*
1: Write a SELECT statement that will return rows from the from the Production.Product table.
You should return the columns ProductID and Name and only the rows for which the value of the Name column starts with ‘Lock Washer’.​
The rows should be ordered using the ProductID column.
*/

SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE 'Lock Washer%'
ORDER BY ProductID;
GO

/*
2: Write a SELECT statement to return the ProductID, Name and Color  columns from the Production.Product table.
The rows should be ordered by the ListPrice column.
*/

SELECT ProductID, Name, Color
FROM Production.Product
ORDER BY ListPrice;
GO

/*
3: Write a query that returns all the rows from the Person.Person table. You should return the BusinessEntityID, FirstName and LastName columns.
Assign the column aliases “PersonID”, “First Name” and “Last Name”. The rows should be ordered by the [Last Name] alias.
*/

SELECT 
	BusinessEntityID AS PersonID, 
	FirstName AS [First Name], 
	LastName AS [Last Name]
FROM Person.Person
Order by LastName;
GO

/*
4: Write a query that returns all rows from the  HumanResources.Employee table.
The rows should be ordered by the year in which employees were hired.
(Hint: Column HireDate and DATEPART function)​
*/

SELECT *
FROM HumanResources.Employee
ORDER BY DATEPART(year, HireDate);
GO

/*
5: Rewrite the query from Exercise 1 to sort the rows in descending order.
*/

SELECT ProductID, Name
FROM Production.Product
WHERE Name LIKE 'Lock Washer%'
ORDER BY ProductID DESC;
GO

/*
6: Write a query that returns all the rows from the Person.Person table. You should return the BusinessEntityID, FirstName and LastName columns. ​
The query result set should be first sorted in ascending order by the FirstName column and then sorted in descending order by the LastName column.
*/

SELECT 
	BusinessEntityID, 
	FirstName, 
	LastName
FROM Person.Person
ORDER BY FirstName ASC, LastName DESC;
GO

/*
7: Write a query that returns a list of the names of employees who are design engineers, tool designers, or marketing assistants.
(Hint: tables Person.Person, HumanResources.Employee) ​
*/

SELECT
	p.BusinessEntityID,
	p.FirstName, 
	p.MiddleName, 
	p.LastName, 
	e.JobTitle
FROM Person.Person AS p
JOIN HumanResources.Employee AS e
ON p.BusinessEntityID = e.BusinessEntityID
WHERE e.JobTitle IN ('Design Engineer', 'Tool Designer', 'Marketing Assistant');
GO

/*
8: Write a query that returns custid, companyname, contactname, address, city, country, and phone columns from the Sales.Customers table.
Filter the results to include only the customers with a contact name starting with the letter A.
*/

--Correct answer question: I couldn't find all the right connections between tables, could you please show the complete correct answer?

SELECT * 
FROM 
	(
	SELECT
	c.CustomerID AS 'CustID',
	s.Name AS CompanyName,
	CONCAT(p.FirstName,' ',p.LastName) AS ContactName
	FROM Sales.Customer c

		JOIN Person.Person p
		ON c.PersonID = p.BusinessEntityID

		JOIN Sales.Store s
		ON c.StoreID = s.BusinessEntityID
	) AS X
WHERE ContactName LIKE 'A%';
GO

/*
9: Find all products that have NULL in the Weight column.  (Hint: tables Production.Product) 
*/

SELECT *
FROM Production.Product AS pp
WHERE pp.Weight IS NULL;
GO
 
/*
10: Write a query that returns the description, discount percentage, minimum quantity, and maximum quantity for all special offers
in AdventureWorks2012. If the maximum quantity for a particular special offer is NULL, display instead 0.00.
*/

SELECT
	SpecialOfferID,
	Description, 
	DiscountPct, 
	MinQty, 
	ISNULL(MaxQty,0.00) AS MaxQty
FROM Sales.SpecialOffer;
GO

-------------------------------------------------------------------------------------------------------------------------------------

PRINT 'Module 4 Exercises Complete';
GO

-- END MODULE 4 EXERCISES -----------------------------------------------------------------------------------------------------------
