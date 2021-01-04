USE HowKteam
GO

CREATE TABLE TestAuto
(
	ID INT PRIMARY KEY IDENTITY , 
	-- tự tăng trường này. Phải là số. 
	-- Mặc định bắt đầu từ 1. và tăng 1 đơn vị
	Name NVARCHAR(100)
)
GO

INSERT dbo.TestAuto( Name )VALUES (N'')
INSERT dbo.TestAuto( Name )VALUES (N'')
INSERT dbo.TestAuto( Name )VALUES (N'')
INSERT dbo.TestAuto( Name )VALUES (N'')
INSERT dbo.TestAuto( Name )VALUES (N'')
INSERT dbo.TestAuto( Name )VALUES (N'')
INSERT dbo.TestAuto( Name )VALUES (N'')

CREATE TABLE TestAuto2
(
	ID INT PRIMARY KEY IDENTITY(5, 10), -- Tự tăng. Bắt đầu từ 5. Mỗi lần tăng 10 đơn vị
	Name NVARCHAR(100)
)
GO

INSERT dbo.TestAuto2( Name )VALUES (N'')
INSERT dbo.TestAuto2( Name )VALUES (N'')
INSERT dbo.TestAuto2( Name )VALUES (N'')
INSERT dbo.TestAuto2( Name )VALUES (N'')
INSERT dbo.TestAuto2( Name )VALUES (N'')
INSERT dbo.TestAuto2( Name )VALUES (N'')
INSERT dbo.TestAuto2( Name )VALUES (N'')
