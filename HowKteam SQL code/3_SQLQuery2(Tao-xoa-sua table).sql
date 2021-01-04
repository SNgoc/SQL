CREATE DATABASE SQLQuery1
GO
--Luôn sử dụng GO khi tạo hay xóa 1 cái gì đó

--Sử dụng ngay lập tức DB vừa tạo ở trên
USE SQLQuery1

--Tạo Table Giáo viên có 2 thuộc tính
-- Dùng kiểu dữ liệu nvarchar để lưu dữ liệu tiếng việt có dấu
CREATE TABLE GiaoVien
(
	MaGV INT NOT NULL,
	Name NVARCHAR(50)
)
GO

CREATE TABLE HocSinh
(
	MaHS INT NOT NULL,
	Name NVARCHAR(50)
)
GO

CREATE TABLE LopHoc
(
	Khoi NVARCHAR(10),
	TenLop NVARCHAR(10) NOT NULL
)
GO

--Xóa toàn bộ data trong Table, không xóa cột hay Table
TRUNCATE TABLE dbo.LopHoc

--Xóa Table
DROP TABLE dbo.LopHoc
GO

--Thêm cột vào table
ALTER TABLE dbo.HocSinh ADD NgaySinh DATE
