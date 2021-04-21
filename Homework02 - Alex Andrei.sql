/*
HOMEWORK 02
STRING, DATE, TIME AND AGGREGATE FUNCTIONS
CREATED BY ALEX ANDREI
*/



--INTRO

IF DATEPART(dw,SYSDATETIME()) = 7
		PRINT 'Hello teacher & colleagues'
	ELSE
		PRINT 'Have you done your homework?';
GO

-- 1) We want to remove vowels from a text
DECLARE @a VARCHAR(128) = 'Once upon a time quantum computers were just a dream'
SELECT 
REPLACE(	REPLACE(REPLACE(REPLACE(REPLACE(@a,
	'a',''),
	'e',''),
	'i',''),
	'o',''),
	'u','');
GO

-- 2) Performing cleanup on given text
DECLARE @a VARCHAR (128) = '      I just wanted to test out the LTRIM AND RTRIM FUNCTIONS      ';
SELECT LTRIM(RTRIM(@a));
GO

-- 3) Converting text into uppercase and lowercase, as specified in the text

DECLARE @a VARCHAR (128) = 'this will be displayed as uppercase';
DECLARE @b VARCHAR (128) = 'THIS WILL BE DISPLAYED AS LOWERCASE';
SELECT
	UPPER (@a),
	LOWER (@b);
GO

-- 4) Separating column that contains multiple data (Order number and Model Number) into specific different columns
CREATE DATABASE SalesDB;
GO

USE SalesDB;
GO

CREATE TABLE Orders (Ordered_Models VARCHAR(20));
GO

INSERT INTO Orders
	VALUES
		('003098767_L-PST-E30'),
		('003098768_L-BST-E30'),
		('003098769_L-REP-E30'),
		('003098770_L-DDO-E30'),
		('003098771_L-IOS-E30');
GO

SELECT
	Ordered_Models,
	LEFT (Ordered_Models,9) as 'Order_number',
	RIGHT (Ordered_Models,9) as 'Model'
from Orders;
GO

-- 5) From the previous table we use another function to extract the Models

SELECT SUBSTRING(Ordered_Models, 11, 9)AS 'Models'
FROM Orders;
GO


-- 6) Created a query that returns the sounds a fox makes, as in Ylvis's song, "The Fox" and also the length of the expression

DECLARE @r1 VARCHAR (128) = 'Ring-ding-ding-ding-dingering ';
DECLARE @r2 VARCHAR (128) = 'Wa-pa-pa-pa-pow ';
SELECT REPLICATE(@r1, 3) + REPLICATE(@r2,3)
AS 'What does the fox say?';

SELECT LEN (@r1)*3 + LEN (@r2)*3 AS 'A fox says this many characters';
GO

	
-- 7) We want to change our strings in the Orders table in order to link the warranty to our models.
-- This is done by just changing the "L" to "M"
	

select stuff (Ordered_Models, 11, 1, 'M') AS 'O_Warranty'
from Orders;
GO

-- 8) Create a query that calculates the time I've lived on Earth so far (displayed in days, months and years)

DECLARE @bday DATE = '1994-07-24';
SELECT DATEDIFF (DAY,@bday,GETDATE ()) AS 'Days lived:';
SELECT DATEDIFF (MONTH,@bday,GETDATE ()) AS 'Months lived:';
SELECT DATEDIFF (YEAR,@bday,GETDATE ()) AS 'Years lived:';
GO


-- 9) We want the time to be shown as current time + 15 minutes in order to keep a constant sense of urgency
-- We want to display only hours minutes and seconds.
	

SELECT LEFT(RIGHT(DATEADD(MI,15,SYSDATETIME()),16),8);
GO

-- 10) We built a query that tells you if the Tesla Cybertrk has been released or not

DECLARE @CYBERTRK DATETIME2 = '2019-11-22 6:00:00'; -- Tesla Cybertrk Presentation Event Date

IF @CYBERTRK >= SYSDATETIME()
PRINT 'Hold your horses cowboy! Tesla Cybertrk is not out yet.'
ELSE
PRINT 'CYBERTRK IS OUT IN THE WILD NOW';
GO

-- 11) In case the event is postponed add 7 days to the date announced

DECLARE @CYBERTRK DATETIME2 = '2019-11-22 6:00:00';
SELECT DATEADD(DD,7,@CYBERTRK);
GO

-- 12) Built a query that returns the number of the week we're currently in

SELECT DATEPART(wk,sysdatetime()) AS 'We are in week number'	;
GO

-- 13) Created a table to perform aggregate functions on

CREATE TABLE Stock (
	ID INT PRIMARY KEY NOT NULL,
	MODEL VARCHAR (9) NOT NULL,
	QTY INT NOT NULL,
	PRICE_EUR INT NOT NULL
	);
GO

INSERT INTO Stock (ID, MODEL, QTY, PRICE_EUR)
	VALUES
		(1,'L-PST-E30',20,250),
		(2,'L-BST-E30',45,100),
		(3,'L-REP-E30',32,130),
		(4,'L-DDO-E30',200,55),
		(5,'L-IOS-E30',1174,10),
		(6,'L-PST-E30',73,250),
		(7,'L-BST-E30',82,100);
GO

-- 14) Below we perform aggregate functions on the table we just created to get a statistical view over the available data

SELECT AVG(PRICE_EUR) AS Avg_Price FROM Stock;
GO

SELECT GETDATE() AS 'As of date',SUM(QTY) AS Sum_QTY FROM Stock;
GO

SELECT MIN(PRICE_EUR) AS Min_Price FROM Stock;
GO

SELECT MAX(PRICE_EUR) AS Max_Price FROM Stock;
GO

SELECT COUNT(MODEL) AS 'Number of models in stock' FROM Stock;
GO

SELECT VAR(PRICE_EUR) AS 'Var_Price' FROM Stock;
GO

SELECT STDEV(PRICE_EUR) AS 'Stdev_Price' FROM Stock;
GO

-- END