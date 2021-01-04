USE HowKteam
GO

CREATE TABLE TestWhile
(
	ID INT PRIMARY KEY IDENTITY(0,1),
	Luong MONEY
)
GO

--Insert 10000 record vào bảng TestWhile mà không trùng ID, Luong tăng dần
DECLARE @i INT = 0
DECLARE @n INT = 10000
DECLARE @Luong INT = 1000

--While (Điều kiện thực hiện) -> Khối lệnh thực hiện
WHILE (@i < @n)
	BEGIN
	    INSERT dbo.TestWhile
	    (Luong)
	    VALUES
	    (@Luong)
		SET @Luong += 5
		SET @i += 1
	END
GO

SELECT * FROM dbo.TestWhile
--DELETE dbo.TestWhile

--Insert 10000 record vào bảng CloneBoMon mà không trùng ID, Tên bộ môn tăng dần
SELECT * INTO CloneBoMon FROM dbo.BOMON --Tạo 1 copy CloneBoMon từ BoMon

DECLARE @i INT = 0
DECLARE @n INT = 10000


--While (Điều kiện thực hiện) -> Khối lệnh thực hiện
WHILE (@i < @n)
	BEGIN
	    INSERT dbo.CloneBoMon
	    (
	        MABM,
	        TENBM,
	        PHONG,
	        DIENTHOAI,
	        TRUONGBM,
	        MAKHOA,
	        NGAYNHANCHUC
	    )
	    VALUES
	    (   @i,      -- MABM - nchar(4)
	        @i,      -- TENBM - nchar(50)
	        'B15',       -- PHONG - char(3)
	        '00000000001',       -- DIENTHOAI - char(11)
	        NULL,      -- TRUONGBM - nchar(3)
	        N'CNTT',      -- MAKHOA - nchar(4)
	        GETDATE() -- NGAYNHANCHUC - date
	        )
		SET @i += 1
	END
GO
--Check
SELECT * FROM dbo.CloneBoMon
