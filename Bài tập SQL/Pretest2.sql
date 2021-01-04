CREATE DATABASE Pretest2
ON PRIMARY (NAME = 'Pretest_2', FILENAME = 'N:\FPTAptech\SQL Data base\pretest_2.mdf', SIZE = 5MB, MAXSIZE = 50MB, FILEGROWTH = 10%),
FILEGROUP Group1
(NAME = 'FileGroup_Pretest_2', FILENAME = 'N:\FPTAptech\SQL Data base\pretest_2.ndf', SIZE = 10MB, MAXSIZE = UNLIMITED, FILEGROWTH = 5%)
LOG ON (NAME = 'Pretest_log_2', FILENAME = 'N:\FPTAptech\SQL Data base\pretest_2.ldf', SIZE = 2MB, MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
GO

USE Pretest2
GO

CREATE TABLE tbCustomer
(
	CustCode VARCHAR(5) PRIMARY KEY NONCLUSTERED,
	CustName VARCHAR(30) NOT NULL,
	CustAddress VARCHAR(50) NOT NULL,
	CustPhone VARCHAR(15),
	CustEmail VARCHAR(25),
	CustStatus VARCHAR(10) CHECK (CustStatus = 'Valid' OR CustStatus = 'Invalid') DEFAULT 'Valid'
)
GO

CREATE TABLE tbMessage
(
	MsgNo INT PRIMARY KEY IDENTITY(1000,1),
	CustCode VARCHAR(5) CONSTRAINT FK_CustCode FOREIGN KEY REFERENCES dbo.tbCustomer(CustCode),
	MsgDetails VARCHAR(300) NOT NULL,
	MsgDate DATETIME NOT NULL DEFAULT GETDATE(),
	[Status] VARCHAR(10) CHECK ([Status] = 'Pending' OR [Status] = 'Resolved')
)
GO

INSERT dbo.tbCustomer
(
    CustCode,
    CustName,
    CustAddress,
    CustPhone,
    CustEmail,
    CustStatus
)
VALUES  ('C01', 'AAAA', '123abc', '012345678', '123abc@gmail.com', 'Valid'),
		('C02', 'BBBB', '234bcd', '122345678', '234bac@gmail.com', 'Invalid'),
		('C03', 'CCCC', 'adnk12sn', '1239124871', 'adjg122@gmail.com', 'Valid'),
		('C04', 'DDDD', 'adwad131', '3298472871', 'ioejd1@gmail.com', 'Valid'),
		('C05', 'GGGG', 'gmsdk232', '4987147119', 'fsiuw189@gmail.com', 'Invalid')

SET DATEFORMAT DMY
INSERT dbo.tbMessage
(
    CustCode,
    MsgDetails,
    MsgDate,
    Status
)
VALUES  ('C01', 'asjdakjcaskjnj', '31-3-1994', 'Pending'),
		('C03', 'dsrgeafaadad', '12-5-2015', 'Pending'),
		('C05', 'urgsefaefad', '21-7-2017', 'Pending'),
		('C02', 'bdgefawdawda', '12-5-2019', 'Resolved'),
		('C01', 'raefafafafaf', '10-10-2017', 'Resolved')

--4.a Create a clustered index IX_Name for CustName column on tbCustomer table.
CREATE CLUSTERED INDEX IX_Name ON dbo.tbCustomer(CustName)
--b Create a composite index IX_CustMsg fot CustCode and MsgNo columns on tbMessage table
CREATE INDEX IX_CustMsg ON dbo.tbMessage(MsgNo, CustCode)

--5.Write a query to display the list of customers have no message sent yet.
SELECT * FROM dbo.tbCustomer
WHERE CustCode NOT IN (SELECT CustCode FROM dbo.tbMessage)

--6 Create a view vReport which displays messages sent after 1 – Sep – 2017

SET DATEFORMAT DMY
GO
CREATE VIEW vReport AS
SELECT MsgNo, MsgDetails, MsgDate AS DatePost, CustName AS PostedBy, [Status] FROM dbo.tbMessage
JOIN dbo.tbCustomer ON tbCustomer.CustCode = tbMessage.CustCode
WHERE MsgDate > '01-09-2017'
GO
SELECT * FROM dbo.vReport

--7 Create a store procedure uspCountStatus to count and return the number of messages (output parameter) depending on the given status (input parameter)
GO
CREATE PROC uspCountStatus
@Status VARCHAR(30)
AS
BEGIN
	DECLARE @Count INT
    IF @Status IN (SELECT [Status] FROM dbo.tbMessage)
	BEGIN
	    SELECT @Count = COUNT([Status]) FROM dbo.tbMessage WHERE @Status = Status
		PRINT 'Total messages in status ' + @Status + ' is ' + CONVERT(VARCHAR(30), @Count)
	END
	ELSE
	BEGIN
	    PRINT 'Not Exist this Status'
	END
END
GO

EXEC dbo.uspCountStatus @Status = 'Pending' -- varchar(30)
EXEC dbo.uspCountStatus @Status = 'Resolved' -- varchar(30)
EXEC dbo.uspCountStatus @Status = 'any' -- varchar(30)



--8. Create a trigger tgCustomerInvalid for table tbCustomer which will perform rollback transaction when a new
---record is inserted which customer has status is invalid and display appropriate messages.
GO
CREATE TRIGGER tgCustomerInvalid ON dbo.tbCustomer
FOR INSERT AS
	IF (SELECT Inserted.CustStatus FROM Inserted) = 'Invalid'
	BEGIN
	    PRINT 'Invalid is not inserted'
		ROLLBACK
	END
	ELSE
	BEGIN
	    PRINT 'Inserted success!'
	END
GO

INSERT dbo.tbCustomer
(
    CustCode,
    CustName,
    CustAddress,
    CustPhone,
    CustEmail,
    CustStatus
)
VALUES
('C07', 'adwdyubaw', 'adwa12312', '1312414412', 'adwadwa123@gmail.com', 'Valid')
--test
SELECT * FROM dbo.tbCustomer
---Delete dòng đã inserted
DELETE dbo.tbCustomer WHERE CustCode = 'C07'



