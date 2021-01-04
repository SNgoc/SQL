CREATE DATABASE Exercise3
ON PRIMARY (NAME = 'Exercise3', FILENAME = 'N:\FPTAptech\SQL Data base\Exercise3.mdf', SIZE = 5MB, MAXSIZE = 50MB, FILEGROWTH = 10%),
FILEGROUP Group1
(NAME = 'FileGroup_Exercise3', FILENAME = 'N:\FPTAptech\SQL Data base\Exercise3.ndf', SIZE = 10MB, MAXSIZE = UNLIMITED, FILEGROWTH = 5%)
LOG ON (NAME = 'Exercise3_log', FILENAME = 'N:\FPTAptech\SQL Data base\Exercise3_Log.ldf', SIZE = 2MB, MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
GO

USE Exercise3
GO

CREATE TABLE Customer
(
	CustomerID INT PRIMARY KEY,
	[Name] VARCHAR(30),
	Birth DATETIME,
	Gender BIT
)
GO

CREATE TABLE Product
(
	ProductID INT PRIMARY KEY,
	[Name] VARCHAR(30),
	PDesc TEXT,
	Pimage VARCHAR(200) UNIQUE,
	Pstatus BIT
)
GO

CREATE TABLE Comment
(
	ComID INT PRIMARY KEY IDENTITY(1,1),
	ProductID INT CONSTRAINT FK_ProductID FOREIGN KEY(ProductID) REFERENCES dbo.Product(ProductID),
	CustomerID INT CONSTRAINT FK_CustomerID FOREIGN KEY(CustomerID) REFERENCES dbo.Customer(CustomerID),
	[Date] DATETIME DEFAULT GETDATE(),
	Title VARCHAR(200),
	Content TEXT,
	[Status] BIT
)
GO

SET DATEFORMAT DMY
INSERT dbo.Customer
VALUES
(   1,         -- CustomerID - int
    'Johnny Owen',        -- Name - varchar(30)
    '10/10/1980', -- Birth - datetime
    1       -- Gender - bit
    ),  (2, 'Christina Tiny','10/03/1989',0), 
		(3, 'Garry Kelley','16/03/1990',NULL), 
		(4, 'Tammy Beckham','17/05/1980',0),
		(5, 'David Phantom','30/12/1987',1)
GO

INSERT dbo.Product
VALUES
(   1,   -- ProductID - int
    'Nokia N90',  -- Name - varchar(30)
    'Mobile Nokia',  -- PDesc - text
    'Image1.jpg',  -- Pimage - varchar(200)
    1 -- Pstatus - bit
    ),  (2, 'HP DV6000', 'Laptop', 'Imge2.jpg', NULL),
		(3, 'HP DV2000', 'Laptop', 'Image3.jpg', 1),
		(4, 'Samsung G488', 'Mobile Samsung', 'Image4.jpg', 0),
		(5, 'LCD Plasma', 'TV LCD', 'Image5.jpg', 0)
GO

SET DATEFORMAT DMY
INSERT dbo.Comment
VALUES
(   1,         -- ProductID - int
    1,         -- CustomerID - int
    '15/03/09', -- Date - datetime
    'Hot product',        -- Title - varchar(200)
    NULL,        -- Content - text
    1       -- Status - bit
    ),  (2, 2, '14/03/09', 'Hot price', 'Very much', 0),
		(3, 2, '20/03/09', 'Cheapest', 'Unlimited', 0),
		(4,	2, '16/04/09', 'Sale off', '50%', 1)
GO

SELECT * FROM dbo.Customer
SELECT * FROM dbo.Product
SELECT * FROM dbo.Comment

--4.	Displays the products have PStatus is null or 0.

SELECT * FROM dbo.Product
WHERE Pstatus IS NULL OR Pstatus = 0

--5.	Displays the products have no comments.

SELECT * FROM dbo.Product
WHERE ProductID NOT IN (SELECT ProductID FROM dbo.Comment)

--6.	Display the name of customers who have the largest comment. (có nhiều comment nhất)

SELECT CustomerID, Name FROM dbo.Customer
WHERE CustomerID = (SELECT TOP(1) CustomerID FROM dbo.Comment GROUP BY CustomerID ORDER BY COUNT(*) DESC)

--7.	Create a view "vwCustomerList" to display the information of customer includes all the column of Customer and age of customer >=35
GO
CREATE VIEW vwCustomerList AS
SELECT * FROM dbo.Customer
WHERE YEAR(GETDATE()) - YEAR(Birth) >= 35
GO


SELECT * FROM dbo.vwCustomerList

--8.	Create a trigger "tgUpdateProduct" on the Product table, if modify the value on the ProductID column of the Product table, 
--the corresponding value on the ProductID column of the Comment table must also be fixed.
GO
CREATE TRIGGER tgUpdateProduct ON dbo.Product
INSTEAD OF UPDATE AS
	BEGIN
		ALTER TABLE dbo.Comment DROP CONSTRAINT FK_ProductID
		UPDATE dbo.Product SET ProductID = (SELECT ProductID FROM Inserted)
					WHERE Product.ProductID = (SELECT ProductID FROM Deleted)
		UPDATE dbo.Comment SET ProductID = (SELECT ProductID FROM Inserted)
					WHERE Comment.ProductID = (SELECT ProductID FROM Deleted)
		ALTER TABLE dbo.Comment ADD CONSTRAINT FK_ProductID FOREIGN KEY(ProductID) REFERENCES dbo.Product(ProductID)
	END
GO

UPDATE dbo.Product SET ProductID = 2 WHERE ProductID = 6

SELECT * FROM dbo.Product
SELECT * FROM dbo.Comment

--9.	Create a stored procedure "uspDropOut" with a parameter, which contains the name of Customer. 
--IF this name is in the Customer table, it will delete all information related to this customer in all related tables of the Database.
GO
CREATE PROC uspDropOut
@NameCust VARCHAR(30) AS
BEGIN
	IF (EXISTS (SELECT * FROM dbo.Customer WHERE Name LIKE '%'+@NameCust+'%')) --QUAN TRỌNG: Phải dùng exists (không có cách khác)
	BEGIN
		DELETE FROM dbo.Comment WHERE CustomerID IN (SELECT CustomerID FROM dbo.Customer WHERE Name LIKE '%'+@NameCust+'%')
		DELETE FROM dbo.Customer WHERE Name LIKE '%'+@NameCust+'%'
	END
	ELSE
	BEGIN
	    PRINT 'Not exists this name'
	END
END
GO

EXEC dbo.uspDropOut @NameCust = 'Johnny' -- varchar(30)

SELECT * FROM dbo.Customer
SELECT * FROM dbo.Comment



--Fix data
SET DATEFORMAT DMY
INSERT dbo.Customer
VALUES
(   1,         -- CustomerID - int
    'Johnny Owen',        -- Name - varchar(30)
    '10/10/1980', -- Birth - datetime
    1       -- Gender - bit
    )

INSERT dbo.Comment
VALUES
(   1,         -- ProductID - int
    1,         -- CustomerID - int
    '15/03/09', -- Date - datetime
    'Hot product',        -- Title - varchar(200)
    NULL,        -- Content - text
    1       -- Status - bit
    )
