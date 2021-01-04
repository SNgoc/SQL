USE HowKteam
GO

--Join
SELECT * FROM dbo.BOMON JOIN dbo.GIAOVIEN
ON GIAOVIEN.MABM = BOMON.MABM

SELECT * FROM dbo.BOMON
SELECT * FROM dbo.GIAOVIEN

--Left Join
---Bảng bên phải nhập vào bảng bên trái
--- Record nào không có thì để null
--- Record nào bảng trái không có thì không điền vào
SELECT * FROM dbo.BOMON LEFT JOIN dbo.GIAOVIEN
ON GIAOVIEN.MABM = BOMON.MABM

--Right Join
SELECT * FROM dbo.BOMON RIGHT JOIN dbo.GIAOVIEN
ON GIAOVIEN.MABM = BOMON.MABM
