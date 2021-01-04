USE HowKteam
GO

--Trigger sẽ được gọi mỗi khi có thao tác thay đổi thông tin bảng
--Trong trigger có 2 bảng: (chỉ trigger mới có)
--Inserted: Chứa những trường đã insert | Update vào bảng
--Deleted: chứa những trường bị xóa khỏi bảng
CREATE TRIGGER UTG_InsertedGV ON dbo.GIAOVIEN
FOR INSERT
AS
BEGIN
    ROLLBACK --Hủy bỏ, thay đổi, cập nhật bảng
	PRINT 'Trigger'
END

INSERT dbo.GIAOVIEN
(
    MAGV,
    HOTEN,
    LUONG,
    PHAI,
    NGSINH,
    DIACHI,
    GVQLCM,
    MABM
)
VALUES
(   N'012',       -- MAGV - nchar(3)
    N'Trigger',       -- HOTEN - nvarchar(50)
    0.0,       -- LUONG - float
    N'Nam',       -- PHAI - nchar(3)
    GETDATE(), -- NGSINH - date
    N'datataa',       -- DIACHI - nchar(50)
    NULL,       -- GVQLCM - nchar(3)
    N'MMT'        -- MABM - nchar(4)
    )

SELECT * FROM dbo.GIAOVIEN

-----------------------------------------------------------------
--Không cho phép xóa thông tin của GV có tuổi lớn hơn 40