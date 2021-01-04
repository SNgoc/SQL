USE HowKteam
GO

--Gom 2 bảng lại, thêm điều kiện, bên nào không có dữ liệu thì để null
SELECT * FROM dbo.GIAOVIEN
FULL OUTER JOIN dbo.BOMON
ON BOMON.MABM = GIAOVIEN.MABM

--FULL OUTER JOIN là mệnh đề truy vấn với kết quả trả về là tập hợp tất cả dữ liệu chung và riêng giữa thông qua điều kiện kết hợp hai bảng.
----Các dữ liệu chung chính là truy vấn INNER JOIN trên hai bảng.
----Các dữ liệu riêng, chỉ tồn tại ở một trong hai bảng không có giá trị trùng khớp điều kiện kết hợp thì các trường ở bảng còn lại được mặc định NULL (Rỗng)
----Mọi Full Outer Join đều bắt buộc phải có điều kiện kết hợp sau ON

--VD1: Hiển thị các GV chủ nhiệm đề tài & chưa chủ nhiệm đề tài

SELECT GV.MAGV, GV.HOTEN, DT.MADT,DT.TENDT
FROM dbo.GIAOVIEN AS GV
FULL OUTER JOIN dbo.DETAI AS DT ON DT.GVCNDT = GV.MAGV

--Ví dụ 2: Xuất thông tin bộ môn đã có giáo viên dạy và chưa có giáo viên dạy
SELECT BM.MABM, BM.TENBM, GV.MAGV,GV.HOTEN
FROM dbo.BOMON AS BM
FULL OUTER JOIN dbo.GIAOVIEN AS GV ON GV.MABM = BM.MABM

--Ví dụ 3: Xuất danh sách giáo viên có người thân & chưa có người thân.
SELECT GV.MAGV,GV.HOTEN, NT.TEN
FROM dbo.GIAOVIEN AS GV
FULL OUTER JOIN dbo.NGUOITHAN AS NT ON NT.MAGV = GV.MAGV

--Cross Join
----CROSS JOIN là một cách truy vấn tương tự truy vấn dữ liệu từ hai bảng, kết quả tra về là tập hợp tích Descartes của hai bảng đó.
----Số Record kết quả sẽ bằng tích Record từ 2 bảng.