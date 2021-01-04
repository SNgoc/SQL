USE SQLQuery1
GO

-- Tạo bảng dữ liệu xe
CREATE TABLE TestS5_Car
(
	BienSo VARCHAR(15),
	MauXe NVARCHAR(10),
	HangXe VARCHAR(15),
	KieuXe NVARCHAR(15),
	SoChoNgoi INT,
	XeMoi CHAR(1),
	GiaXe FLOAT,
	DonGia NVARCHAR(10),
	DonViTinh VARCHAR(3)
)
GO

--Xóa bảng xe
--DROP TABLE dbo.TestS5_Car

-- Thêm data vào bảng xe
INSERT dbo.TestS5_Car
VALUES
(   '70C2-9415000',  -- BienSo - varchar(15)
    N'Xám', -- MauXe - nvarchar(10)
    'Toyota',  -- HangXe - varchar(15)
    N'Xe Container', -- KieuXe - nvarchar(15)
    2,   -- SoChoNgoi - int
    'N',  -- XeMoi - char(1) -- Y nếu xe mới, N nếu xe cũ
    3500, -- GiaXe - float
    N'Triệu', -- DonGia - nvarchar(10)
    'VND'   -- DonViTinh - varchar(3)
    )

-- Update giá xe với điều kiện
UPDATE dbo.TestS5_Car SET GiaXe = 2900, MauXe = N'Trắng' WHERE BienSo = '' AND KieuXe = N'Xe tải'

-- Xóa data với điều kiện
DELETE  dbo.TestS5_Car WHERE BienSo = '70A1-4951000'
-- Sắp xếp bảng dữ liệu theo thứ tự ASC tăng dần, DESC giảm dần
SELECT * FROM dbo.TestS5_Car
ORDER BY GiaXe ASC