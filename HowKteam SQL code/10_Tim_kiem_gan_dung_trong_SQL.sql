USE HowKteam
GO

--Xuất ra thông tin giáo viên mà tên bắt đầu bằng chữ L
SELECT * FROM dbo.GIAOVIEN
WHERE HOTEN LIKE 'L%'

--Xuất ra thông tin giáo viên tên kết thúc bằng chữ n
SELECT * FROM dbo.GIAOVIEN
WHERE HOTEN LIKE '%n'

--Xuất ra thông tin giáo viên tên có tồn tại chữ n
SELECT * FROM dbo.GIAOVIEN
WHERE HOTEN LIKE '%n%'

--Xuất ra thông tin giáo viên tên có tồn tại chữ ế
SELECT * FROM dbo.GIAOVIEN
WHERE HOTEN LIKE N'%ế%'