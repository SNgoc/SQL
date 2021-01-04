--1
CREATE DATABASE SchoolDB
ON PRIMARY
( NAME = 'baithi.mdf', FILENAME ='N:\FPTAptech\SQL Data base\baithi.mdf' , SIZE = 10MB ,
MAXSIZE = UNLIMITED, FILEGROWTH = 1MB ),
FILEGROUP [Group1]
( NAME = 'baithi.ndf', FILENAME = 'N:\FPTAptech\SQL Data base\baithi.ndf' , SIZE = 10MB , 
MAXSIZE = UNLIMITED, FILEGROWTH = 1MB )
LOG ON
( NAME = 'baithi.ldf', FILENAME = 'N:\FPTAptech\SQL Data base\baithi.ldf' , 
SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10% )
GO

USE SchoolDB
GO

--2
CREATE TABLE tbBatch(
	BatchNo Varchar(10) PRIMARY KEY,
	SIZE INT,
	TimeSlot Varchar(20)
)
GO
ALTER TABLE dbo.tbBatch ADD CHECK (SIZE < 5)

CREATE TABLE tbStudent(
	Rollno Int IDENTITY PRIMARY KEY NONCLUSTERED,
	LastName Varchar(20),
	FirstName Varchar(20),
	Gender VARCHAR(1),
	DOB DATE,
	BatchNo VARCHAR(10)
)
GO

ALTER TABLE dbo.tbStudent
ADD CONSTRAINT fk1 FOREIGN KEY (BatchNo) REFERENCES dbo.tbBatch(BatchNo)
--5
INSERT INTO dbo.tbBatch

VALUES
(   '1', -- BatchNo - varchar(10)
    3,  -- SIZE - int
    '45'  -- TimeSlot - varchar(20)
    ),
	('2',2,'50'),
	('3',4,'33')
GO

SET DATEFORMAT DMY
INSERT INTO dbo.tbStudent
VALUES
(   'Linh',        -- LastName - varchar(20)
    'VO',        -- FirstName - varchar(20)
    'M',        -- Gender - varchar(1)
    '10/10/2000', -- DOB - date
    '1'         -- BatchNo - varchar(10)
    ),
	('Trang','Le','F','7/10/1995','2'),('Huy','Phan','M','6/9/2002','1'),('Vy','Nguyen','F','3/2/1990','2')
GO

SELECT * FROM dbo.tbStudent
--3
ALTER TABLE dbo.tbStudent ADD CHECK(Gender = 'M' OR Gender = 'F')
--Test check query
INSERT dbo.tbStudent
(
    LastName,
    FirstName,
    Gender,
    DOB,
    BatchNo
)
VALUES ('Truc Linh','Tran Thanh','L','3/2/2003','3')

--4
SELECT * FROM dbo.tbBatch
WHERE SIZE<5
--6
CREATE CLUSTERED INDEX Idx_Name ON dbo.tbStudent(FirstName)
--7
GO

CREATE VIEW v_SchoolGirl
AS
SELECT *
FROM dbo.tbStudent
WHERE Gender = 'F'
GO

SELECT * FROM dbo.v_SchoolGirl