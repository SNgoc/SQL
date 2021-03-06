USE HowKteam
GO

SELECT * FROM dbo.GIAOVIEN

-- Tạo ra một bảng lưu thông tin Giáo viên, tên bộ môn và lương của giáo viên đó
SELECT HOTEN, TENBM, LUONG INTO LuongGiaoVien FROM dbo.GIAOVIEN, dbo.BOMON
WHERE BOMON.MABM = GIAOVIEN.MABM

SELECT * FROM luonggiaovien

UPDATE dbo.GIAOVIEN SET LUONG = 90000
WHERE MAGV = '006'

SELECT * FROM dbo.GIAOVIEN

-- View là bảng ảo
-- Cập nhật dữ liệu theo bảng mà view truy vấn tới mỗi khi lấy view ra sài

-- Tạo ra view TestView từ câu truy vấn
--Cần có GO trước và sau khi tạo view để không bị báo lỗi
GO
CREATE VIEW TestView
AS
SELECT * FROM dbo.GIAOVIEN
GO

SELECT * FROM testview

UPDATE dbo.GIAOVIEN SET LUONG = 90
WHERE MAGV = '006'

SELECT * FROM TestView

-- xóa view
DROP VIEW TestView

-- update view
Alter VIEW TestView as
SELECT HOTEN FROM dbo.GIAOVIEN

-- tạo view có dấu
GO
CREATE VIEW [Giáo dục miễn phí] AS
SELECT * FROM dbo.KHOA
GO

SELECT * FROM [Giáo dục miễn phí]

--Tạo viewGV với data đã được sắp xếp sẵn với lương xếp từ cao xuống thấp
--Sử dụng lệnh ORDER BY LUONG DESC OFFSET 0 ROWS
GO
CREATE VIEW ViewGV AS
SELECT * FROM dbo.GIAOVIEN
ORDER BY LUONG DESC OFFSET 0 ROWS
GO

--DROP VIEW dbo.ViewGV
SELECT * FROM dbo.ViewGV