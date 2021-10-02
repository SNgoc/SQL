CREATE DATABASE PKKey_FKKey
ON PRIMARY (NAME = 'PKKey_FKKey', FILENAME = 'N:\FPTAptech\SQL Data base\PKKey_FKKey.mdf')
LOG ON
(NAME = 'PKKey_FKKey_Log', FILENAME = 'N:\FPTAptech\SQL Data base\PKKey_FKKey_log.ldf')
 GO

 USE PKKey_FKKey
 GO

 --Điều kiện để tạo FK
 -- tham chiếu tới PK, unique, not null, cùng kiểu dữ liệu, cùng số lượng trường có sắp xếp
 CREATE TABLE GiaoVien
 (	MaGV INT NOT NULL,
	TenGV NVARCHAR(20) DEFAULT N'Tên Giáo viên',
	DiaChi NVARCHAR(30) DEFAULT N'Địa chỉ Giáo viên',
	NgaySinh DATE,
	GioiTinh VARCHAR(6) DEFAULT 'Female',

	PRIMARY KEY(MaGV)
	)
GO

--xóa bảng
--DROP TABLE dbo.GiaoVien

CREATE TABLE BoMon
(	MaBM CHAR(10) PRIMARY KEY,
	TenBM NVARCHAR(15) DEFAULT N'Tên bộ môn'
	)
GO

--đặt tên key để xóa cho dễ
ALTER TABLE dbo.GiaoVien ADD BoMon CHAR(10)
ALTER TABLE dbo.GiaoVien ADD CONSTRAINT FK_BM FOREIGN KEY(BoMon) REFERENCES dbo.BoMon(MaBM)

CREATE TABLE Lop
(	MaLop CHAR(5) NOT NULL ,
	TenLop CHAR(5) DEFAULT '10A3'

	PRIMARY KEY(MaLop)
)
GO

CREATE TABLE HocSinh
(	MaHS INT NOT NULL PRIMARY KEY,
	TenHS NVARCHAR(15) DEFAULT N'Tên học sinh'
	)
GO
ALTER TABLE dbo.HocSinh ADD MaLop CHAR(5)
ALTER TABLE dbo.HocSinh ADD CONSTRAINT FK_Lop FOREIGN KEY(MaLop) REFERENCES dbo.Lop(MaLop)

--Hủy khóa
--ALTER TABLE dbo.HocSinh DROP CONSTRAINT FK_Lop
--ALTER TABLE dbo.GiaoVien DROP CONSTRAINT FK_BM

--Thêm dữ liệu
INSERT INTO dbo.BoMon
VALUES
(   'BM1', -- MaBM - char(10)
    N'Toán' -- TenBM - nvarchar(15)
    ), ('BM2', N'Văn'), ('BM3', N'Anh')

INSERT INTO dbo.GiaoVien
VALUES
(   1,         -- MaGV - int
    N'Giáo viên 1',       -- TenGV - nvarchar(20)
    N'Địa chỉ 1',       -- DiaChi - nvarchar(30)
    '1993/08/25', -- NgaySinh - date
    'Female',        -- GioiTinh - varchar(6)
    'BM1'         -- BoMon - char(10)
    ), (2,N'Giáo viên 2', N'Địa chỉ 2', '1995/05/30', 'Female', 'BM2'), (3,N'Giáo viên 3', N'Địa chỉ 3', '1995/05/30', 'Female', 'BM2'),
	(4,N'Giáo viên 4', N'Địa chỉ 4', '1994/03/31', 'Male', 'BM3')

--Xóa dữ liệu dòng
--DELETE dbo.GiaoVien WHERE MaGV = 102

SELECT*FROM dbo.GiaoVien


 
