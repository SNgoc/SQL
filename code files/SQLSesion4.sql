
SELECT CONVERT(INT, 3.4)

--Điểm của bạn là 50
PRINT 'Diem cua ban la' + CONVERT(VARCHAR(20),50);

--Date and time function
-- Lay ngay hien tai
SELECT GETDATE() AS CurrentDate
--Tính tuổi
SELECT DATEDIFF(YEAR,'2000/2/12',GETDATE()) AS Age

SET DATEFORMAT DAY
SELECT DATEDIFF(YEAR,'12/2/2000',GETDATE()) AS Age

SELECT DATEADD(YEAR, 2, '12/2/2000') AS date_add_year
SELECT DATEADD(MONTH, 2, '12/2/2000') AS date_add_month

--Lấy ngày hoặc tháng hoặc năm
SELECT YEAR(GETDATE()) AS current_year
SELECT MONTH(GETDATE()) AS current_month
SELECT DAY(GETDATE()) AS current_day

--mathematical function
SELECT RAND() AS random --hàm random

--generate number from 5 to 10 ( 5 < number < 10)
SELECT RAND() * (10-5) + 5

SELECT ROUND(2.345, 2) AS round_number
SELECT CEILING(2.345) AS ceiling_number
SELECT FLOOR(2.345) AS floor_number

--String function
SELECT SUBSTRING('SQL Tutorial', 1, 3) AS sub_string
SELECT LEFT('SQL Tutorial', 3) AS left_string
SELECT RIGHT('SQL Tutorial', 3) AS right_string
SELECT LEN('SQL Tutorial   ') AS len_string --Không đếm khoảng cách phía sau string
SELECT DATALENGTH('SQL Tutorial   ') AS datalength_string -- tính luôn khoảng cách sau string
SELECT RTRIM('SQL Tutorial   ') AS right_trim --cắt khoảng trống không cần thiết sau string
SELECT REPLACE('SQL Tutorial', 'Tu', 'Mu') AS replace_string -- Thay thế 1 ký tự trong string bằng ký tự khác
SELECT REPLICATE('SQL', 3) AS replicate_string

USE Sale
GO

SELECT * FROM dbo.OrderItem
-- Hãy thống kê xem bán được bao nhiêu sản phẩm
SELECT SUM(Quantity) AS TongSoLuong
FROM dbo.OrderItem
-- Hãy tính giá trung bình của các sản phẩm
SELECT AVG(Price) AS GiaTrungBinh
FROM dbo.Item

SELECT * FROM dbo.Item
--Giá cao nhất của sản phẩm là
SELECT MAX(Price) AS MaxPrice FROM dbo.Item
--Giá thấp nhất của sản phẩm là
SELECT MIN(Price) AS MinPrice FROM dbo.Item
-- Có bao nhiêu sản phẩm trong hệ thống
--Cách 1
SELECT COUNT(itemID) AS SoSanPham_Column FROM dbo.Item

--Không tính sản phẩm để null tên
SELECT COUNT(itemName) AS SoSanPham_Column_Null FROM dbo.Item

--Cách 2
SELECT COUNT(*) AS SoSanPham FROM dbo.Item --để dấu * thay thế cho

--Nhà cung cấp s1 có bao nhiêu sản phẩm
SELECT COUNT(*) FROM dbo.Item
WHERE SupplierID = 's1' --Like

--Mỗi nhà cung cấp có bao nhiêu sản phẩm
SELECT SupplierID, COUNT(*) AS SoLuong FROM dbo.Item
GROUP BY SupplierID

--Khai báo biến
DECLARE @age INT
SELECT @age = 20 --SET @age=20 (gán giá trị cho biến)
SELECT @age			--Lấy giá trị của biến