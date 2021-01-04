CREATE DATABASE LibraryDB
ON PRIMARY (NAME = 'LibraryDB', FILENAME = 'N:\FPTAptech\SQL Data base\LibraryDB.mdf', SIZE = 3MB, MAXSIZE = UNLIMITED, FILEGROWTH = 1MB),
FILEGROUP Group1
(NAME = 'FileGroup_LibraryDB', FILENAME = 'N:\FPTAptech\SQL Data base\LibraryDB.ndf', SIZE = 3MB, MAXSIZE = UNLIMITED, FILEGROWTH = 1MB)
LOG ON (NAME = 'LibraryDB_log', FILENAME = 'N:\FPTAptech\SQL Data base\LibraryDB_log.ldf', SIZE = 3MB, MAXSIZE = UNLIMITED, FILEGROWTH = 1MB)
GO

USE LibraryDB
GO

CREATE TABLE Publisher
(
	PublisherCode VARCHAR(10) PRIMARY KEY NONCLUSTERED,
	PublisherName VARCHAR(30),
	Address VARCHAR(50)
)
GO

CREATE TABLE Books
(
	BookCode VARCHAR(10) PRIMARY KEY,
	BookName VARCHAR(30),
	Price INT,
	QOH INT,
	PublisherCode VARCHAR(10) CONSTRAINT FK_PublisherCode FOREIGN KEY(PublisherCode) REFERENCES dbo.Publisher(PublisherCode)
)
GO

--3.
SELECT * FROM dbo.Books
WHERE Price > 0 AND Price < 1000

--4
SELECT * FROM dbo.Books
WHERE QOH >= 0

--5
CREATE CLUSTERED INDEX IX_Pub ON dbo.Publisher(PublisherName)

--6
INSERT dbo.Publisher
(
    PublisherCode,
    PublisherName,
    Address
)
VALUES  (   'C01', 'AAA', 'awdwadawdawd'),
		(   'C02', 'BBB', 'awdwafseg12123'),
		(   'C03', 'CCC', 'jhbgrdjhb13113'),
		(   'C04', 'DDD', 'ooaf131324211'),
		(   'C05', 'EEE', 'svnvjskn121223')
GO

INSERT dbo.Books
(
    BookCode,
    BookName,
    Price,
    QOH,
    PublisherCode
)
VALUES  ('B01', 'UHUUH', 1000,  1, 'C01'),
		('B02', 'IUGIO1', 500,  0, 'C02'),
		('B03', 'IIJWIEJ', 700,  1, 'C03'),
		('B04', 'IUADNA', 1500,  0, 'C04'),
		('B05', 'QADADA', 900,  1, 'C05'),
		('B06', 'SFFADAD', 900,  3, 'C01')
GO

SELECT * FROM dbo.Publisher
SELECT * FROM dbo.Books

--7
GO
CREATE VIEW BookInfo AS
SELECT BookCode, BookName, Price, QOH, PublisherName FROM dbo.Books
JOIN dbo.Publisher ON Publisher.PublisherCode = Books.PublisherCode
WHERE QOH > 0
GO

SELECT * FROM dbo.BookInfo
--8

--9
GO
CREATE TRIGGER DeleteBook ON dbo.Books
INSTEAD OF UPDATE AS
	BEGIN
	IF (SELECT Inserted.QOH FROM Inserted) = 0
		BEGIN
			UPDATE dbo.Books SET QOH = (SELECT QOH FROM Inserted)
			WHERE Books.QOH = (SELECT QOH FROM Deleted)
		    DELETE dbo.Books WHERE QOH = 0
			PRINT 'Deleted'
		END
	ELSE
		BEGIN
		    UPDATE dbo.Books SET QOH = (SELECT QOH FROM Inserted)
			WHERE Books.QOH = (SELECT QOH FROM Deleted)
			PRINT'Updated'
		END
	END
	GO

UPDATE dbo.Books SET QOH = 0 WHERE QOH = 3
SELECT * FROM dbo.Books

--fix data
INSERT dbo.Books
(
    BookCode,
    BookName,
    Price,
    QOH,
    PublisherCode
)
VALUES  ('B02', 'IUGIO1', 500,  10, 'C02'),
		('B04', 'IUADNA', 1500,  20, 'C04'),
		('B06', 'SFFADAD', 900,  3, 'C01')
GO

--8
ALTER PROC SoldBooks
@qty INT = DEFAULT
AS
BEGIN
    IF @qty IS NULL
	BEGIN
	    SELECT BookCode, BookName, PublisherName, Price FROM dbo.Books
		JOIN dbo.Publisher ON Publisher.PublisherCode = Books.PublisherCode
	END
	ELSE
	BEGIN
	    UPDATE dbo.Books SET QOH = QOH +@qty
	END
END
GO

SELECT * FROM dbo.Books

EXEC dbo.SoldBooks @qty = 1 -- int
EXEC dbo.SoldBooks -- int






