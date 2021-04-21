/*
Homework 03
W3 Resource - SQL Joins Exercises
Created by Alex Andrei
*/


/*
The complete homework takes place in the HWRK_04_Joins database, which contains the following tables:
Salesman, Customer, Orders, Company_Mast, Item_Mast, Emp_Department, Emp_Details

The exercises found within this homework have been created by W3 Resource
Link: https://www.w3resource.com/sql-exercises/sql-joins-exercises.php
*/


---------------------------------------------------------------------------------------------------------------------------
-- DATABASE CREATION

-- We create the database of our homework, but we also introduce a failsafe so the code can be executed repetitively 

USE master;
GO

DROP DATABASE IF EXISTS HWrk_04_Joins;
GO

CREATE DATABASE HWrk_04_Joins;
GO

USE HWrk_04_Joins;
GO

---------------------------------------------------------------------------------------------------------------------------
-- TABLE CREATIONS

-- Creating the table which contains data of our salesman and inserting the respective data, code also contains a failsafe

DROP TABLE IF EXISTS Salesman;
GO

CREATE TABLE Salesman
    (
    Salesman_ID INT PRIMARY KEY NOT NULL,
    Name VARCHAR(128) NOT NULL,
    City VARCHAR(128) NOT NULL,
    Commission DEC(2,2) NOT NULL
    );
GO

INSERT INTO Salesman (Salesman_ID, Name, City, Commission)
    VALUES
        (5001,'James Hoog','New York',0.15),
        (5002,'Nail Knite','Paris',0.13),
        (5005,'Pit Alex','London',0.11),
        (5006,'Mc Lyon','Paris',0.14),
        (5007,'Paul Adam','Rome',0.13),
        (5003,'Lauson Hen','San Jose',0.12);
GO

-- Creating the table which contains data of our customers and inserting the respective data, code also contains a failsafe

DROP TABLE IF EXISTS Customer;
GO

CREATE TABLE Customer
    (
    Customer_ID INT PRIMARY KEY NOT NULL,
    Cust_Name VARCHAR(128) NOT NULL,
    City VARCHAR(128) NOT NULL,
    Grade INT,
    Salesman_ID INT NOT NULL FOREIGN KEY REFERENCES Salesman(Salesman_ID)
    );
GO

INSERT INTO Customer (Customer_ID, Cust_Name, City, Grade, Salesman_ID)
    VALUES
        (3002,'Nick Rimando','New York',100,5001),
        (3007,'Brad Davis', 'New York',200,5001),
        (3005,'Graham Zusi','California',200,5002),
        (3008,'Julian Green','London',300,5002),
        (3004,'Fabian Johnson','Paris',300,5006),
        (3009,'Geoff Cameron','Berlin',100,5003),
        (3003,'Jozy Altidor','Moscow',200,5007),
        (3001,'Brad Guzan','London',NULL,5005);
GO

-- Creating the table which contains data of our orders and inserting the respective data, code also contains a failsafe

DROP TABLE IF EXISTS Orders;
GO

CREATE TABLE Orders
    (
    Ord_No INT NOT NULL,
    Purch_Amt DEC(6,2) NOT NULL,
    Ord_Date DATE NOT NULL,
    Customer_ID INT NOT NULL FOREIGN KEY REFERENCES Customer (Customer_ID),
    Salesman_ID INT NOT NULL FOREIGN KEY REFERENCES Salesman (Salesman_ID)
    );
GO

INSERT INTO Orders (Ord_No,Purch_Amt,Ord_Date,Customer_ID,Salesman_ID)
    VALUES
        (70001,150.5,'2012-10-05',3005,5002),
        (70009,270.65,'2012-09-10',3001,5005),
        (70002,65.26,'2012-10-05',3002,5001),
        (70004,110.5,'2012-08-17',3009,5003),
        (70007,948.5,'2012-09-10',3005,5002),
        (70005,2400.6,'2012-07-27',3007,5001),
        (70008,5760,'2012-09-10',3002,5001),
        (70010,1983.43,'2012-10-10',3004,5006),
        (70003,2480.4,'2012-10-10',3009,5003),
        (70012,250.45,'2012-06-27',3008,5002),
        (70011,75.29,'2012-08-17',3003,5007),
        (70013,3045.6,'2012-04-25',3002,5001);
