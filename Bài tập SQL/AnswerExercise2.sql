CREATE DATABASE Exercise2
GO

USE Exercise2
GO

CREATE TABLE Students
(
	StudentID int  NOT NULL,
	Name varchar(50),
	Age tinyint,
	stGender bit
)
GO

CREATE TABLE Projects
(
	PID int NOT NULL,
	PName varchar(50),
	Cost float,
	Type varchar(10)
)
GO

CREATE TABLE StudentProject
(
	StudentID int NOT NULL,
	PID int NOT NULL,
	WorkDate date,
	Duration int
)
GO

INSERT INTO Students VALUES (1,'Joe Hart',   25, 1 ),
							(2, 'Colin Doyle',20, 13),
							(3,	'Paul Robinson',16,	Null),
							(4,	'Luis Paulson',	17,	0),
							(5,	'Ben Foster', 30,  1)
GO

INSERT INTO Projects VALUES (1,	'NewYork Bridge',100,'Normal'),
							(2,	'Tenda Road',	60,	'Education'),
							(3,	'Google Road',	200,'Government'),
							(4,	'Star Bridge',	50,'Education')
GO

set dateformat dmy;
GO

INSERT INTO StudentProject VALUES (1,	4,	'15/05/2018',	3),
								  (2,	2,	'14/05/2018',	5),
								  (2,	3,	'20/05/2018',	6),
								  (2,	1,	'16/05/2018',	4),
								  (3,	1,	'16/05/2018',	6),
								  (3,	4,	'19/05/2018',	7),
								  (4,	4,	'21/05/2018',	8)
GO

--3a
ALTER TABLE Students 
ADD CONSTRAINT ck1 CHECK (Age >15 and Age<33)
GO

--3b
ALTER TABLE Students 
ADD CONSTRAINT pk1 PRIMARY KEY (StudentID)
GO
ALTER TABLE Projects 
ADD CONSTRAINT pk2 PRIMARY KEY (PID)
GO
ALTER TABLE StudentProject 
ADD CONSTRAINT pk3 PRIMARY KEY (StudentID, PID)
GO

--3c
ALTER TABLE StudentProject 
ADD CONSTRAINT df1 DEFAULT(0) FOR Duration
GO

--3d
ALTER TABLE StudentProject 
ADD CONSTRAINT fk1 FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
GO
ALTER TABLE StudentProject 
ADD CONSTRAINT fk2 FOREIGN KEY (PID) REFERENCES Projects(PID)
GO

--4.	Displays the names of students working for more than 1 project
SELECT Name FROM Students
WHERE StudentID IN (Select StudentID FROM StudentProject 
					GROUP BY StudentID 
					HAVING COUNT(PID) >1)

--5.	Displays the names of students who have the largest total working time for projects
SELECT Name FROM Students
WHERE StudentID IN (Select TOP 1 WITH TIES StudentID FROM StudentProject 
					GROUP BY StudentID 
					ORDER BY SUM(Duration) DESC)

--6.	Display the names of students that contain the word "Paul" and work for the "Star Bridge" project
SELECT Name FROM Students s
JOIN StudentProject sp ON sp.StudentID = s.StudentID
JOIN Projects p ON sp.PID = p.PID
WHERE Name LIKE '%Paul%' and PName = 'Star Bridge'

--7.	Create a view "vwStudentProject" view to display the following information (sort data incrementally by student name): Student name, Project name, Workdate and Duration
CREATE VIEW vwStudentProject
AS
SELECT TOP 100 Name, PName, WorkDate, Duration FROM Students s
JOIN StudentProject sp ON sp.StudentID = s.StudentID
JOIN Projects p ON sp.PID = p.PID
ORDER BY Name
GO

SELECT * FROM vwStudentProject
GO

/*8.	Create a stored procedure  "uspWorking" with a parameter, this parameter is contain the Student Name
- If this name is in the Students table, it will display information about the corresponding Student and Projects that the Student worked on
- If the parameter is 'any', display the names of all students and the projects they worked.
*/

CREATE PROC uspWorking @s_name varchar(50) 
AS
BEGIN
	IF (@s_name IN (SELECT Name FROM Students WHERE Name LIKE @s_name) )
		BEGIN
			SELECT  Name, PName FROM Students s
			JOIN StudentProject sp ON sp.StudentID = s.StudentID
			JOIN Projects p ON sp.PID = p.PID
			WHERE Name LIKE @s_name
		END
	ELSE IF (@s_name = 'any')
		BEGIN
			SELECT  Name, PName FROM Students s
			JOIN StudentProject sp ON sp.StudentID = s.StudentID
			JOIN Projects p ON sp.PID = p.PID
		END
	ELSE
	PRINT 'No students named ' +@s_name
END
GO

EXEC uspWorking 'any'
GO
EXEC uspWorking 'Joe Hart'
GO
EXEC uspWorking 'Peter'
GO

--9.	Create a trigger "tgUpdateID" on the Students table, if modify the value on the StudentID column of the Students table, the corresponding value on the StudentID column of the StudentProject table must also be fixed.
CREATE TRIGGER tgUpdateID ON Students
INSTEAD OF UPDATE 
AS
BEGIN
	ALTER TABLE StudentProject DROP CONSTRAINT fk1
	UPDATE Students SET StudentID = (SELECT StudentID FROM inserted)
					WHERE StudentID = (SELECT StudentID FROM deleted)
	UPDATE StudentProject SET StudentID = (SELECT StudentID FROM inserted)
					WHERE StudentID = (SELECT StudentID FROM deleted)
	ALTER TABLE StudentProject 
	ADD CONSTRAINT fk1 FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
END
GO

UPDATE Students SET StudentID = 6 WHERE StudentID = 2
GO
SELECT * FROM Students
SELECT * FROM StudentProject
GO

--10.	Create a stored procedure "uspDropOut" with a parameter, which contains the name of the Project. If this name is in the Projects table, 
--it will delete all information related to that project in all related tables of the Database.
CREATE PROC uspDropOut @p_Name varchar(50) 
AS
BEGIN
	IF (EXISTS (SELECT * FROM Projects WHERE PName LIKE '%'+@p_Name+'%'))
	BEGIN
		DELETE FROM StudentProject WHERE PID IN (SELECT PID FROM Projects WHERE PName LIKE '%'+@p_Name+'%')
		DELETE FROM Projects WHERE PName LIKE '%'+@p_Name+'%'
	END
END
GO

EXEC uspDropOut 'Road'
SELECT * FROM Projects
SELECT * FROM StudentProject
GO