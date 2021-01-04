USE HowKteam
GO

--Tạo Function không có parameter
CREATE FUNCTION UF_SelectAllGV()
RETURNS TABLE
AS RETURN SELECT * FROM dbo.GIAOVIEN
GO

SELECT * FROM dbo.UF_SelectAllGV()

--Tạo Function với parameter
GO
CREATE FUNCTION UF_SelectLuongGV(@MaGV CHAR(10))
RETURNS INT --Luôn phải có Returns <kiểu dữ liệu>
AS
BEGIN
    DECLARE @Luong INT
	SELECT @Luong = LUONG FROM dbo.GIAOVIEN WHERE MAGV = @MaGV
	RETURN @Luong
END
GO

--Sử dụng Function phải đi kèm dbo
SELECT dbo.UF_SelectLuongGV('010') AS LuongGV

SELECT dbo.UF_SelectLuongGV(MAGV) AS LuongGV FROM dbo.GIAOVIEN

--Sửa Function
GO
ALTER FUNCTION UF_SelectLuongGV(@MaGV CHAR(10))
RETURNS INT --Luôn phải có Returns <kiểu dữ liệu>
AS
BEGIN
    DECLARE @Luong INT
	SELECT @Luong = LUONG FROM dbo.GIAOVIEN WHERE MAGV = @MaGV
	RETURN @Luong
END
GO

--Hủy Function
DROP FUNCTION dbo.UF_SelectLuongGV

-----------------------------------------------------------------------
--Tạo Function tính 1 số truyền vào phải là số chẵn hay không
GO
CREATE FUNCTION UF_IsOdd(@Num INT)
RETURNS NVARCHAR(20)
AS
BEGIN
	DECLARE @Text NVARCHAR(20);
	IF (@Num % 2 = 0)
		SET @Text = N'Số chẵn'
	ELSE
		SET @Text = N'Số lẻ'
	RETURN @Text
END

DROP FUNCTION dbo.UF_IsOdd
SELECT dbo.UF_IsOdd(10)
SELECT dbo.UF_IsOdd(11)

--Tạo Function tính tuổi của từng GV là số chẵn hay lẻ
CREATE FUNCTION UF_IsOdd(@Num INT)
RETURNS NVARCHAR(20)
AS
BEGIN
	DECLARE @Text NVARCHAR(20);
	IF (@Num % 2 = 0)
		SET @Text = N'Số chẵn'
	ELSE
		SET @Text = N'Số lẻ'
	RETURN @Text
END

SELECT MAGV,YEAR(GETDATE()) - YEAR(NGSINH) AS Tuoi,dbo.UF_IsOdd(YEAR(GETDATE()) - YEAR(NGSINH)) 
FROM dbo.GIAOVIEN