GO

-- Creating the table which contains data of our producers and inserting the respective data, code also contains a failsafe

DROP TABLE IF EXISTS Company_Mast;
GO

CREATE TABLE Company_Mast
    (
	Com_ID INT PRIMARY KEY NOT NULL,
	Com_Name VARCHAR (30) NOT NULL
    );
GO

INSERT INTO Company_Mast (Com_ID, Com_Name)
    VALUES
		(11,'Samsung'),
		(12,'iBall'),
		(13,'Epsion'),
		(14,'Zebronics'),
		(15,'Asus'),
		(16,'Frontech');
GO

-- Creating the table which contains data of our items and inserting the respective data, code also contains a failsafe

DROP TABLE IF EXISTS Item_Mast;
GO

CREATE TABLE Item_Mast
    (
	Pro_ID INT PRIMARY KEY NOT NULL,
	Pro_Name VARCHAR (128) NOT NULL,
	Pro_Price INT NOT NULL,
	Pro_Com INT NOT NULL FOREIGN KEY REFERENCES Company_Mast(Com_ID)
    );
GO

INSERT INTO Item_Mast (Pro_ID, Pro_Name, Pro_Price, Pro_Com)
    VALUES
		(101,'Mother Board',3200,15),
		(102,'Key Board',450,16),
		(103,'ZIP drive',250,14),
		(104,'Speaker',550,16),
		(105,'Monitor',5000,11),
		(106,'DVD drive',900,12),
		(107,'CD drive',800,12),
		(108,'Printer',2600,13),
		(109,'Refill cartridge',350,13),
		(110,'Mouse',250,12);
GO

-- Creating the table which contains data of our departments and inserting the respective data, code also contains a failsafe

DROP TABLE IF EXISTS Emp_Department;
GO

CREATE TABLE Emp_Department
    (
	Dpt_Code TINYINT PRIMARY KEY NOT NULL,
	Dpt_Name VARCHAR (10) NOT NULL,
	Dpt_Allotment INT NOT NULL
    );
GO

INSERT INTO Emp_Department (Dpt_Code, Dpt_Name, Dpt_Allotment)
    VALUES
		(57,'IT',65000),
		(63,'Finance',15000),
		(47,'HR',240000),
		(27,'RD',55000),
		(89,'QC',75000);
GO

-- Creating the table which contains data of our employees and inserting the respective data, code also contains a failsafe

DROP TABLE IF EXISTS Emp_Details;
GO

CREATE TABLE Emp_Details
    (
	Emp_IDNO INT PRIMARY KEY NOT NULL,
	Emp_FName VARCHAR (20) NOT NULL,
	Emp_LName VARCHAR (20) NOT NULL,
	Emp_Dept TINYINT NOT NULL FOREIGN KEY REFERENCES Emp_Department(Dpt_Code)
    );
GO

INSERT INTO Emp_Details (Emp_IDNO, Emp_FName, Emp_LName, Emp_Dept)
    VALUES
		(127323,'Michale','Robbin',57),
		(526689,'Carlos','Snares',63),
		(843795,'Enric','Dosio',57),
		(328717,'Jhon','Snares',63),
		(444527,'Joseph','Dosni',47),
		(659831,'Zanifer','Emily',47),
		(847674,'Kuleswar','Sitaraman',57),
		(748681,'Henrey','Gabriel',47),
		(555935,'Alex','Manuel',57),
		(539569,'George','Mardy',27),
		(733843,'Mario','Saule',63),
		(631548,'Alan','Snappy',27),
		(839139,'Maria','Foster',57);
GO


---------------------------------------------------------------------------------------------------------------------------
-- INTERROGATIONS

/*
1: Write a SQL statement to prepare a list with salesman name, customer name and their cities
for the salesmen and customer who belongs to the same city.
*/

SELECT
    s.Name AS [Salesman Name],
    c.Cust_Name AS [Customer Name], 
    c.City AS [Customer City]
FROM Salesman AS S 
JOIN Customer AS c 
	ON s.City = c.City
ORDER BY c.City ASC;
GO

/*
2: Write a SQL statement to make a list with order no, purchase amount, customer name and their
cities for those orders which order amount between 500 and 2000.
*/

SELECT 
    o.Ord_No AS [Order Number],
    o.Purch_Amt AS [Purchase Amount],
    c.Cust_Name AS [Customer Name],
    c.City
