USE HowKteam
GO

--VD1: Kiểm tra xem lương của GV nhập vào có lớn hơn lương TB hay không
DECLARE @LuongTrungBinh INT
DECLARE @SoLuongGV INT

SELECT @SoLuongGV = COUNT(*) FROM dbo.GIAOVIEN
SELECT @LuongTrungBinh = AVG(LUONG) FROM dbo.GIAOVIEN

DECLARE @MaGV CHAR(10) = '001'
DECLARE @LuongMaGV INT = 0

SELECT @LuongMaGV = LUONG FROM dbo.GIAOVIEN WHERE MAGV = @MaGV
--Nếu lương của @LuongMaGV > @LuongTrungBinh thì:
--Xuất ra lớn hơn
--Ngược lại xuất ra Nhỏ hơn
IF @LuongMaGV > @LuongTrungBinh
	BEGIN
		PRINT @LuongMaGV
		PRINT N'Lớn hơn'
		PRINT @LuongTrungBinh
	END
ELSE
	BEGIN
		PRINT @LuongMaGV
		PRINT N'Nhỏ hơn'
		PRINT @LuongTrungBinh
	END

--VD2: update lương của toàn bộ GV nếu lương nhập vào cao hơn lương Tb
--Ngược lại chỉ update lương của GV nữ
DECLARE @LuongTrungBinh2 INT
DECLARE @SoLuongGV2 INT

SELECT @SoLuongGV2 = COUNT(*) FROM dbo.GIAOVIEN
SELECT @LuongTrungBinh2 = AVG(LUONG) FROM dbo.GIAOVIEN

DECLARE @Luong INT = 1500
--trước khi update
SELECT * FROM dbo.GIAOVIEN

IF (@Luong > @LuongTrungBinh2)
	BEGIN
	    UPDATE dbo.GIAOVIEN SET LUONG = @Luong
	END
ELSE
	BEGIN
	    UPDATE dbo.GIAOVIEN SET LUONG = @Luong
		WHERE PHAI = N'Nữ'
	END

--sau khi update
 SELECT * FROM dbo.GIAOVIEN