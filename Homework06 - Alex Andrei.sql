/*
Database Development SIIT
Module 6 Exercises
Created by Alex Andrei
*/



-- Before starting the lab – run the 01 – setup.sql that will create the DemoDB database.​

--------------------------------------------------------------------------------------------------------------------------------------------------

USE MASTER;
GO

DROP DATABASE IF EXISTS DemoDB;
GO

-- DATABASE 'DemoDB' CREATION FROM setup.SQL

    IF NOT EXISTS(SELECT * FROM sys.databases WHERE [name]='DemoDB')
        CREATE DATABASE DemoDB;
    GO

    USE DemoDB;
    GO
    -- Setup Lab
    IF NOT EXISTS(SELECT * FROM sys.schemas WHERE name='HR')
        EXECUTE ('CREATE SCHEMA HR');
    GO
    IF NOT EXISTS(SELECT * FROM sys.schemas WHERE name='Sales')
        EXECUTE('CREATE SCHEMA Sales');
    GO

    IF EXISTS (	SELECT * 
                FROM INFORMATION_SCHEMA.TABLES 
                WHERE TABLE_NAME = 'Employees'
                AND TABLE_SCHEMA = 'HR' 
                AND TABLE_CATALOG = 'DemoDB' )
                DROP TABLE Hr.Employees 
    GO


    /****** Object:  Table [HR].[Employees]    Script Date: 11/4/2017 7:19:19 AM ******/
    SET ANSI_NULLS ON
    GO

    SET QUOTED_IDENTIFIER ON
    GO

    CREATE TABLE [HR].[Employees](
        [empid] [int] IDENTITY(1,1) NOT NULL,
        [lastname] [nvarchar](20) NOT NULL,
        [firstname] [nvarchar](10) NOT NULL,
        [title] [nvarchar](30) NOT NULL,
        [titleofcourtesy] [nvarchar](25) NOT NULL,
        [birthdate] [datetime] NOT NULL,
        [hiredate] [datetime] NOT NULL,
        [address] [nvarchar](60) NOT NULL,
        [city] [nvarchar](15) NOT NULL,
        [region] [nvarchar](15) NULL,
        [postalcode] [nvarchar](10) NULL,
        [country] [nvarchar](15) NOT NULL,
        [phone] [nvarchar](24) NOT NULL,
        [mgrid] [int] NULL,
    CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
    (
        [empid] ASC
    )
    ) 

    GO

    ALTER TABLE [HR].[Employees]  WITH CHECK ADD  CONSTRAINT [FK_Employees_Employees] FOREIGN KEY([mgrid])
    REFERENCES [HR].[Employees] ([empid])
    GO

    ALTER TABLE [HR].[Employees] CHECK CONSTRAINT [FK_Employees_Employees]
    GO

    ALTER TABLE [HR].[Employees]  WITH CHECK ADD  CONSTRAINT [CHK_birthdate] CHECK  (([birthdate]<=getdate()))
    GO

    ALTER TABLE [HR].[Employees] CHECK CONSTRAINT [CHK_birthdate]
    GO

    SET IDENTITY_INSERT [HR].[Employees] ON 

    GO
    INSERT [HR].[Employees] ([empid], [lastname], [firstname], [title], [titleofcourtesy], [birthdate], [hiredate], [address], [city], [region], [postalcode], [country], [phone], [mgrid]) VALUES (1, N'Davis', N'Sara', N'CEO', N'Ms.', CAST(N'1958-12-08T00:00:00.000' AS DateTime), CAST(N'2002-05-01T00:00:00.000' AS DateTime), N'7890 - 20th Ave. E., Apt. 2A', N'Seattle', N'WA', N'10003', N'USA', N'(206) 555-0101', NULL)
    GO
    INSERT [HR].[Employees] ([empid], [lastname], [firstname], [title], [titleofcourtesy], [birthdate], [hiredate], [address], [city], [region], [postalcode], [country], [phone], [mgrid]) VALUES (2, N'Funk', N'Don', N'Vice President, Sales', N'Dr.', CAST(N'1962-02-19T00:00:00.000' AS DateTime), CAST(N'2002-08-14T00:00:00.000' AS DateTime), N'9012 W. Capital Way', N'Tacoma', N'WA', N'10001', N'USA', N'(206) 555-0100', 1)
    GO
    INSERT [HR].[Employees] ([empid], [lastname], [firstname], [title], [titleofcourtesy], [birthdate], [hiredate], [address], [city], [region], [postalcode], [country], [phone], [mgrid]) VALUES (3, N'Lew', N'Judy', N'Sales Manager', N'Ms.', CAST(N'1973-08-30T00:00:00.000' AS DateTime), CAST(N'2002-04-01T00:00:00.000' AS DateTime), N'2345 Moss Bay Blvd.', N'Kirkland', N'WA', N'10007', N'USA', N'(206) 555-0103', 2)
    GO
    INSERT [HR].[Employees] ([empid], [lastname], [firstname], [title], [titleofcourtesy], [birthdate], [hiredate], [address], [city], [region], [postalcode], [country], [phone], [mgrid]) VALUES (4, N'Peled', N'Yael', N'Sales Representative', N'Mrs.', CAST(N'1947-09-19T00:00:00.000' AS DateTime), CAST(N'2003-05-03T00:00:00.000' AS DateTime), N'5678 Old Redmond Rd.', N'Redmond', N'WA', N'10009', N'USA', N'(206) 555-0104', 3)
    GO
    INSERT [HR].[Employees] ([empid], [lastname], [firstname], [title], [titleofcourtesy], [birthdate], [hiredate], [address], [city], [region], [postalcode], [country], [phone], [mgrid]) VALUES (5, N'Buck', N'Sven', N'Sales Manager', N'Mr.', CAST(N'1965-03-04T00:00:00.000' AS DateTime), CAST(N'2003-10-17T00:00:00.000' AS DateTime), N'8901 Garrett Hill', N'London', NULL, N'10004', N'UK', N'(71) 234-5678', 2)
    GO
    INSERT [HR].[Employees] ([empid], [lastname], [firstname], [title], [titleofcourtesy], [birthdate], [hiredate], [address], [city], [region], [postalcode], [country], [phone], [mgrid]) VALUES (6, N'Suurs', N'Paul', N'Sales Representative', N'Mr.', CAST(N'1973-07-02T00:00:00.000' AS DateTime), CAST(N'2003-10-17T00:00:00.000' AS DateTime), N'3456 Coventry House, Miner Rd.', N'London', NULL, N'10005', N'UK', N'(71) 345-6789', 5)
    GO
    INSERT [HR].[Employees] ([empid], [lastname], [firstname], [title], [titleofcourtesy], [birthdate], [hiredate], [address], [city], [region], [postalcode], [country], [phone], [mgrid]) VALUES (7, N'King', N'Russell', N'Sales Representative', N'Mr.', CAST(N'1970-05-29T00:00:00.000' AS DateTime), CAST(N'2004-01-02T00:00:00.000' AS DateTime), N'6789 Edgeham Hollow, Winchester Way', N'London', NULL, N'10002', N'UK', N'(71) 123-4567', 5)
    GO
    INSERT [HR].[Employees] ([empid], [lastname], [firstname], [title], [titleofcourtesy], [birthdate], [hiredate], [address], [city], [region], [postalcode], [country], [phone], [mgrid]) VALUES (8, N'Cameron', N'Maria', N'Sales Representative', N'Ms.', CAST(N'1968-01-09T00:00:00.000' AS DateTime), CAST(N'2004-03-05T00:00:00.000' AS DateTime), N'4567 - 11th Ave. N.E.', N'Seattle', N'WA', N'10006', N'USA', N'(206) 555-0102', 3)
    GO
    INSERT [HR].[Employees] ([empid], [lastname], [firstname], [title], [titleofcourtesy], [birthdate], [hiredate], [address], [city], [region], [postalcode], [country], [phone], [mgrid]) VALUES (9, N'Dolgopyatova', N'Zoya', N'Sales Representative', N'Ms.', CAST(N'1976-01-27T00:00:00.000' AS DateTime), CAST(N'2004-11-15T00:00:00.000' AS DateTime), N'1234 Houndstooth Rd.', N'London', NULL, N'10008', N'UK', N'(71) 456-7890', 5)
    GO
    SET IDENTITY_INSERT [HR].[Employees] OFF
    GO

    IF EXISTS (	SELECT * 
                FROM INFORMATION_SCHEMA.TABLES 
                WHERE TABLE_NAME = 'Customers'
                AND TABLE_SCHEMA = 'Sales' 
                AND TABLE_CATALOG = 'DemoDB' ) 
                DROP TABLE Sales.Customers; 
    GO


    SET ANSI_NULLS ON
    GO
    SET QUOTED_IDENTIFIER ON
    GO
    CREATE TABLE [Sales].[Customers](
        [custid] [int] IDENTITY(1,1) NOT NULL,
        [companyname] [nvarchar](40) NOT NULL,
        [contactname] [nvarchar](30) NOT NULL,
        [contacttitle] [nvarchar](30) NOT NULL,
        [address] [nvarchar](60) NOT NULL,
        [city] [nvarchar](15) NOT NULL,
        [region] [nvarchar](15) NULL,
        [postalcode] [nvarchar](10) NULL,
        [country] [nvarchar](15) NOT NULL,
        [phone] [nvarchar](24) NOT NULL,
        [fax] [nvarchar](24) NULL,
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
    (
        [custid] ASC
    )
    ) 

    GO
    SET IDENTITY_INSERT [Sales].[Customers] ON 

    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (1, N'Customer NRZBB', N'Allen, Michael', N'Sales Representative', N'Obere Str. 0123', N'Berlin', NULL, N'10092', N'Germany', N'030-3456789', N'030-0123456')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (2, N'Customer MLTDN', N'Hassall, Mark', N'Owner', N'Avda. de la Constituci�n 5678', N'M�xico D.F.', NULL, N'10077', N'Mexico', N'(5) 789-0123', N'(5) 456-7890')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (3, N'Customer KBUDE', N'Peoples, John', N'Owner', N'Mataderos  7890', N'M�xico D.F.', NULL, N'10097', N'Mexico', N'(5) 123-4567', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (4, N'Customer HFBZG', N'Arndt, Torsten', N'Sales Representative', N'7890 Hanover Sq.', N'London', NULL, N'10046', N'UK', N'(171) 456-7890', N'(171) 456-7891')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (5, N'Customer HGVLZ', N'Higginbotham, Tom', N'Order Administrator', N'Berguvsv�gen  5678', N'Lule�', NULL, N'10112', N'Sweden', N'0921-67 89 01', N'0921-23 45 67')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (6, N'Customer XHXJV', N'Poland, Carole', N'Sales Representative', N'Forsterstr. 7890', N'Mannheim', NULL, N'10117', N'Germany', N'0621-67890', N'0621-12345')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (7, N'Customer QXVLA', N'Bansal, Dushyant', N'Marketing Manager', N'2345, place Kl�ber', N'Strasbourg', NULL, N'10089', N'France', N'67.89.01.23', N'67.89.01.24')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (8, N'Customer QUHWH', N'Ilyina, Julia', N'Owner', N'C/ Araquil, 0123', N'Madrid', NULL, N'10104', N'Spain', N'(91) 345 67 89', N'(91) 012 34 56')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (9, N'Customer RTXGC', N'Raghav, Amritansh', N'Owner', N'6789, rue des Bouchers', N'Marseille', NULL, N'10105', N'France', N'23.45.67.89', N'23.45.67.80')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (10, N'Customer EEALV', N'Bassols, Pilar Colome', N'Accounting Manager', N'8901 Tsawassen Blvd.', N'Tsawassen', N'BC', N'10111', N'Canada', N'(604) 901-2345', N'(604) 678-9012')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (11, N'Customer UBHAU', N'Jaffe, David', N'Sales Representative', N'Fauntleroy Circus 4567', N'London', NULL, N'10064', N'UK', N'(171) 789-0123', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (12, N'Customer PSNMQ', N'Ray, Mike', N'Sales Agent', N'Cerrito 3456', N'Buenos Aires', NULL, N'10057', N'Argentina', N'(1) 890-1234', N'(1) 567-8901')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (13, N'Customer VMLOG', N'Benito, Almudena', N'Marketing Manager', N'Sierras de Granada 7890', N'M�xico D.F.', NULL, N'10056', N'Mexico', N'(5) 456-7890', N'(5) 123-4567')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (14, N'Customer WNMAF', N'Jelitto, Jacek', N'Owner', N'Hauptstr. 0123', N'Bern', NULL, N'10065', N'Switzerland', N'0452-678901', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (15, N'Customer JUWXK', N'Richardson, Shawn', N'Sales Associate', N'Av. dos Lus�adas, 6789', N'Sao Paulo', N'SP', N'10087', N'Brazil', N'(11) 012-3456', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (16, N'Customer GYBBY', N'Birkby, Dana', N'Sales Representative', N'Berkeley Gardens 0123 Brewery', N'London', NULL, N'10039', N'UK', N'(171) 234-5678', N'(171) 234-5679')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (17, N'Customer FEVNN', N'Jones, TiAnna', N'Order Administrator', N'Walserweg 4567', N'Aachen', NULL, N'10067', N'Germany', N'0241-789012', N'0241-345678')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (18, N'Customer BSVAR', N'Rizaldy, Arif', N'Owner', N'3456, rue des Cinquante Otages', N'Nantes', NULL, N'10041', N'France', N'89.01.23.45', N'89.01.23.46')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (19, N'Customer RFNQC', N'Boseman, Randall', N'Sales Agent', N'5678 King George', N'London', NULL, N'10110', N'UK', N'(171) 345-6789', N'(171) 345-6780')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (20, N'Customer THHDP', N'Kane, John', N'Sales Manager', N'Kirchgasse 9012', N'Graz', NULL, N'10059', N'Austria', N'1234-5678', N'9012-3456')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (21, N'Customer KIDPX', N'Russo, Giuseppe', N'Marketing Assistant', N'Rua Or�s, 3456', N'Sao Paulo', N'SP', N'10096', N'Brazil', N'(11) 456-7890', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (22, N'Customer DTDMN', N'Bueno, Janaina Burdan, Neville', N'Accounting Manager', N'C/ Moralzarzal, 5678', N'Madrid', NULL, N'10080', N'Spain', N'(91) 890 12 34', N'(91) 567 89 01')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (23, N'Customer WVFAF', N'Khanna, Karan', N'Assistant Sales Agent', N'4567, chauss�e de Tournai', N'Lille', NULL, N'10048', N'France', N'45.67.89.01', N'45.67.89.02')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (24, N'Customer CYZTN', N'San Juan, Patricia', N'Owner', N'�kergatan 5678', N'Br�cke', NULL, N'10114', N'Sweden', N'0695-67 89 01', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (25, N'Customer AZJED', N'Carlson, Jason', N'Marketing Manager', N'Berliner Platz 9012', N'M�nchen', NULL, N'10091', N'Germany', N'089-8901234', N'089-5678901')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (26, N'Customer USDBG', N'Koch, Paul', N'Marketing Manager', N'9012, rue Royale', N'Nantes', NULL, N'10101', N'France', N'34.56.78.90', N'34.56.78.91')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (27, N'Customer WMFEA', N'Schm�llerl, Martin', N'Sales Representative', N'Via Monte Bianco 4567', N'Torino', NULL, N'10099', N'Italy', N'011-2345678', N'011-9012345')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (28, N'Customer XYUFB', N'Cavaglieri, Giorgio', N'Sales Manager', N'Jardim das rosas n. 8901', N'Lisboa', NULL, N'10054', N'Portugal', N'(1) 456-7890', N'(1) 123-4567')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (29, N'Customer MDLWA', N'Kolesnikova, Katerina', N'Marketing Manager', N'Rambla de Catalu�a, 8901', N'Barcelona', NULL, N'10081', N'Spain', N'(93) 789 0123', N'(93) 456 7890')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (30, N'Customer KSLQF', N'Shabalin, Rostislav', N'Sales Manager', N'C/ Romero, 1234', N'Sevilla', NULL, N'10075', N'Spain', N'(95) 901 23 45', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (31, N'Customer YJCBX', N'Cheng, Yao-Qiang', N'Sales Associate', N'Av. Brasil, 5678', N'Campinas', N'SP', N'10128', N'Brazil', N'(11) 567-8901', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (32, N'Customer YSIQX', N'Krishnan, Venky', N'Marketing Manager', N'6789 Baker Blvd.', N'Eugene', N'OR', N'10070', N'USA', N'(503) 555-0122', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (33, N'Customer FVXPQ', N'Sigurdarson, Hallur ', N'Owner', N'5� Ave. Los Palos Grandes 3456', N'Caracas', N'DF', N'10043', N'Venezuela', N'(2) 789-0123', N'(2) 456-7890')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (34, N'Customer IBVRG', N'Cohen, Shy', N'Accounting Manager', N'Rua do Pa�o, 7890', N'Rio de Janeiro', N'RJ', N'10076', N'Brazil', N'(21) 789-0123', N'(21) 789-0124')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (35, N'Customer UMTLM', N'Langohr, Kris', N'Sales Representative', N'Carrera 1234 con Ave. Carlos Soublette #8-35', N'San Crist�bal', N'T�chira', N'10066', N'Venezuela', N'(5) 567-8901', N'(5) 234-5678')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (36, N'Customer LVJSO', N'Smith, Denise', N'Sales Representative', N'City Center Plaza 2345 Main St.', N'Elgin', N'OR', N'10103', N'USA', N'(503) 555-0126', N'(503) 555-0135')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (37, N'Customer FRXZL', N'Cr?ciun, Ovidiu V.', N'Sales Associate', N'9012 Johnstown Road', N'Cork', N'Co. Cork', N'10051', N'Ireland', N'8901 234', N'5678 9012')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (38, N'Customer LJUCA', N'Lee, Frank', N'Marketing Manager', N'Garden House Crowther Way 3456', N'Cowes', N'Isle of Wight', N'10063', N'UK', N'(198) 567-8901', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (39, N'Customer GLLAG', N'Song, Lolan', N'Sales Associate', N'Maubelstr. 8901', N'Brandenburg', NULL, N'10060', N'Germany', N'0555-34567', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (40, N'Customer EFFTC', N'De Oliveira, Jose', N'Sales Representative', N'2345, avenue de l''Europe', N'Versailles', NULL, N'10108', N'France', N'12.34.56.78', N'12.34.56.79')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (41, N'Customer XIIWM', N'Litton, Tim', N'Sales Manager', N'3456 rue Alsace-Lorraine', N'Toulouse', NULL, N'10053', N'France', N'90.12.34.56', N'90.12.34.57')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (42, N'Customer IAIJK', N'Steiner, Dominik', N'Marketing Assistant', N'2345 Oak St.', N'Vancouver', N'BC', N'10098', N'Canada', N'(604) 567-8901', N'(604) 234-5678')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (43, N'Customer UISOJ', N'Deshpande, Anu', N'Marketing Manager', N'8901 Orchestra Terrace', N'Walla Walla', N'WA', N'10069', N'USA', N'(509) 555-0119', N'(509) 555-0130')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (44, N'Customer OXFRU', N'Louverdis, George', N'Sales Representative', N'Magazinweg 8901', N'Frankfurt a.M.', NULL, N'10095', N'Germany', N'069-7890123', N'069-4567890')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (45, N'Customer QXPPT', N'Sunkammurali,  Krishna', N'Owner', N'1234 Polk St. Suite 5', N'San Francisco', N'CA', N'10062', N'USA', N'(415) 555-0118', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (46, N'Customer XPNIK', N'Dressler, Marlies', N'Accounting Manager', N'Carrera 7890 con Ave. Bol�var #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'10093', N'Venezuela', N'(9) 789-0123', N'(9) 456-7890')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (47, N'Customer PSQUZ', N'Lupu, Cornel', N'Owner', N'Ave. 5 de Mayo Porlamar 5678', N'I. de Margarita', N'Nueva Esparta', N'10121', N'Venezuela', N'(8) 01-23-45', N'(8) 67-89-01')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (48, N'Customer DVFMB', N'Szymczak, Rados?aw', N'Sales Manager', N'9012 Chiaroscuro Rd.', N'Portland', N'OR', N'10073', N'USA', N'(503) 555-0117', N'(503) 555-0129')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (49, N'Customer CQRAA', N'Duerr, Bernard', N'Marketing Manager', N'Via Ludovico il Moro 6789', N'Bergamo', NULL, N'10106', N'Italy', N'035-345678', N'035-901234')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (50, N'Customer JYPSC', N'Mace, Donald', N'Sales Agent', N'Rue Joseph-Bens 0123', N'Bruxelles', NULL, N'10074', N'Belgium', N'(02) 890 12 34', N'(02) 567 89 01')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (51, N'Customer PVDZC', N'Taylor, Maurice', N'Marketing Assistant', N'8901 rue St. Laurent', N'Montr�al', N'Qu�bec', N'10040', N'Canada', N'(514) 345-6789', N'(514) 012-3456')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (52, N'Customer PZNLA', N'Dupont-Roc, Patrice', N'Marketing Assistant', N'Heerstr. 4567', N'Leipzig', NULL, N'10125', N'Germany', N'0342-12345', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (53, N'Customer GCJSG', N'Mallit, Ken', N'Sales Associate', N'South House 1234 Queensbridge', N'London', NULL, N'10061', N'UK', N'(171) 890-1234', N'(171) 890-1235')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (54, N'Customer TDKEG', N'Tiano, Mike', N'Sales Agent', N'Ing. Gustavo Moncada 0123 Piso 20-A', N'Buenos Aires', NULL, N'10094', N'Argentina', N'(1) 123-4567', N'(1) 890-1234')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (55, N'Customer KZQZT', N'Egelund-Muller, Anja', N'Sales Representative', N'7890 Bering St.', N'Anchorage', N'AK', N'10050', N'USA', N'(907) 555-0115', N'(907) 555-0128')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (56, N'Customer QNIVZ', N'Marinova, Nadejda', N'Owner', N'Mehrheimerstr. 9012', N'K�ln', NULL, N'10047', N'Germany', N'0221-0123456', N'0221-7890123')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (57, N'Customer WVAXS', N'Tollevsen, Bj�rn', N'Owner', N'5678, boulevard Charonne', N'Paris', NULL, N'10085', N'France', N'(1) 89.01.23.45', N'(1) 89.01.23.46')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (58, N'Customer AHXHT', N'Fakhouri, Fadi', N'Sales Representative', N'Calle Dr. Jorge Cash 8901', N'M�xico D.F.', NULL, N'10116', N'Mexico', N'(5) 890-1234', N'(5) 567-8901')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (59, N'Customer LOLJO', N'Meston, Tosh', N'Sales Manager', N'Geislweg 2345', N'Salzburg', NULL, N'10127', N'Austria', N'4567-8901', N'2345-6789')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (60, N'Customer QZURI', N'Uppal, Sunil', N'Sales Representative', N'Estrada da sa�de n. 6789', N'Lisboa', NULL, N'10083', N'Portugal', N'(1) 789-0123', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (61, N'Customer WULWD', N'Florczyk, Krzysztof', N'Accounting Manager', N'Rua da Panificadora, 1234', N'Rio de Janeiro', N'RJ', N'10115', N'Brazil', N'(21) 678-9012', N'(21) 678-9013')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (62, N'Customer WFIZJ', N'Misiec, Anna', N'Marketing Assistant', N'Alameda dos Can�rios, 1234', N'Sao Paulo', N'SP', N'10102', N'Brazil', N'(11) 901-2345', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (63, N'Customer IRRVL', N'Veronesi, Giorgio', N'Accounting Manager', N'Taucherstra�e 1234', N'Cunewalde', NULL, N'10126', N'Germany', N'0372-12345', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (64, N'Customer LWGMD', N'Gaffney, Lawrie', N'Sales Representative', N'Av. del Libertador 3456', N'Buenos Aires', NULL, N'10124', N'Argentina', N'(1) 234-5678', N'(1) 901-2345')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (65, N'Customer NYUHS', N'Moore, Michael', N'Assistant Sales Representative', N'6789 Milton Dr.', N'Albuquerque', N'NM', N'10109', N'USA', N'(505) 555-0125', N'(505) 555-0134')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (66, N'Customer LHANT', N'Voss, Florian', N'Sales Associate', N'Strada Provinciale 7890', N'Reggio Emilia', NULL, N'10038', N'Italy', N'0522-012345', N'0522-678901')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (67, N'Customer QVEPD', N'Garden, Euan', N'Assistant Sales Agent', N'Av. Copacabana, 6789', N'Rio de Janeiro', N'RJ', N'10052', N'Brazil', N'(21) 345-6789', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (68, N'Customer CCKOT', N'Myrcha, Jacek', N'Sales Manager', N'Grenzacherweg 0123', N'Gen�ve', NULL, N'10122', N'Switzerland', N'0897-012345', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (69, N'Customer SIUIH', N'Watters, Jason M.', N'Accounting Manager', N'Gran V�a, 4567', N'Madrid', NULL, N'10071', N'Spain', N'(91) 567 8901', N'(91) 234 5678')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (70, N'Customer TMXGN', N'Ginters, Kaspars', N'Owner', N'Erling Skakkes gate 2345', N'Stavern', NULL, N'10123', N'Norway', N'07-89 01 23', N'07-45 67 89')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (71, N'Customer LCOUJ', N'Navarro, Tom�s', N'Sales Representative', N'9012 Suffolk Ln.', N'Boise', N'ID', N'10078', N'USA', N'(208) 555-0116', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (72, N'Customer AHPOP', N'Welcker, Brian', N'Sales Manager', N'4567 Wadhurst Rd.', N'London', NULL, N'10088', N'UK', N'(171) 901-2345', N'(171) 901-2346')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (73, N'Customer JMIKW', N'Gonzalez, Nuria', N'Owner', N'Vinb�ltet 3456', N'Kobenhavn', NULL, N'10079', N'Denmark', N'12 34 56 78', N'90 12 34 56')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (74, N'Customer YSHXL', N'O�Brien, Dave', N'Marketing Manager', N'9012, rue Lauriston', N'Paris', NULL, N'10058', N'France', N'(1) 23.45.67.89', N'(1) 23.45.67.80')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (75, N'Customer XOJYP', N'Wojciechowska, Agnieszka', N'Sales Manager', N'P.O. Box 1234', N'Lander', N'WY', N'10113', N'USA', N'(307) 555-0114', N'(307) 555-0127')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (76, N'Customer SFOGW', N'Gulbis, Katrin', N'Accounting Manager', N'Boulevard Tirou, 2345', N'Charleroi', NULL, N'10100', N'Belgium', N'(071) 56 78 90 12', N'(071) 34 56 78 90')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (77, N'Customer LCYBZ', N'Osorio, Cristian', N'Marketing Manager', N'2345 Jefferson Way Suite 2', N'Portland', N'OR', N'10042', N'USA', N'(503) 555-0120', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (78, N'Customer NLTYP', N'Young, Robin', N'Marketing Assistant', N'0123 Grizzly Peak Rd.', N'Butte', N'MT', N'10107', N'USA', N'(406) 555-0121', N'(406) 555-0131')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (79, N'Customer FAPSM', N'Wickham, Jim', N'Marketing Manager', N'Luisenstr. 0123', N'M�nster', NULL, N'10118', N'Germany', N'0251-456789', N'0251-012345')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (80, N'Customer VONTK', N'Geschwandtner, Jens', N'Owner', N'Avda. Azteca 4567', N'M�xico D.F.', NULL, N'10044', N'Mexico', N'(5) 678-9012', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (81, N'Customer YQQWW', N'Nagel, Jean-Philippe', N'Sales Representative', N'Av. In�s de Castro, 1234', N'Sao Paulo', N'SP', N'10120', N'Brazil', N'(11) 123-4567', N'(11) 234-5678')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (82, N'Customer EYHKM', N'Veninga, Tjeerd', N'Sales Associate', N'1234 DaVinci Blvd.', N'Kirkland', N'WA', N'10119', N'USA', N'(206) 555-0124', N'(206) 555-0133')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (83, N'Customer ZRNDE', N'Fonteneau, Karl', N'Sales Manager', N'Smagsloget 3456', N'�rhus', NULL, N'10090', N'Denmark', N'23 45 67 89', N'01 23 45 67')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (84, N'Customer NRCSK', N'Tuntisangaroon, Sittichai', N'Sales Agent', N'6789, rue du Commerce', N'Lyon', NULL, N'10072', N'France', N'78.90.12.34', N'78.90.12.35')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (85, N'Customer ENQZT', N'McLin, Nkenge', N'Accounting Manager', N'5678 rue de l''Abbaye', N'Reims', NULL, N'10082', N'France', N'56.78.90.12', N'56.78.90.13')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (86, N'Customer SNXOJ', N'Syamala, Manoj', N'Sales Representative', N'Adenauerallee 7890', N'Stuttgart', NULL, N'10086', N'Germany', N'0711-345678', N'0711-901234')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (87, N'Customer ZHYOS', N'Ludwig, Michael', N'Accounting Manager', N'Torikatu 9012', N'Oulu', NULL, N'10045', N'Finland', N'981-123456', N'981-789012')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (88, N'Customer SRQVM', N'Li, Yan', N'Sales Manager', N'Rua do Mercado, 4567', N'Resende', N'SP', N'10084', N'Brazil', N'(14) 234-5678', NULL)
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (89, N'Customer YBQTI', N'Smith Jr., Ronaldo', N'Owner', N'8901 - 14th Ave. S. Suite 3B', N'Seattle', N'WA', N'10049', N'USA', N'(206) 555-0123', N'(206) 555-0132')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (90, N'Customer XBBVR', N'Larsson, Katarina', N'Owner/Marketing Assistant', N'Keskuskatu 2345', N'Helsinki', NULL, N'10055', N'Finland', N'90-012 3456', N'90-789 0123')
    GO
    INSERT [Sales].[Customers] ([custid], [companyname], [contactname], [contacttitle], [address], [city], [region], [postalcode], [country], [phone], [fax]) VALUES (91, N'Customer CCFIZ', N'Conn, Steve', N'Owner', N'ul. Filtrowa 6789', N'Warszawa', NULL, N'10068', N'Poland', N'(26) 234-5678', N'(26) 901-2345')
    GO
    SET IDENTITY_INSERT [Sales].[Customers] OFF
    GO


    IF EXISTS (	SELECT * 
                FROM INFORMATION_SCHEMA.TABLES 
                WHERE TABLE_NAME = 'PotentialCustomers'
                AND TABLE_SCHEMA = 'dbo' 
                AND TABLE_CATALOG = 'DemoDB' ) 
                DROP TABLE DemoDB.dbo.PotentialCustomers; 
    GO

    SELECT * INTO dbo.PotentialCustomers from Sales.Customers
    WHERE contactname IN (
    'Taylor, Maurice',
    'Mallit, Ken',
    'Tiano, Mike');
    GO

    DELETE FROM Sales.Customers 
    WHERE contactname IN (
    'Taylor, Maurice',
    'Mallit, Ken',
    'Tiano, Mike');
    GO
    
--------------------------------------------------------------------------------------------------------------------------------------------------

USE DemoDB;
GO

-- EXERCISES -------------------------------------------------------------------------------------------------------------------------------------

/*
1: In DemoDB database write an INSERT statement to add a record to the Employees table with the following values:​

Title: Sales Representative ​     Birthdate: 10/25/1975​
Titleofcourtesy: Mr​              Address: 1234 1st Ave. S.E.​
FirstName: Laurence​              City: Seattle​
Lastname: Grider​                 Country: USA​
Hiredate: 04/04/2016​             Phone: (206)555-0105​

Optional display the inserted values using the OUTPUT clause​
*/

INSERT HR.Employees(title, titleofcourtesy, firstname, lastname, hiredate, birthdate, address, city, country, phone)
OUTPUT INSERTED.*
VALUES ('Sales Representative','Mr', 'Laurence', 'Grider', '04/04/2016', '10/25/1975', '1234 1st Ave. S.E.', 'Seattle', 'USA', '(206)555-0105');
GO

/*
2: In DemoDB database insert all the rows from dbo.PotentialCustomers in Sales.Customers table ​
Optional display the inserted values using the OUTPUT clause​
*/

--SET IDENTITY_INSERT Sales.Customers ON;
INSERT INTO Sales.Customers(/*custid,*/ companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax)
OUTPUT INSERTED.*
SELECT /*custid,*/ companyname, contactname, contacttitle, address, city, region, postalcode, country, phone, fax FROM dbo.PotentialCustomers;
--SET IDENTITY_INSERT Sales.Customers OFF;
GO

/*
3: Write an UPDATE statement to update all the records in the Sales.Customers table that have 
a city of ‘Berlin’ and a contacttitle of ‘Sales Representative’ to have a contacttitle of ‘Sales Consultant’.
Optional display the updated values using the OUTPUT clause
*/

UPDATE Sales.Customers
SET city = 'Berlin', contacttitle = 'Sales Consultant'
OUTPUT INSERTED.*
WHERE city = 'Berlin'
AND contacttitle = 'Sales Representative';
GO

/*
4: Write a DELETE statement to delete all the records in the PotentialCustomers table which have 
the contactname of ‘Taylor, Maurice’, ‘Mallit, Ken’, or ‘Tiano, Mike’, as these records have now 
been added to the Customers table.
Optional display the updated values using the OUTPUT clause
*/

DELETE FROM dbo.PotentialCustomers
OUTPUT DELETED.*
WHERE contactname IN ('Taylor, Maurice', 'Mallit, Ken', 'Tiano, Mike');
GO

-- END MODULE 6 EXERCISES ------------------------------------------------------------------------------------------------------------------------