CREATE DATABASE Pretest2
ON PRIMARY (NAME = 'Pretest_2', FILENAME = 'N:\FPTAptech\SQL Data base\pretest_2.mdf', SIZE = 5MB, MAXSIZE = 50MB, FILEGROWTH = 10%),
FILEGROUP Group1
(NAME = 'FileGroup_Pretest_2', FILENAME = 'N:\FPTAptech\SQL Data base\pretest_2.ndf', SIZE = 10MB, MAXSIZE = UNLIMITED, FILEGROWTH = 5%)
LOG ON (NAME = 'Pretest_log_2', FILENAME = 'N:\FPTAptech\SQL Data base\pretest_2.ldf', SIZE = 2MB, MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
GO

USE Pretest2
GO