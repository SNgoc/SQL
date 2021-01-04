USE SQLQuery1
GO


--Tạo Primarykey và đặt tên ngay khi tạo bảng
CREATE TABLE TestPrimaryKey1
(
	PK_Test1 INT PRIMARY KEY, --Primary Key gồm cả Unique và not null
	Name NVARCHAR(20) DEFAULT N'HowKteam.com' -- Default : giá trị mặc định của trường đó nếu không insert
)
GO

INSERT dbo.TestPrimaryKey1
(
    PK_Test1
)
VALUES
(   1  -- PK_Test1 - int
    )
INSERT dbo.TestPrimaryKey1
(
    PK_Test1
)
VALUES
(   2  -- PK_Test1 - int
    )
INSERT dbo.TestPrimaryKey1
(
    PK_Test1
)
VALUES
(   3  -- PK_Test1 - int
    )

-- Tạo khóa chính có 2 trường
CREATE TABLE TestPrimaryKey2
(
	PK_Test2a INT NOT NULL,
	PK_Test2b INT NOT NULL,
	TName NVARCHAR(20) DEFAULT N'HowKteam.vn'
	PRIMARY KEY (PK_Test2a,PK_Test2b)
)
GO