FROM Orders AS o
JOIN Customer AS c
	ON o.Customer_ID = c.Customer_ID
WHERE Purch_Amt >= 500
AND Purch_Amt <= 2000;
GO

/*
3: Write a SQL statement to know which salesman are working for which customer.
*/

SELECT 
    c.Cust_Name AS [Customer Name],
    s.Name AS [Responsible Salesman]
FROM Customer AS c
INNER JOIN Salesman AS s 
	ON s.Salesman_ID = c.Salesman_ID
Order by c.Cust_Name ASC;
GO

/*
4: Write a SQL statement to find the list of customers who appointed a salesman
for their jobs who gets a commission from the company is more than 12%.
*/

SELECT 
    c.Cust_Name AS [Customer Name],
    s.Name AS [Responsible Salesman],
    s.Commission
FROM Customer AS c
INNER JOIN Salesman AS s 
	ON s.Salesman_ID = c.Salesman_ID
WHERE s.Commission > '0.12' 
Order by c.Cust_Name ASC;
GO

/*
5: Write a SQL statement to find the list of customers who appointed a salesman
for their jobs who does not live in the same city where their customer lives,
and gets a commission is above 12%.
*/

SELECT
    s.Name AS [Salesman Name],
    c.Cust_Name AS [Customer Name],
    c.City AS [Customer City],
    s.City AS [Salesman City],
    s.Commission
FROM Salesman AS S 
INNER JOIN Customer AS c 
	ON s.Salesman_ID = c.Salesman_ID
WHERE c.City != s.City
AND s.Commission > '0.12';
GO

/*
6: Write a SQL statement to find the details of a order i.e. order number, order date,
amount of order, which customer gives the order and which salesman works for that customer
and how much commission he gets for an order.
*/

SELECT 
    o.Ord_No AS [Order Number], 
    o.Ord_Date AS [Order Date], 
    o.Purch_Amt AS [Purchase Amount],
    c.Cust_Name AS [Customer Name],
    c.Grade,
    s.Name AS [Salesman Name],
    s.Commission,
    s.Commission * o.Purch_Amt AS [Commission Amount]
FROM Orders AS o
JOIN Salesman AS s
	ON s.Salesman_ID = o.Salesman_ID
JOIN Customer AS c
	ON c.Customer_ID = o.Customer_ID;
GO

/*
7: Write a SQL statement to make a join on the tables salesman, customer and orders in such a
form that the same column of each table will appear once and only the relational rows will come.
*/

SELECT
	o.Ord_no, o.Purch_Amt, o.Ord_Date, 
	c.Customer_ID, c.Cust_Name, c.City AS Cust_City, c.Grade, 
	s.Salesman_ID, s.Name AS Salesman_Name, s.City AS Salesman_City, s.Commission
FROM Orders AS o
JOIN Customer AS c
	ON c.Customer_ID = o.Customer_ID
JOIN Salesman AS s
	ON s.Salesman_ID = o.Salesman_ID
Order by Purch_Amt DESC;
GO

/*
8: Write a SQL statement to make a list in ascending order for the customer who works either 
through a salesman or by own.
*/

SELECT 
	c.Customer_ID, s.Salesman_ID,
	c.Grade, c.Cust_Name, c.City AS Cust_City,
	s.Name AS Salesman_Name, s.City AS Salesman_City
FROM Customer AS c
JOIN Salesman AS s
	ON c.Salesman_ID = s.Salesman_ID
ORDER BY c.Customer_ID ASC;
GO

/*
9:Write a SQL statement to make a list in ascending order for the customer who holds a grade less
than 300 and works either through a salesman or by own.
*/

SELECT 
	c.Customer_ID, s.Salesman_ID,
	c.Grade, c.Cust_Name, c.City AS Cust_City,
	s.Name AS Salesman_Name, s.City AS Salesman_City
FROM Customer AS c
JOIN Salesman AS s
	ON c.Salesman_ID = s.Salesman_ID
WHERE c.Grade < 300
ORDER BY c.Customer_ID ASC;
GO

/*
10: Write a SQL statement to make a report with customer name, city, order number, order date, and
order amount in ascending order according to the order date to find that either any of the existing
customers have placed no order or placed one or more orders.
*/

