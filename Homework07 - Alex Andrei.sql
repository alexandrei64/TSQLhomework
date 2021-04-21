/*
Database Development SIIT
Homework 07 - Window Functions
Created by Alex Andrei
*/

/*
Homework description:
Create a script with ten different use cases of window functions.
Script can apply to the AdverntureWorks2012 database.
*/

USE AdventureWorks2012;
GO

/*
1. A query that returns the total commission amount for each sales person.
Columns that are returned are SalesPerson ID, FirstName, MiddleName, LastName and Total_Commission_Amt.
Result is shown in an ascending order by SalesPersonID.
*/

SELECT
    DISTINCT SalesPersonID,
    FirstName,
    MiddleName,
    LastName,
    SUM(CommissionPct * TotalDue) OVER ( PARTITION BY SalesPersonID) AS Total_Commission_Amt
FROM Sales.SalesPerson sp
JOIN Sales.SalesOrderHeader soh
    ON sp.BusinessEntityID = soh.SalesPersonID
JOIN Person.Person p 
    ON sp.BusinessEntityID = p.BusinessEntityID
ORDER BY SalesPersonID;
GO

/*
2. A query that returns the average commission amount for each sales person.
Columns that are returned are SalesPerson ID, FirstName, MiddleName, LastName and Avg_Commission_Amt.
Result is shown in an ascending order by SalesPersonID.
*/

SELECT
    DISTINCT SalesPersonID,
    FirstName,
    MiddleName,
    LastName,
    CommissionPct,
    AVG(CommissionPct * TotalDue) OVER ( PARTITION BY SalesPersonID) AS Avg_Commission_Amt
FROM Sales.SalesPerson sp
JOIN Sales.SalesOrderHeader soh
    ON sp.BusinessEntityID = soh.SalesPersonID
JOIN Person.Person p 
    ON sp.BusinessEntityID = p.BusinessEntityID
ORDER BY SalesPersonID;
GO

/*
3. A query that returns the number of times a sales reason was added as to the sales orders.
Columns that are returned are SalesReasonID, Reason_Description, ReasonType and Reason_Popularity.
The result is also ordered to show the most popular reason at the top and then descend.
*/

SELECT
    DISTINCT sr.SalesReasonID,
    sr.Name AS Reason_Description,
    sr.ReasonType,
    COUNT(osr.SalesReasonID) OVER (PARTITION BY osr.SalesReasonID) AS Reason_Popularity
FROM Sales.SalesOrderHeaderSalesReason  osr
JOIN Sales.SalesReason sr
    ON osr.SalesReasonID = sr.SalesReasonID
ORDER BY Reason_Popularity DESC;
GO

/*
4. A query that returns the number of times we have purchased from a particular vendor.
Columns that are returned are VendorID, VendorName and Vendor_Popularity.
The result is also shown in a descending order by vendor popularity.
*/

SELECT
DISTINCT v.BusinessEntityID AS VendorID,
v.Name AS Vendor_Name,
COUNT(poh.VendorID) OVER (PARTITION BY poh.VendorID) AS Vendor_Popularity
FROM Purchasing.Vendor v
JOIN Purchasing.PurchaseOrderHeader poh
    ON v.BusinessEntityID = poh.VendorID
ORDER BY Vendor_Popularity DESC;
GO


/*
5. A query that returns the products with the most expensive price on the sales orders.
Columns that are returned are PurchaseOrderID, Vendor ID, VendorName, Product_Name, Most_Expensive_Item_Price.
*/

SELECT
    DISTINCT poh.PurchaseOrderID,
    poh.VendorID,
    v.Name AS Vendor_Name,
    p.Name AS Product_Name,
    MAX(pod.UnitPrice) OVER (PARTITION BY pod.PurchaseOrderID) AS Most_Expensive_Item_Price
FROM Purchasing.PurchaseOrderDetail pod
JOIN Purchasing.PurchaseOrderHeader poh
    ON pod.PurchaseOrderID = poh.PurchaseOrderID
JOIN Purchasing.Vendor v
    ON v.BusinessEntityID = poh.VendorID
JOIN Production.Product p
    ON pod.ProductID = p.ProductID;
GO

-------- End ----