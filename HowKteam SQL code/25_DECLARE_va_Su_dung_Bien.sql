USE HowKteam
GO

--Tìm ra mã GV có lương thấp nhất
SELECT MAGV FROM dbo.GIAOVIEN
WHERE LUONG = (SELECT MIN(LUONG) FROM dbo.GIAOVIEN)

--Lấy ra tuổi của GV với lương thấp nhất
--cách 1:
SELECT YEAR(GETDATE()) - YEAR(NGSINH) FROM dbo.GIAOVIEN
WHERE MAGV = (SELECT MAGV FROM dbo.GIAOVIEN WHERE LUONG = (SELECT MIN(LUONG) FROM dbo.GIAOVIEN))

-------------------------------------------
--cách 2: tạo 1 biến kiểu char lưu mã GV lương thấp nhất
DECLARE @MinSalaryMaGV CHAR(10)
SELECT @MinSalaryMaGV = MAGV FROM dbo.GIAOVIEN WHERE LUONG = (SELECT MIN(LUONG) FROM dbo.GIAOVIEN)

SELECT YEAR(GETDATE()) - YEAR(NGSINH) FROM dbo.GIAOVIEN
WHERE MAGV = @MinSalaryMaGV

---------------------------------------------------------------------------------------------
--Khởi tạo với kiểu dữ liệu
--Lưu ý: Biến bắt đầu với ký hiệu @
DECLARE @i INT

--Khởi tạo với giá trị mặc định
DECLARE @j INT = 0

--set dữ liệu cho biến
SET @i = @i + 1
SET @i += 1
SET @j *= @i

--set thông qua câu Select
DECLARE @MaxLuong INT
SELECT @MaxLuong = MAX(LUONG) FROM dbo.GIAOVIEN

--Bài tập
--1.Xuất ra số lượng người thân của giáo viên 001

DECLARE @MaGV CHAR(10) = '003'

SELECT COUNT(*) FROM dbo.NGUOITHAN
WHERE MAGV = @MaGV

--2. Xuất ra tên của GV có lương thấp nhất (print)
DECLARE @MinSalary INT
DECLARE @TenGV NVARCHAR(100)

SELECT @MinSalary = MIN(LUONG) FROM dbo.GIAOVIEN
SELECT @TenGV = HOTEN FROM dbo.GIAOVIEN WHERE LUONG = @MinSalary

--Xuất giá trị ra màn hình
PRINT @TenGV + N' có lương thấp nhất là: ' + CONVERT(VARCHAR(20),@MinSalary) --Lưu ý nếu kết hợp với text phải đổi kiểu sang hết cùng kiểu type thì mới print được
PRINT @MinSalary + @TenGV -- lỗi vì không cùng kiểu type