SELECT
	c.Cust_Name, c.City,
	o.Ord_No, o.Ord_Date, o.Purch_Amt
FROM ORDERS AS o
JOIN Customer AS c
	ON o.Customer_ID = c.Customer_ID
ORDER BY Ord_Date ASC;
GO

/*
11: Write a SQL statement to make a report with customer name, city, order number, order date, order
amount salesman name and commission to find that either any of the existing customers have placed no
order or placed one or more orders by their salesman or by own.
*/

SELECT
	c.Cust_Name, c.City,
	o.Ord_No, o.Ord_Date, o.Purch_Amt AS [Order_Amt],
	s.Name as [Salesman_Name], s.Commission
FROM ORDERS AS o
JOIN Customer AS c
	ON c.Customer_ID = o.Customer_ID
JOIN Salesman AS s
	ON s.Salesman_ID = o.Salesman_ID
GO

/*
12: Write a SQL statement to make a list in ascending order for the salesmen who works either for one
or more customer or not yet join under any of the customers.
*/

SELECT
	s.Name AS Salesman_Name, s.City as Salesman_City,
	c.Cust_Name, c.City AS Cust_City, c.Grade
FROM Salesman AS s
JOIN Customer AS c
	ON s.Salesman_ID = c.Salesman_ID
ORDER BY s.Salesman_ID ASC;
GO

/*
13: Write a SQL statement to make a list for the salesmen who works either for one or more customer or
not yet join under any of the customers who placed either one or more orders or no order to their supplier.
*/


SELECT
	s.Name AS Salesman_Name, s.City as Salesman_City,
	c.Cust_Name, c.City AS Cust_City, c.Grade,
	o.Ord_No, o.Ord_Date, o.Purch_Amt AS [Order_Amt]
FROM Salesman AS s
JOIN Customer AS c
	ON s.Salesman_ID = c.Salesman_ID
JOIN Orders AS o
	ON o.Customer_ID = c.Customer_ID
GO

/*
14: Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to
join any of the customer. The customer may have placed, either one or more orders on or above order amount 2000
and must have a grade, or he may not have placed any order to the associated supplier.
*/

SELECT
	s.Name AS Salesman_Name,
	c.Cust_Name, c.City AS Cust_City, c.Grade,
	o.Ord_No, o.Ord_Date, o.Purch_Amt AS [Order_Amt]
FROM Salesman AS s
JOIN Customer AS c
	ON s.Salesman_ID = c.Salesman_ID
JOIN Orders AS o
	ON o.Customer_ID = c.Customer_ID
WHERE o.Purch_Amt >= 2000
AND c.Grade IS NOT NULL;
GO

/*
15: Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for
those customers from the existing list who placed one or more orders or which order(s) have been placed by the
customer who is not on the list.
*/

SELECT
	c.Cust_Name, c.City AS Cust_City,
	o.Ord_No, o.Ord_Date, o.Purch_Amt AS [Order_Amt]
FROM Customer AS c
JOIN Orders AS o
	ON o.Customer_ID = c.Customer_ID;
GO

/*
16: Write a SQL statement to make a report with customer name, city, order no. order date, purchase amount for
only those customers on the list who must have a grade and placed one or more orders or which order(s) have been
placed by the customer who is neither in the list not have a grade.
*/

SELECT
	c.Cust_Name, c.City AS Cust_City,
	o.Ord_No, o.Ord_Date, o.Purch_Amt AS [Order_Amt]
FROM Customer AS c
JOIN Orders AS o
	ON o.Customer_ID = c.Customer_ID
WHERE c.Grade IS NOT NULL;
GO

/*
17: Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear
for all customer and vice versa.
*/

SELECT *
FROM Salesman
CROSS JOIN Customer;
GO

/*
18: Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear 
for all customer and vice versa for that customer who belongs to a city.
*/

SELECT *
FROM Salesman AS s
CROSS JOIN Customer AS c
WHERE c.City IS NOT NULL;
GO

/*
19: Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear 
for all customer and vice versa for those salesmen who belongs to a city and the customers who must have a grade.
*/

SELECT *
FROM Salesman AS s
CROSS JOIN Customer AS c
WHERE s.City IS NOT NULL
AND c.Grade IS NOT NULL;
GO


