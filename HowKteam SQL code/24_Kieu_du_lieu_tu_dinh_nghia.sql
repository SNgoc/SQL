USE HowKteam
GO

--Kiểu dữ liệu tự định nghĩa: Tức chỉ cần lấy tên đã đặt khi tạo gán vào trường tạo bảng sẽ tự dịnh nghĩa kiểu dữ liệu, ko cần tự tạo
-- EXEC sp_addtype 'Tên kiểu dữ liệu', 'Kiểu dữ liệu thực tế', 'Not Null' (Có hay ko đều được)
EXEC sp_addtype 'NNAME', 'NVARCHAR(100)', 'NOT NULL'

CREATE TABLE TestType1
(
	Name NNAME,
	Address NVARCHAR(500)
)
GO

EXEC sp_addtype 'ADDRESS', 'NVARCHAR(500)'

--Xóa type
--Không xóa được NNAME vì trường này đang được sử dụng bởi bảng khác
EXEC sp_droptype 'NNAME'
--Xóa được ADDRESS vì trtruong72ay2 không có bảng nào đang sử dụng
EXEC sp_droptype 'ADDRESS'