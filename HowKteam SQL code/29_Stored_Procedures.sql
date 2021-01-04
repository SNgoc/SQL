USE HowKteam
GO

/*
--Store PROCEDURE
-- Là chương trình hay thủ tục
--Ta có thể dùng Transact-SQL EXCUTE (EXEC) để thực thi các stored Procedure.
--Store procedure khác với các hàm xử lý là giá trị trả về của chúng
-- Không chứa trong tên và chúng không được sử dụng trực tiếp trong biểu thức
*/

/*
-- Động: có thể chỉnh sửa khối lệnh, tái sử dụng nhiều lần
--Nhanh hơn: Tự phân tích cú pháp cho tối ưu. Và tạo bản sao để lần chạy sau không cần thực thi lại từ đầu
-- Bảo mật: Giới hạn quyền cho user nào sử dụng, user nào không
-- Giảm Bandwitch: Với các gói transaction lớn. Vài ngàn dòng lệnh 1 lúc thì dùng store sẽ đảm bảo
*/

/*
Cú pháp:

	CREATE PROC <Tên store>
	[Parameter nếu có]
	AS
	Begin
		[Code xử lý]
	End

Nếu chỉ là câu truy vấn thì có thể không cần Begin và End
*/

--VD: truyền parameter (tham số)
CREATE PROC USP_Test
@MaGV NVARCHAR(10), @Luong INT
AS
BEGIN
    SELECT * FROM dbo.GIAOVIEN WHERE MAGV = @MaGV AND @Luong = LUONG
END

--DROP PROC dbo.USP_Test
--Thực thi theo 2 cách:
EXEC dbo.USP_Test @MaGV = N'001',  @Luong = 2000
EXECUTE dbo.USP_Test @MaGV = N'', @Luong = 0
GO

--VD 2: Không truyền parameter
CREATE PROC USP_SelectAllGV
AS SELECT * FROM dbo.GIAOVIEN
GO

EXEC dbo.USP_SelectAllGV