/*
20: Write a SQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear 
for all customer and vice versa for those salesmen who must belong a city which is not the same as his customer 
and the customers should have an own grade.
*/

SELECT *
FROM Salesman AS s
CROSS JOIN Customer AS c
WHERE s.City != c.City
AND s.City IS NOT NULL
AND c.Grade IS NOT NULL;
GO

/*
21: Write a SQL query to display all the data from the item_mast, including all the data for each item's 
producer company.
*/

SELECT *
FROM Item_Mast AS i
JOIN Company_Mast AS c
	ON i.Pro_Com = c.Com_ID;
GO

/*
22: Write a SQL query to display the item name, price, and company name of all the products.
*/

SELECT
	i.Pro_Name AS [Item Name], i.Pro_Price AS [Price],
	c.Com_Name AS [Company Name]
FROM Item_Mast AS i
JOIN Company_Mast AS c
	ON i.Pro_Com = c.Com_ID;
GO

/*
23: Write a SQL query to display the average price of items of each company, showing the name of the company.
*/

SELECT
	c.Com_Name AS [Company Name],
	AVG (i.Pro_Price) AS [Price]
FROM Item_Mast AS i
JOIN Company_Mast AS c
	ON i.Pro_Com = c.Com_ID
GROUP BY c.Com_Name;
GO

/*
24: Write a SQL query to display the names of the company whose products have an average price larger than or 
equal to Rs. 350.
*/

SELECT
	c.Com_Name AS [Company Name],
	AVG (i.Pro_Price) AS [Price]
FROM Item_Mast AS i
JOIN Company_Mast AS c
	ON i.Pro_Com = c.Com_ID
GROUP BY c.Com_Name
HAVING AVG (i.Pro_Price) >= 350;
GO

/*
25: Write a SQL query to display the name of each company along with the ID and price for their most
expensive product.
*/

SELECT
	c.Com_Name AS [Company Name], c.Com_ID,
	i.Pro_Name AS [Product Name],i.Pro_ID, i.Pro_Price AS [Price]
FROM Item_Mast AS i
JOIN Company_Mast AS c
	ON i.Pro_Com = c.Com_ID
AND i.Pro_Price = 
	(
	SELECT MAX(i.Pro_Price)
	FROM Item_Mast AS i
	WHERE i.Pro_Com = c.Com_ID
	);
GO

----
	/*
	SELECT
	c.Com_Name, i2.Pro_ID, i2.Pro_Name, T1.PriceProductBig
	FROM
	(
	SELECT i.Pro_Com, MAX(i.Pro_Price) PriceProductBig
	FROM Item_Mast i
	GROUP BY i.Pro_Com) AS T1
	JOIN Item_Mast i2
	ON t1.Pro_Com = i2.Pro_Com AND t1.PriceProductBig = i2.Pro_Price
	JOIN Company_Mast c
		ON T1.Pro_Com = c.Com_ID;
	GO
	*/
/*
26: Write a query in SQL to display all the data of employees including their department.
*/

SELECT *
FROM Emp_Details AS det
JOIN Emp_Department AS dpt
ON det.Emp_Dept = dpt.Dpt_Code;
GO

/*
27: Write a query in SQL to display the first name and last name of each employee, along
with the name and sanction amount for their department.
*/

SELECT 
	det.Emp_FName, det.Emp_LName,
	dpt.Dpt_Name, dpt.Dpt_Allotment
FROM Emp_Details AS det
JOIN Emp_Department AS dpt
	ON det.Emp_Dept = dpt.Dpt_Code;
GO

/*
28: Write a query in SQL to find the first name and last name of employees working for departments with 
a budget more than Rs. 50000.
*/

SELECT 
	det.Emp_FName, det.Emp_LName
FROM Emp_Details AS det
JOIN Emp_Department AS dpt
	ON det.Emp_Dept = dpt.Dpt_Code
WHERE dpt.Dpt_Allotment > 50000;
GO

/*
29: Write a query in SQL to find the names of departments where more than two employees are working.
*/

SELECT 
	dpt.Dpt_Name
FROM Emp_Details AS det
JOIN Emp_Department AS dpt
	ON det.Emp_Dept = dpt.Dpt_Code
GROUP BY dpt.Dpt_Name
HAVING COUNT(*) > 2;
GO

---------------------------------------------------------------------------------------------------------------------------
-- END