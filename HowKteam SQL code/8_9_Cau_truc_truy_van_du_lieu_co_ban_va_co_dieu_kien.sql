--Chạy script Query trước khi chạy thử
USE HowKteam
GO

--Cấu trúc truy vấn dữ liệu
SELECT * FROM dbo.BOMON --Lấy hết các dữ liệu trong bảng bộ môn ra

--lấy mã Bm + tên Bm trong bảng bộ môn
SELECT MABM, TENBM FROM dbo.BOMON

--Đổi tên cột hiển thị
SELECT MABM AS N'Đổi tên cột', TENBM AS N'Giáo dục' FROM dbo.BOMON

-- Xuất ra mã GV + tên + tên BM giáo viên đó dạy
SELECT GV.MAGV, GV.HOTEN, BM.TENBM 
FROM dbo.GIAOVIEN AS GV, dbo.BOMON AS BM -- Gom nhóm nhiều bảng lại đặt "," sau mỗi bảng (sẽ ra 1 tổ hợp nhiều giá trị trùng) 
-- đặt tên mỗi cột để khỏi nhầm và lấy dữ liệu từ cột đó.

--Bài tập
--1. Truy xuất thông tin của bảng Tham gia đề tài
SELECT * FROM dbo.THAMGIADT

--2. Lấy ra Mã khoa và Tên khoa tương ứng
SELECT * FROM dbo.KHOA
SELECT MAKHOA AS N'Mã Khoa', TENKHOA AS N'Tên Khoa' FROM dbo.KHOA

--3. Lấy ra Mã GV, tên GV và họ tên người thân tương ứng
SELECT * FROM dbo.GIAOVIEN
SELECT * FROM dbo.NGUOITHAN
SELECT dbo.GIAOVIEN.HOTEN AS 'Ho Ten GV', dbo.GIAOVIEN.MAGV, dbo.NGUOITHAN.TEN AS N'Người thân' FROM dbo.GIAOVIEN, dbo.NGUOITHAN
WHERE dbo.GIAOVIEN.MAGV = dbo.NGUOITHAN.MAGV

--4. Lấy ra mã Gv, tên Gv và tên Khoa của GV đó làm việc. Gợi ý: Bộ môn nằm trong khoa
SELECT * FROM dbo.GIAOVIEN
SELECT * FROM dbo.KHOA
SELECT * FROM dbo.BOMON
SELECT dbo.GIAOVIEN.MAGV, dbo.GIAOVIEN.HOTEN, dbo.KHOA.TENKHOA FROM dbo.GIAOVIEN, dbo.KHOA, dbo.BOMON
WHERE dbo.GIAOVIEN.MABM = dbo.BOMON.MABM AND dbo.BOMON.MAKHOA = dbo.KHOA.MAKHOA

--Lấy ra giáo viên lương >= 2500
SELECT * FROM dbo.GIAOVIEN
WHERE LUONG >= 2500

--Lấy ra giáo viên là nữ và lương > 2000
SELECT * FROM dbo.GIAOVIEN
WHERE PHAI = N'Nữ' AND LUONG > 2000

--Lấy ra giáo viên lớn hơn 43 tuổi
--Year -> lấy ra năm  của ngày
--GETDATE -> lấy ngày hiện tại
SELECT * FROM dbo.GIAOVIEN
WHERE (YEAR(GETDATE()) - YEAR(NGSINH)) > 43

--Lấy ra Họ tên giáo viên, năm sinh và tuổi của giáo viên <= 43 tuổi
SELECT HOTEN, YEAR(NGSINH) AS NamSinh, (YEAR(GETDATE()) - YEAR(NGSINH)) AS Age 
FROM dbo.GIAOVIEN
WHERE (YEAR(GETDATE()) - YEAR(NGSINH)) <= 43

--Lấy ra giáo viên là trưởng bộ môn
SELECT dbo.GIAOVIEN.* FROM dbo.BOMON, dbo.GIAOVIEN
WHERE MAGV = TRUONGBM AND GIAOVIEN.MABM =BOMON.MABM

--Dếm số lượng giáo viên
--COUNT(*) -> đếm số lương của tất cả record
-- COUNT(tên trường giá trị nào đó) -> Đếm số lượng của tên trường đó
SELECT COUNT(*) AS SoGV
FROM dbo.GIAOVIEN

--Đếm số lượng người thân của giáo viên có MaGV là 007
SELECT COUNT(*) AS N'Số người thân của giáo viên'
FROM dbo.GIAOVIEN, dbo.NGUOITHAN
WHERE GIAOVIEN.MAGV = '007' AND GIAOVIEN.MAGV = NGUOITHAN.MAGV

--Lấy ra tên giáo viên và tên đề tài người đó tham gia
SELECT HOTEN, TENDT 
FROM dbo.GIAOVIEN,dbo.THAMGIADT,dbo.DETAI
WHERE GIAOVIEN.MAGV = THAMGIADT.MAGV AND DETAI.MADT = THAMGIADT.MADT

--Lấy ra tên giáo viên và tên đề tài người đó tham gia khi mà người đó tham gia nhiều hơn 1 lần
--Truy vấn lồng sẽ giải quyết

SELECT GIAOVIEN.MAGV, HOTEN, TENDT FROM dbo.GIAOVIEN
JOIN dbo.THAMGIADT ON THAMGIADT.MAGV = GIAOVIEN.MAGV
AND 1 < (SELECT COUNT(*) FROM dbo.THAMGIADT WHERE MAGV = dbo.GIAOVIEN.MAGV)
JOIN dbo.DETAI ON DETAI.MADT = THAMGIADT.MADT


--Bài tập
--1.Xuất ra thông tin giáo viên và giáo viên quản lý chủ nhiệm của người đó
-- Truy xuất với trường hợp tự tham chiếu tới chính nó phải đặt tên table thành 2 trường tên khác nhau để có thể truy xuất
SELECT GV.MAGV, GV.HOTEN, GVQL.MAGV AS 'Ma GVQL', GVQL.HOTEN FROM dbo.GIAOVIEN AS GVQL, dbo.GIAOVIEN AS GV
WHERE GVQL.MAGV = GV.GVQLCM

--2.Xuất ra số lượng giáo viên của khoa CNTT
--Cách 1:
SELECT COUNT(*) AS N'Số lượng giáo viên khoa CNTT' FROM dbo.GIAOVIEN
WHERE MABM IN ('MMT','HTTT')

--Cách 2 (nên làm):
SELECT COUNT(*) AS N'Số lượng giáo viên khoa CNTT' FROM dbo.GIAOVIEN, dbo.BOMON,dbo.KHOA
WHERE GIAOVIEN.MABM = BOMON.MABM AND BOMON.MAKHOA = KHOA.MAKHOA AND KHOA.MAKHOA = 'CNTT'

--3.Xuất ra thông tin giáo viên và đề tài mà người đó tham gia khi mà kết quả là đạt
SELECT dbo.GIAOVIEN.*, KETQUA FROM dbo.GIAOVIEN, dbo.THAMGIADT
WHERE GIAOVIEN.MAGV = THAMGIADT.MAGV AND KETQUA = N'Đạt'