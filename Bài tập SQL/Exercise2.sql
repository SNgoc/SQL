CREATE DATABASE Exercise2
ON PRIMARY (NAME = 'Exercise2', FILENAME = 'N:\FPTAptech\SQL Data base\Exercise2.mdf', SIZE = 5MB, MAXSIZE = 50MB, FILEGROWTH = 10%),
FILEGROUP Group1
(NAME = 'FileGroup_Exercise2', FILENAME = 'N:\FPTAptech\SQL Data base\Exercise2.ndf', SIZE = 10MB, MAXSIZE = UNLIMITED, FILEGROWTH = 5%)
LOG ON (NAME = 'Exercise2_log', FILENAME = 'N:\FPTAptech\SQL Data base\Exercise2_Log.ldf', SIZE = 2MB, MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
GO

USE Exercise2
GO

--3.	Applying the specified appropriate integrity constraints:
--a.	Constraint CHECK in column Age of Students table with range from 15 to 33.
--b.	Primary key : StudentID of Students, PID of Projects, (StudentID, PID) of StudentProject
--c.	Default value on Duration column of StudentProject is 0.
--d.	Constraint Foreign key on 3 tables.


CREATE TABLE Students
(
	StudentID INT PRIMARY KEY,
	[Name] VARCHAR(50),
	Age TINYINT CHECK (Age BETWEEN 15 AND 33),
	stGender BIT
)
GO

CREATE TABLE Projects
(
	PID INT PRIMARY KEY,
	PName VARCHAR(50),
	Cost FLOAT,
	Type VARCHAR(10)
)
GO

CREATE TABLE StudentProject
(
	StudentID INT,
	PID INT,
	WorkDate DATE,
	Duration INT DEFAULT 0,
	CONSTRAINT PK_stPj PRIMARY KEY(StudentID,PID),
	CONSTRAINT FK_StudentID FOREIGN KEY(StudentID) REFERENCES dbo.Students,
	CONSTRAINT FK_PID FOREIGN KEY(PID) REFERENCES dbo.Projects
)
GO

INSERT dbo.Students
VALUES
(   1,   -- StudentID - int
    'Joe Hart',  -- Name - varchar(50)
    25,   -- Age - tinyint
    1 -- stGender - bit
    ), (2, 'Colin Doyle', 20, 1), (3, 'Paul Robinson', 16, NULL), (4, 'Luis Paulson', 17, 0), (5, 'Ben Foster', 30, 1)

SELECT * FROM dbo.Students

INSERT dbo.Projects
VALUES
(   1,   -- PID - int
    'NewYork Bridge',  -- PName - varchar(50)
    100, -- Cost - float
    'Normal'   -- Type - varchar(10)
    ), (2, 'Tenda Road', 60, 'Education'), (3, 'Google Road', 200, 'Government'), (4, 'Star Bridge', 50, 'Education')

SELECT * FROM dbo.Projects

SET DATEFORMAT DMY
INSERT INTO dbo.StudentProject
VALUES
(   1,         -- StudentID - int
    4,         -- PID - int
    '15/05/2018', -- WorkDate - date
    3          -- Duration - int
    ), 
	(2, 2, '14/05/2018', 5), 
	(2, 3, '20/05/2018', 6), 
	(2, 1, '16/05/2018', 4), 
	(3, 1, '16/05/2018', 6), 
	(3, 4, '19/05/2018', 7),
	(4, 4, '21/05/2018', 8)
GO

SELECT *FROM dbo.Students
SELECT * FROM dbo.Projects
SELECT * FROM dbo.StudentProject

--4.	Displays the names of students working for more than 1 project
SELECT * FROM dbo.Students
WHERE StudentID IN 
(SELECT StudentID FROM dbo.StudentProject GROUP BY StudentID HAVING COUNT(*) > 1)

--5.	Displays the names of students who have the largest total working time for projects
--Cách 1
SELECT TOP(1) WITH TIES Name, SUM(Duration) AS 'The largest total working time for projects' 
FROM dbo.Students
JOIN dbo.StudentProject ON StudentProject.StudentID = Students.StudentID
GROUP BY Name 
ORDER BY SUM(Duration) DESC

--Cách 2
SELECT Name FROM dbo.Students
WHERE StudentID IN
(SELECT TOP(1) WITH TIES StudentID FROM dbo.StudentProject GROUP BY StudentID ORDER BY SUM(Duration) DESC)

--6.	Display the names of students that contain the word "Paul" and work for the "Star Bridge" project
SELECT * FROM dbo.Students
JOIN dbo.StudentProject ON StudentProject.StudentID = Students.StudentID
JOIN dbo.Projects ON Projects.PID = StudentProject.PID
AND Name LIKE ('%Paul%') AND PName IN ('Star Bridge')

--7.	Create a view "vwStudentProject" view to display the following information (sort data incrementally by student name): Student name, Project name, Workdate and Duration
GO
CREATE VIEW vwStudentProject AS
SELECT Name, PName, WorkDate, Duration FROM dbo.Students
JOIN dbo.StudentProject ON StudentProject.StudentID = Students.StudentID
JOIN dbo.Projects ON Projects.PID = StudentProject.PID
ORDER BY Name ASC OFFSET 0 ROWS
GO

--DROP VIEW dbo.vwStudentProject
SELECT * FROM dbo.vwStudentProject

--8.	Create a stored procedure  "uspWorking" with a parameter, this parameter is contain the Student Name
--- If this name is in the Students table, it will display information about the corresponding Student and Projects that the Student worked on
--- If the parameter is 'any', display the names of all students and the projects they worked.
GO
CREATE PROC uspWorking
@st_Name VARCHAR(50)
AS
BEGIN
    IF @st_Name IN (SELECT Name FROM dbo.Students WHERE Name = @st_Name)
    BEGIN
        SELECT Students.StudentID, Name, Projects.PID, PName, WorkDate, Duration FROM dbo.Students
		JOIN dbo.StudentProject ON StudentProject.StudentID = Students.StudentID
		JOIN dbo.Projects ON Projects.PID = StudentProject.PID
		AND @st_Name = [Name]
    END
	ELSE IF @st_Name IN ('any')
	BEGIN
	    SELECT Students.StudentID, Name, Projects.PID, PName, WorkDate, Duration FROM dbo.Students
		JOIN dbo.StudentProject ON StudentProject.StudentID = Students.StudentID
		JOIN dbo.Projects ON Projects.PID = StudentProject.PID
	END
	ELSE
	PRINT 'No students named ' +@st_Name
END
GO
--DROP PROC dbo.uspWorking
--Thực thi:
EXEC dbo.uspWorking @st_Name = 'Joe Hart' -- varchar(50)
GO

EXEC dbo.uspWorking @st_Name = 'any'-- varchar(50)
GO

EXEC dbo.uspWorking @st_Name = 'Peter' -- varchar(50)
GO

--9.	Create a trigger "tgUpdateID" on the Students table, if modify the value on the StudentID column of the Students table, 
--------the corresponding value on the StudentID column of the StudentProject table must also be fixed.
--Tạo trigger update studentID trong các bảng có StudentID sử dụng lệnh Instead of Update thay for vì có Foreign key các bảng khác tham chiếu đến
--For update chỉ dùng trong 1 bảng không có foreign key của bảng khác tham chiếu đến
ALTER TRIGGER tgUpdateID ON dbo.Students
INSTEAD OF UPDATE AS
	BEGIN
		ALTER TABLE dbo.StudentProject DROP CONSTRAINT FK_StudentID
		UPDATE dbo.Students SET StudentID = (SELECT StudentID FROM Inserted)
						WHERE Students.StudentID = (SELECT StudentID FROM Deleted)
		UPDATE dbo.StudentProject SET StudentID = (SELECT StudentID FROM Inserted)
						WHERE StudentProject.StudentID = (SELECT StudentID FROM Deleted)

		ALTER TABLE dbo.StudentProject ADD CONSTRAINT FK_StudentID FOREIGN KEY (StudentID) REFERENCES dbo.Students(StudentID)
	END
GO

UPDATE dbo.Students SET StudentID = 6 WHERE StudentID = 2
--SELECT * INTO CloneStudentProject FROM dbo.StudentProject
SELECT * FROM dbo.StudentProject
SELECT * FROM dbo.Students

--10.	Create a stored procedure "uspDropOut" with a parameter, which contains the name of the Project. 
--------IF this name is in the Projects table, it will delete all information related to that project in all related tables of the Database.
--Tạo proc để khi có 1 cụm từ có trong project (vd: bridge) sẽ xóa tất cả các project có tên bridge và các thông tin liên quan project đó
--TẠO CLONE
--SELECT * INTO CloneProject FROM dbo.Projects

--Xóa với chính xác cụm từ của project
GO
CREATE PROC uspDropOut
@NamePj VARCHAR(50)
AS
BEGIN
    IF @NamePj IN (SELECT PName FROM dbo.Projects) --% là để lấy cụm từ tại mọi vị trí trong name pj
	BEGIN
		DECLARE @PIDPJ INT
		--ALTER TABLE dbo.StudentProject DROP CONSTRAINT FK_PID -- Thêm dòng này để hủy foreign key tạm thời
		SELECT @PIDPJ = PID FROM dbo.Projects WHERE @NamePj = PName
		DELETE dbo.StudentProject WHERE PID = @PIDPJ --Xóa PID trước trong StudentProject do đây là bảng có Foreign key nên phải xóa trước
		DELETE dbo.Projects WHERE PName = @NamePj
		-- Thêm lại foreign key(PID) để StudentProject tham chiếu tới Projects(PID) như khi tạo bảng
		--ALTER TABLE dbo.StudentProject ADD CONSTRAINT FK_PID FOREIGN KEY(PID) REFERENCES dbo.Projects(PID)
	END
	ELSE
	BEGIN
	    PRINT 'Cannot not delete because Project is not exist!'
	END
END
GO

--Thực thi
EXEC dbo.uspDropOut @NamePj = 'Roads' -- varchar(50)

--Xóa với chỉ 1 từ khóa có trong pj
GO
CREATE PROC uspDropOut222
@p_Name varchar(50) 
AS
BEGIN
	IF (EXISTS (SELECT * FROM Projects WHERE PName LIKE '%'+@p_Name+'%')) --QUAN TRỌNG: Phải dùng exists (không có cách khác)
	BEGIN
		DELETE FROM StudentProject WHERE PID IN (SELECT PID FROM Projects WHERE PName LIKE '%'+@p_Name+'%')
		DELETE FROM Projects WHERE PName LIKE '%'+@p_Name+'%'
	END
	ELSE
	BEGIN
	    PRINT 'Not exists this project'
	END
END
GO
--
EXEC dbo.uspDropOut222 @p_Name = 'Roads' -- varchar(50)

--Check Table
SELECT * FROM dbo.Students
SELECT * FROM dbo.Projects
SELECT * FROM dbo.StudentProject

-- Fix lại data
INSERT dbo.Projects
VALUES
(   5,   -- PID - int
    'NewYork Roads',  -- PName - varchar(50)
    200, -- Cost - float
    'Government'   -- Type - varchar(10)
    )

SET DATEFORMAT DMY
INSERT dbo.StudentProject
VALUES
(   1,         -- StudentID - int
    5,         -- PID - int
    '20/05/2018', -- WorkDate - date
    6          -- Duration - int
    )
GO


