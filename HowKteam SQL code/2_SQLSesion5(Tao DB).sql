CREATE DATABASE Customer_DB
ON PRIMARY
( NAME = 'Customer_DB', FILENAME = 'N:\FPTAptech\SQL Data base\Customer_DB.mdf')
LOG ON
( NAME = 'Customer_DB_log', FILENAME = 'N:\FPTAptech\SQL Data base\Customer_DB_log.ldf')

--thay đổi tên DB
ALTER DATABASE Customer_DB MODIFY NAME = Cust_DB

USE Cust_DB
GO

EXEC sp_changedbowner 'sa' --thay đổi người sở hữu DB

--Tạo bảng chụp DB
CREATE DATABASE customer_snapshot01 
ON
( NAME = Customer_DB, 
  FILENAME = 'N:\FPTAptech\SQL Data base\Customerdat_0100.ss')
AS SNAPSHOT OF CUST_DB;

--Tạo bảng chụp DB
CREATE DATABASE SQLDBUI_snapshot01 
ON
( NAME = SQLDBUI, 
  FILENAME = 'N:\FPTAptech\SQL Data base\SQLDBUI.ss')
AS SNAPSHOT OF SQLDBUI;