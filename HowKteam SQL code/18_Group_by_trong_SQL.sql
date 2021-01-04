USE HowKteam
GO

-- Xuất ra Danh sách tên bộ môn và số lượng giáo viên của bộ môn đó
SELECT TENBM, COUNT(*) FROM dbo.BOMON, dbo.GIAOVIEN
WHERE BOMON.MABM = GIAOVIEN.MABM
GROUP BY TENBM

-- cột hiển thị phải là thuộc tính nằm trong khối group by hoặc là Agreegate function

-- Xuất ra Danh sách tên bộ môn và số lượng giáo viên của bộ môn đó
SELECT TENBM, COUNT(*) FROM dbo.BOMON, dbo.GIAOVIEN
WHERE BOMON.MABM = GIAOVIEN.MABM
GROUP BY TENBM, dbo.BOMON.MABM


-- Xuất ra Danh sách tên bộ môn và số lượng giáo viên của bộ môn đó
SELECT TENBM, MAKHOA, COUNT(*) FROM dbo.BOMON, dbo.GIAOVIEN
WHERE BOMON.MABM = GIAOVIEN.MABM
GROUP BY MAKHOA, TENBM

SELECT TENBM, MAKHOA, COUNT(*) FROM dbo.BOMON, dbo.GIAOVIEN
WHERE BOMON.MABM = GIAOVIEN.MABM
GROUP BY TENBM,MAKHOA

-- Lấy ra danh sách giáo viên có lương > lương trung bình của Giáo viên
SELECT * FROM dbo.GIAOVIEN
WHERE LUONG >(SELECT SUM(Luong) FROM dbo.GIAOVIEN)/(SELECT COUNT(*) FROM dbo.GIAOVIEN)

-- Xuất ra tên giáo viên và số lượng đề tài giáo viên đó đã làm
SELECT GV.HOTEN, COUNT(*) FROM dbo.GIAOVIEN AS GV, dbo.THAMGIADT AS TGDT
WHERE gv.MAGV = TGDT.MAGV
GROUP BY GV.MAGV, GV.HOTEN

/*
Bài tập:
1. Xuất ra tên giáo viên và số lượng người thân của GV đó
2. Xuât ra tên giáo viên và số lượng đề tài đã hoàn thành mà giáo viên đó tham gia
3. Xuất ra tên khoa có tổng số lương của giáo viên trong khoa là lớn nhất
*/
--1. Xuất ra tên giáo viên và số lượng người thân của GV đó
SELECT GIAOVIEN.MAGV, HOTEN, COUNT(*) FROM dbo.GIAOVIEN
JOIN dbo.NGUOITHAN
ON NGUOITHAN.MAGV = GIAOVIEN.MAGV
GROUP BY GIAOVIEN.MAGV, HOTEN

--2. Xuât ra tên giáo viên và số lượng đề tài đã hoàn thành mà giáo viên đó tham gia
SELECT GIAOVIEN.MAGV, HOTEN, COUNT(KETQUA) FROM dbo.GIAOVIEN
JOIN dbo.THAMGIADT ON THAMGIADT.MAGV = GIAOVIEN.MAGV
GROUP BY GIAOVIEN.MAGV, HOTEN

--3. Xuất ra tên khoa có tổng số lương của giáo viên trong khoa là lớn nhất

SELECT * FROM dbo.GIAOVIEN
SELECT TENKHOA, SUM(LUONG) AS MaxLuong FROM dbo.KHOA
JOIN dbo.BOMON ON BOMON.MAKHOA = KHOA.MAKHOA
JOIN dbo.GIAOVIEN ON GIAOVIEN.MABM = BOMON.MABM
GROUP BY TENKHOA

SELECT TOP(1) WITH TIES TENKHOA, SUM(LUONG) AS MaxLuong FROM dbo.KHOA
JOIN dbo.BOMON ON BOMON.MAKHOA = KHOA.MAKHOA
JOIN dbo.GIAOVIEN ON GIAOVIEN.MABM = BOMON.MABM
GROUP BY TENKHOA
ORDER BY MaxLuong DESC


/*
Agreeate Function

AVG()	Returns the average value
COUNT()	Returns the number of rows
FIRST()	Returns the first value
LAST()	Returns the last value
MAX()	Returns the largest value
MIN()	Returns the smallest value
ROUND()	Rounds a numeric field to the number of decimals specified
SUM()	Returns the sum
*/


/*
string function

CHARINDEX	Searches an expression in a string expression and returns its starting position if found
CONCAT()	 
LEFT()	 
LEN() / LENGTH()	Returns the length of the value in a text field
LOWER() / LCASE()	Converts character data to lower case
LTRIM()	 
SUBSTRING() / MID()	Extract characters from a text field
PATINDEX()	 
REPLACE()	 
RIGHT()	 
RTRIM()	 
UPPER() / UCASE()	Converts character data to upper case
*/