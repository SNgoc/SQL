USE HowKteam
GO

--Inner Join -> kiểu cũ -> có thể sau này không còn được hỗ trợ
-- mọi Join đều cần điều kiện
SELECT * FROM dbo.GIAOVIEN, dbo.BOMON
WHERE BOMON.MABM = GIAOVIEN.MABM

--Inner Join kiểu mới, đúng chuẩn
SELECT * FROM dbo.GIAOVIEN INNER JOIN dbo.BOMON
ON BOMON.MABM = GIAOVIEN.MABM
AND BOMON.TRUONGBM = '001'

--Có thể viết tắt INNER JOIN -> JOIN (nên sử dụng kiểu này)
--Join phải có điều kiện với ON
SELECT * FROM dbo.KHOA JOIN dbo.BOMON
ON BOMON.MAKHOA = KHOA.MAKHOA