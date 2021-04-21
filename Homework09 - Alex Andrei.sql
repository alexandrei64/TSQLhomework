/*
Database Development SIIT
Homework 09 - Triggers
Created by Alex Andrei
*/


-- Task: Create a trigger that distributes data inserted into the 'TabelInitial' table, thus normalizing all inserted data.

-- The following lines make the complete script recursive

USE master;
GO
DROP DATABASE IF EXISTS DataDumpNormalization;
GO

-- We create the structure of the example database and tables.

    /*
    'TabelInitial' is supposed to be the table in which all the data is dumped.
    Tables 'Tara', 'Sex' and 'Pesoane' are the normalized tables in which the data from the
    dump inserts in 'TabelInitial' gets distributed to.
    */

CREATE DATABASE DataDumpNormalization;
GO
USE DataDumpNormalization;
GO

CREATE TABLE TabelInitial(Nume VARCHAR(128), Tara VARCHAR(128), Sex CHAR(10));
GO
CREATE TABLE Tara(IDTara INT IDENTITY(1,1) PRIMARY KEY NOT NULL, NumeTara VARCHAR(128));
GO
CREATE TABLE Sex(IDSex TINYINT IDENTITY(1,1) PRIMARY KEY NOT NULL, NumeSex CHAR(10));
GO
CREATE TABLE Persoane
	(
	IDPersoana INT IDENTITY(1,1) PRIMARY KEY NOT NULL, 
	Prenume VARCHAR (128) NOT NULL,
	NumeDeFamilie VARCHAR (128) NOT NULL,
	IDTara INT REFERENCES Tara(IDTara) NULL,
	IDSex TINYINT REFERENCES Sex(IDSex) NULL
	);
GO


-- We create the trigger which distributes the data inserted into 'TabelInitial' in the 'Tara', 'Sex' and 'Persoane tables.
    /*
    Trigger is supposed to insert only unique data into the 'Tara' and 'Sex' tables, 
    the same logic doesn't apply to the 'Persoane' table because 2 different persons might have the same name.
    */

CREATE OR ALTER TRIGGER Normalize_TabelInitial ON TabelInitial
    FOR INSERT 
AS
BEGIN
    SET NOCOUNT ON;
        INSERT INTO Tara(NumeTara)
        SELECT Tara as NumeTara
        FROM
            (
            SELECT DISTINCT Tara FROM INSERTED
            ) VT
        WHERE NOT EXISTS
            (SELECT NumeTara FROM Tara WHERE VT.Tara = Tara.NumeTara);

        INSERT INTO Sex(NumeSex)
        SELECT Sex as NumeSex
        FROM
            (
            SELECT DISTINCT Sex FROM INSERTED
            ) VT
        WHERE NOT EXISTS 
            (SELECT NumeSex FROM Sex WHERE VT.Sex = Sex.NumeSex);

        INSERT INTO Persoane (Prenume, NumeDeFamilie, IDTara, IDSex)
        SELECT Prenume, NumeDeFamilie, IDTara, IDSex
        FROM
            (
                SELECT
                NULL AS IDPersoana,
                LEFT(TI.Nume, CHARINDEX(' ', TI.Nume)) AS Prenume,
                RIGHT(TI.Nume, LEN(TI.Nume) - CHARINDEX(' ', TI.Nume)) as NumeDeFamilie,
                T.IDTara,
                S.IDSex
                FROM INSERTED TI
                JOIN Tara T	
                    ON TI.Tara = T.NumeTara
                JOIN Sex S
                    ON TI.Sex = S.NumeSex
            ) SQ
        ;
END
GO


-- We run three different inserts into 'TabelInitial' to test the functionality of our code.

INSERT INTO TabelInitial(Nume, Tara, Sex)
VALUES
	('Ana Ionescu', 'Romania', 'feminin'),
	('Traian Popescu', 'Romania', 'masculin'),
	('Ana Blandiana', 'Romania', 'feminin');
GO

INSERT INTO TabelInitial(Nume, Tara, Sex)
VALUES
	('Stan Lee', 'Statele Unite ale Americii', 'masculin'),
	('Michael Schumacher', 'Germania', 'masculin'),
	('Alfredo Pacino', 'Statele Unite ale Americii', 'masculin'),
    ('Henri Coanda', 'Romania', 'masculin');
GO

INSERT INTO TabelInitial(Nume, Tara, Sex)
VALUES
	('Michelle Obama', 'Statele Unite ale Americii', 'feminin'),
	('Angela Merkel', 'Germania', 'masculin'),
    ('Henri Coanda', 'Romania', 'masculin');
GO

-- We write some SELECT queries to see the results of our code.

SELECT * FROM TabelInitial;
SELECT * FROM Tara;
SELECT * FROM Sex;
SELECT * FROM Persoane;
GO

-- END OF CODE