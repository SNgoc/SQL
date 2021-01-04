USE HowKteam
GO

-- insert into select -> coppy dữ liệu vào bảng đã tồn tại

SELECT * INTO CLoneGV
FROM dbo.GIAOVIEN
WHERE 1=0

INSERT INTO CloneGV
SELECT * FROM dbo.GIAOVIEN

SELECT * FROM CloneGV