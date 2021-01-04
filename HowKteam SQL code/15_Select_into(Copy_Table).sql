USE HowKteam
GO

--Copy hết dữ liệu của bảng GV đưa vào bảng mới tên là TableA
--bảng này có các record tương ứng như bảng GV
SELECT * INTO TableA
FROM dbo.GIAOVIEN

--Tạo ra 1 bảng TableB mới, có 1 cột là HoTen tương ứng như bảng GV
--Dữ liệu của bảng TableB lấy từ bảng GV ra
SELECT HoTen INTO TableB
FROM dbo.GIAOVIEN

--Tạo ra 1 bảng TableB mới, có 1 cột là HoTen tương ứng như bảng GV
--Với điều kiện lương > 2000
--Dữ liệu của bảng TableB lấy từ bảng GV ra
SELECT HoTen INTO TableC
FROM dbo.GIAOVIEN

--Tạo ra 1 bảng mới từ nhiều bảng
SELECT MAGV, HOTEN, TENBM INTO GVBACKUP
FROM dbo.GIAOVIEN, dbo.BOMON
WHERE BOMON.MABM = GIAOVIEN.MABM

--Tạo ra 1 bảng GVBK y chang nhưng không có dữ liệu
SELECT * INTO GVBK
FROM dbo.GIAOVIEN
WHERE 0>1 -- điều kiện phải false