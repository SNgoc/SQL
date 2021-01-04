USE PretestDB
GO

CREATE DATABASE PretestDB
ON PRIMARY (NAME = 'Pretest', FILENAME = 'N:\FPTAptech\SQL Data base\pretest.mdf', SIZE = 5MB, MAXSIZE = 50MB, FILEGROWTH = 10%),
FILEGROUP Group1
(NAME = 'FileGroup_Pretest', FILENAME = 'N:\FPTAptech\SQL Data base\pretest.ndf', SIZE = 10MB, MAXSIZE = UNLIMITED, FILEGROWTH = 5%)
LOG ON (NAME = 'Pretest_log', FILENAME = 'N:\FPTAptech\SQL Data base\pretest.ldf', SIZE = 2MB, MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
GO

CREATE TABLE tbCustomer(
	CustCode VARCHAR(5) PRIMARY KEY NONCLUSTERED,
	CustName VARCHAR(30) NOT NULL,
	CustAddress VARCHAR(50) NOT NULL,
	CustPhone VARCHAR(15),
	CustEmail VARCHAR(25),
	CustStatus VARCHAR(10) DEFAULT 'Valid' CHECK (CustStatus = 'Valid' OR CustStatus = 'Invalid')
)
GO

CREATE TABLE tbMessage
(
	MsgNo INT IDENTITY(1000,1) PRIMARY KEY,
	CustCode VARCHAR(5) FOREIGN KEY REFERENCES dbo.tbCustomer,
	MsgDetails VARCHAR(300) NOT NULL,
	MsgDate DATE NOT NULL DEFAULT GETDATE(),
	Status VARCHAR(10) CHECK (Status = 'Pending' OR Status = 'Resolved')
)
GO

INSERT INTO dbo.tbCustomer
VALUES
(   'C001', -- CustCode - varchar(5)
    'Rahul Khana', -- CustName - varchar(30)
    '7th Cross Road', -- CustAddress - varchar(50)
    '298345878', -- CustPhone - varchar(15)
    ' khannar@hotmail.com', -- CustEmail - varchar(25)
    'Valid'  -- CustStatus - varchar(10)
),	('C002', 'Anil Thakkar', 'Line Ali Road', '657654323', 'Thakkar2002@yahoo.com', 'Valid'),	('C004', 'Sanjay Gupta', 'Link Road', '367654323', 'SanjayG@indiatimes.com', 'Invalid'),	('C005', 'Sagar Vyas', 'Link Road', '376543255', 'Sagarvyas@india.com', 'Valid')
GO

SET DATEFORMAT DMY
INSERT INTO dbo.tbMessage
VALUES
(   'C001',        -- CustCode - varchar(5)
    'Voice mail always give ACCESS DENIED message',        -- MsgDetails - varchar(300)
    '31/08/2017', -- MsgDate - datetime
    'Pending'         -- Status - varchar(10)
),	('C005', 'Voice mail activation always give NO ACCESS message', '01/09/2017', 'Pending'),
	('C001', 'Please send all future bill to my residential address instead of my office address', '05/09/2017', 'Resolved'),
	('C004', 'Please send new monthly brochure …', '08/11/2017', 'Pending')
GO

--4
--a. Create a clustered index IX_Name for CustName column on tbCustomer table.
CREATE CLUSTERED INDEX IX_Name ON dbo.tbCustomer(CustName)
GO

--b. Create a composite index IX_CustMsg fot CustCode and MsgNo columns on tbMessage tableCREATE INDEX IX_CustMsg ON dbo.tbMessage(CustCode, MsgNo)--5. Write a query to display the list of customers have no message sent yet.SELECT * FROM dbo.tbCustomerWHERE tbCustomer.CustCode NOT IN (SELECT CustCode FROM dbo.tbMessage)--6. Create a view vReport which displays messages sent after 1 – Sep – 2017 as following:

----MsgNo	MsgDetails					DatePosted			PostedBy		Status
----1002	Please send all future …	09/05/2017			RahulKhana		Resolved
----1003	Please send new…			08/11/2017			Sagar Vyas		Pending

--định dạng ngày thành DMY nếu so sánh theo kiểu DMY
SET DATEFORMAT DMY
GO
CREATE VIEW vReport AS
SELECT MsgNo, MsgDetails, MsgDate AS DatePosted, CustName AS PostedBy, Status --khi tạo view từ nhiều bảng phải chọn cột ko để * sẽ bị lỗi
FROM dbo.tbMessage
JOIN dbo.tbCustomer ON tbCustomer.CustCode = tbMessage.CustCode
AND MsgDate > '01-09-2017'
GO

SET DATEFORMAT DMY--Chạy dòng này trước để ra đúng
SELECT * FROM dbo.vReport

--7. Create a store procedure uspCountStatus to count and return the number of messages (output parameter) depending on the given status (input parameter)
--Tao store procedure co 2 tham so, 1 input parameter la status cua message
--Va 1 output la tong so luong message theo status
SELECT * FROM dbo.tbCustomer
SELECT * FROM dbo.tbMessage
GO

CREATE PROC uspCountStatus @status varchar(40), @count int OUTPUT
AS
	SELECT @count = COUNT([Status])										
	FROM dbo.tbMessage						
	WHERE [Status] = @status										
GO

--Goi ham
DECLARE @CountStatus int
EXEC uspCountStatus 'Pending', @CountStatus OUTPUT --gán giá trị kết quả đếm 'Pending' vào biến @CountStatus
PRINT 'Tong status message "Pending" la ' + CONVERT(varchar(40), @CountStatus)
GO


DECLARE @CountStatus int
EXEC uspCountStatus 'Resolved', @CountStatus OUTPUT
PRINT 'Tong status message "Resolved" la ' + CONVERT(varchar(40), @CountStatus)
GO

SELECT * FROM dbo.tbMessage


--8. Create a trigger tgCustomerInvalid for table tbCustomer which will perform rollback transaction when a new
---record is inserted which customer has status is invalid and display appropriate messages.
go
CREATE TRIGGER tgCustomerInvalid
ON dbo.tbCustomer
FOR INSERT AS
	IF (SELECT Inserted.CustStatus FROM inserted) = 'Invalid'
	BEGIN
	    PRINT 'Cannot insert Customer data because Customer''s Status Invalid' --sử dụng ''s trong ' ' để tạo 's
		ROLLBACK
	END
GO


INSERT INTO dbo.tbCustomer
VALUES
(   'C003', -- CustCode - varchar(5)
    'ABCD', -- CustName - varchar(30)
    'Line Ali Road', -- CustAddress - varchar(50)
    '657658323', -- CustPhone - varchar(15)
    '1234abcd@gmail.com', -- CustEmail - varchar(25)
    'Invalid'  -- CustStatus - varchar(10)
    )
--Test
SELECT * FROM dbo.tbCustomer
--Delete test
DELETE dbo.tbCustomer WHERE CustCode = 'C003'