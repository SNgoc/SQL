USE HowKteam
GO

--Khi có nhu cầu duyệt từng record của bảng. Với mỗi record có kết quả xử lý riêng thì dùng cursor

--Declare <Tên con trỏ> cursor for <câu select (truy vấn)>
--Open <Tên con trỏ>

--FETCH NEXT FROM <Tên con trỏ> INTO <Danh sách các biến tương ứng với kết quả truy vấn>

--WHILE @@FETCH_STATUS = 0
--BEGIN
--Câu lệnh thực hiện
--FETCH NEXT lại lần nữa
--FETCH NEXT FROM <Tên con trỏ> INTO <Danh sách các biến tương ứng kết quả truy vấn>
--END

--CLOSE <tên con trỏ>
--DEALLOCATE <tên con trỏ>

------------------------------------------------------------------------------------
-- Từ tuổi của GV
-- Nếu > 40 thì cho Lương là 2500
-- Nếu < 40 và > 30 thì cho lương là 2000
--Ngược lại thì lương là 1500

--Lấy ra danh sách mã GV kèm tuổi đưa vào con trỏ có tên là GiaoVienCursor
DECLARE GiaoVienCursor CURSOR FOR SELECT MAGV, YEAR(GETDATE()) - YEAR(NGSINH) FROM dbo.CloneGV

OPEN GiaoVienCursor

DECLARE @MaGV CHAR(10)
DECLARE @Tuoi INT

FETCH NEXT FROM GiaoVienCursor INTO @MaGV, @Tuoi

WHILE @@FETCH_STATUS = 0
BEGIN
    IF @Tuoi > 40
    BEGIN
         UPDATE dbo.CloneGV SET LUONG = 2500 WHERE MAGV = @MaGV
    END
	ELSE
	IF @Tuoi > 30
	BEGIN
         UPDATE dbo.CloneGV SET LUONG = 2000 WHERE MAGV = @MaGV
    END
	ELSE
	BEGIN
         UPDATE dbo.CloneGV SET LUONG = 1500 WHERE MAGV = @MaGV
    END

	FETCH NEXT FROM GiaoVienCursor INTO @MaGV, @Tuoi
END

CLOSE GiaoVienCursor --đóng con trỏ
DEALLOCATE GiaoVienCursor --hủy con trỏ

SELECT * FROM dbo.CloneGV

