USE HowKteam
GO

-- Tạo index trên bảng giáo viên
-- Tăng tốc độ tìm kím <> Chậm tốc độ thêm, xóa, sưa
-- Cho phép các trường trùng nhau
CREATE INDEX IndexName ON dbo.NGUOITHAN(MaGV)

-- Không Cho phép các trường trùng nhau
CREATE UNIQUE INDEX IndexNameUnique ON dbo.GIAOVIEN(MaGV)

SELECT * FROM dbo.NGUOITHAN
WHERE MAGV = '001' AND TEN = 'Tes999999'