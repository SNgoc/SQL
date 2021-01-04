USE SQLQuery1
GO
--Thêm dữ liệu
--kiểu số -> số bình thường
-- kiểu ký tự hoặc ngày cần để trong cặp ''
-- nếu là unicode thì cần có N phía trước ''
CREATE TABLE TestS5
(
	MaSo INT,
	Ten NVARCHAR(30),
	NgaySinh DATE,
	GioiTinh CHAR(1),
	DiaChi NVARCHAR(20),
	TienLuong FLOAT
	)
GO
-- thêm dữ liệu vào cột -- chú ý mỗi 1 lần thực thi insert thì sẽ tự thêm vào 1 dòng data, không cần phải copy nhiều lần insert
--Insert dữ liệu với trường mong muốn (nếu xóa 1 trường nào thì trong value cũng phải xóa tương ứng dòng đó để tránh lỗi)
INSERT dbo.TestS5
(
    MaSo,
    Ten,
    NgaySinh,
    GioiTinh,
    DiaChi,
    TienLuong
)
VALUES
(   0,         -- MaSo - int
    N'',       -- Ten - nvarchar(30)
    GETDATE(), -- NgaySinh - date
    '',        -- GioiTinh - char(1)
    N'',       -- DiaChi - nvarchar(20)
    0.0        -- TienLuong - float
    )

-- Insert dữ liệu theo thứ tự của bảng
INSERT dbo.TestS5
VALUES
(   6,         -- MaSo - int
    N'Nguyễn Sơn Ngọc',       -- Ten - nvarchar(30) --tên có dấu
    '19940331', -- NgaySinh - date
    'M',        -- GioiTinh - char(1) -- M hoặc F
    N'Địa chỉ nè',       -- DiaChi - nvarchar(20)
    66000        -- TienLuong - float
    )
--Xóa dữ liệu
-- nếu chỉ Delete <Tên bảng> thì sẽ xóa toàn bộ
-- xóa trường mong muốn dùng thêm Where
-- các toán tử: > , < , >= , <= , <> (khác), And, Or, =

-- Xóa toàn bộ bảng
--DELETE dbo.TestS5

--Xóa với điều kiện
DELETE dbo.TestS5 WHERE ((MaSo > 10 AND MaSo < 20) OR GioiTinh = 'M') AND TienLuong > 25000

--Update dữ liệu
--Update dữ liệu toàn bộ bảng với 1 hoặc nhiều trường update
UPDATE dbo.TestS5 SET TienLuong = 313, DiaChi = N'Địa chỉ đây' --viết có dấu phải có N trước ''

-- Update dữ liệu của trường mong muốn với Where
UPDATE dbo.TestS5 SET TienLuong = 30000, DiaChi = N'Địa chỉ nè' WHERE GioiTinh = 'F' AND MaSo > 15
UPDATE dbo.TestS5 SET TienLuong = 15000, DiaChi = N'Địa chỉ nè' WHERE GioiTinh = 'F' AND MaSo > 10 AND MaSo < 15
UPDATE dbo.TestS5 SET TienLuong = 10000, DiaChi = N'Địa chỉ đây' WHERE GioiTinh = 'M' AND MaSo > 10
-- Sắp xếp dữ liệu theo thứ tự: ASC là tăng dần, DESC là giảm dần
SELECT * FROM dbo.TestS5
ORDER BY MaSo ASC