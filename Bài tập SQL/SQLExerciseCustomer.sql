-- 1/ Tạo DB + Sử dụng DB
Create Database CustomerExercise
ON PRIMARY (NAME = 'CustomerExercise', FILENAME = 'N:\FPTAptech\SQL Data base\CustomerExercise.mdf')
LOG ON (NAME = 'CustomerExercise_Log', FILENAME = 'N:\FPTAptech\SQL Data base\CustomerExercise_Log.ldf')
GO

USE CustomerExercise
GO

--Customer
CREATE TABLE Customer
(	CustomerID CHAR(4) PRIMARY KEY,
	CustName VARCHAR(40),
	CustAddress VARCHAR(50),
	CustPhone VARCHAR(20),
	Birthday SMALLDATETIME,
	RegisterDate SMALLDATETIME,
	Revenue MONEY
)
GO

--Employee
CREATE TABLE Employee
(	EmpID CHAR(4) PRIMARY KEY,
	EmpName VARCHAR(40),
	EmpPhone VARCHAR(20),
	StartDate SMALLDATETIME
)
GO

--Product
CREATE TABLE Product
(	ProductID CHAR(4) PRIMARY KEY,
	ProductName VARCHAR(40),
	Unit VARCHAR(20),
	Country VARCHAR(20),
	Price MONEY
)
GO

--Bill
CREATE TABLE Bill
(	BillID INT PRIMARY KEY,
	BillDate SMALLDATETIME,
	CustomerID CHAR(4) CONSTRAINT FK_CusID FOREIGN KEY (CustomerID) REFERENCES dbo.Customer(CustomerID), --Tạo FK tới Customer
	EmpID CHAR(4) CONSTRAINT FK_EmpID FOREIGN KEY (EmpID) REFERENCES dbo.Employee(EmpID), --Tạo FK tới EmpID
	BillVal MONEY
)
GO

--DetailBill
CREATE TABLE DetailBill
(	BillID INT NOT NULL,
	ProductID CHAR(4) NOT NULL,
	Quantity INT

	CONSTRAINT PK_DetailBill PRIMARY KEY (BillID,ProductID),
	CONSTRAINT FK_DetailBillID FOREIGN KEY (BillID) REFERENCES dbo.Bill(BillID),
	CONSTRAINT FK_DetailProductID FOREIGN KEY (ProductID) REFERENCES dbo.Product(ProductID)
)
GO

---- insert data into tables----
SET DATEFORMAT DMY
-------------------------------
-- Customer
insert into Customer values('C01','Nguyen Van A','731 Tran Hung Dao, Q5, TpHCM','8823451','22/10/1960','22/07/2006',13060000)
insert into Customer values('C02','Tran Ngoc Han','23/5 Nguyen Trai, Q5, TpHCM','908256478','03/04/1974','30/07/2006',280000)
insert into Customer values('C03','Tran Ngoc Linh','45 Nguyen Canh Chan, Q1, TpHCM','938776266','12/06/1980','08/05/2006',3860000)
insert into Customer values('C04','Tran Minh Long','50/34 Le Dai Hanh, Q10, TpHCM','917325476','09/03/1965','10/02/2006',250000)
insert into Customer values('C05','Le Nhat Minh','34 Truong Dinh, Q3, TpHCM','8246108','10/03/1950','28/10/2006',21000)
insert into Customer values('C06','Le Hoai Thuong','227 Nguyen Van Cu, Q5, TpHCM','8631738','31/12/1981','24/11/2006',915000)
insert into Customer values('C07','Nguyen Van Tam','32/3 Tran Binh Trong, Q5, TpHCM','916783565','06/04/1971','12/01/2006',12500)
insert into Customer values('C08','Phan Thi Thanh','45/2 An Duong Vuong, Q5, TpHCM','938435756','10/01/1971','13/12/2006',365000)
insert into Customer values('C09','Le Ha Vinh','873 Le Hong Phong, Q5, TpHCM','8654763','03/09/1979','14/01/2007',70000)
insert into Customer values('C10','Ha Duy Lap','34/34B Nguyen Trai, Q1, TpHCM','8768904','02/05/1983','16/01/2007',67500)
 
-------------------------------
-- Employee
insert into Employee values('E01','Nguyen Nhu Nhut','927345678','13/04/2006')
insert into Employee values('E02','Le Thi Phi Yen','987567390','21/04/2006')
insert into Employee values('E03','Nguyen Van B','997047382','27/04/2006')
insert into Employee values('E04','Ngo Thanh Tuan','913758498','24/06/2006')
insert into Employee values('E05','Nguyen Thi Truc Thanh','918590387','20/07/2006')
 
-------------------------------
-- Product
insert into Product values('BC01','But chi','cay','Singapore',3000)
insert into Product values('BC02','But chi','cay','Singapore',5000)
insert into Product values('BC03','But chi','cay','Viet Nam',3500)
insert into Product values('BC04','But chi','hop','Viet Nam',30000)
insert into Product values('BB01','But bi','cay','Viet Nam',5000)
insert into Product values('BB02','But bi','cay','Trung Quoc',7000)
insert into Product values('BB03','But bi','hop','Thai Lan',100000)
insert into Product values('TV01','Tap 100 giay mong','quyen','Trung Quoc',2500)
insert into Product values('TV02','Tap 200 giay mong','quyen','Trung Quoc',4500)
insert into Product values('TV03','Tap 100 giay tot','quyen','Viet Nam',3000)
insert into Product values('TV04','Tap 200 giay tot','quyen','Viet Nam',5500)
insert into Product values('TV05','Tap 100 trang','chuc','Viet Nam',23000)
insert into Product values('TV06','Tap 200 trang','chuc','Viet Nam',53000)
insert into Product values('TV07','Tap 100 trang','chuc','Trung Quoc',34000)
insert into Product values('ST01','So tay 500 trang','quyen','Trung Quoc',40000)
insert into Product values('ST02','So tay loai 1','quyen','Viet Nam',55000)
insert into Product values('ST03','So tay loai 2','quyen','Viet Nam',51000)
insert into Product values('ST04','So tay','quyen','Thai Lan',55000)
insert into Product values('ST05','So tay mong','quyen','Thai Lan',20000)
insert into Product values('ST06','Phan viet bang','hop','Viet Nam',5000)
insert into Product values('ST07','Phan khong bui','hop','Viet Nam',7000)
insert into Product values('ST08','Bong bang','cai','Viet Nam',1000)
insert into Product values('ST09','But long','cay','Viet Nam',5000)
insert into Product values('ST10','But long','cay','Trung Quoc',7000)
 
-------------------------------
-- Bill
insert into Bill values(1001,'23/07/2006','C01','E01',320000)
insert into Bill values(1002,'12/08/2006','C01','E02',840000)
insert into Bill values(1003,'23/08/2006','C02','E01',100000)
insert into Bill values(1004,'01/09/2006','C02','E01',180000)
insert into Bill values(1005,'20/10/2006','C01','E02',3800000)
insert into Bill values(1006,'16/10/2006','C01','E03',2430000)
insert into Bill values(1007,'28/10/2006','C03','E03',510000)
insert into Bill values(1008,'28/10/2006','C01','E03',440000)
insert into Bill values(1009,'28/10/2006','C03','E04',200000)
insert into Bill values(1010,'01/11/2006','C01','E01',5200000)
insert into Bill values(1011,'04/11/2006','C04','E03',250000)
insert into Bill values(1012,'30/11/2006','C05','E03',21000)
insert into Bill values(1013,'12/12/2006','C06','E01',5000)
insert into Bill values(1014,'31/12/2006','C03','E02',3150000)
insert into Bill values(1015,'01/01/2007','C06','E01',910000)
insert into Bill values(1016,'01/01/2007','C07','E02',12500)
insert into Bill values(1017,'02/01/2007','C08','E03',35000)
insert into Bill values(1018,'13/01/2007','C08','E03',330000)
insert into Bill values(1019,'13/01/2007','C01','E03',30000)
insert into Bill values(1020,'14/01/2007','C09','E04',70000)
insert into Bill values(1021,'16/01/2007','C10','E03',67500)
insert into Bill values(1022,'16/01/2007',Null,'E03',7000)
insert into Bill values(1023,'17/01/2007',Null,'E01',330000)
 
-------------------------------
-- DetailBill
insert into DetailBill values(1001,'TV02',10)
insert into DetailBill values(1001,'ST01',5)
insert into DetailBill values(1001,'BC01',5)
insert into DetailBill values(1001,'BC02',10)
insert into DetailBill values(1001,'ST08',10)
insert into DetailBill values(1002,'BC04',20)
insert into DetailBill values(1002,'BB01',20)
insert into DetailBill values(1002,'BB02',20)
insert into DetailBill values(1003,'BB03',10)
insert into DetailBill values(1004,'TV01',20)
insert into DetailBill values(1004,'TV02',10)
insert into DetailBill values(1004,'TV03',10)
insert into DetailBill values(1004,'TV04',10)
insert into DetailBill values(1005,'TV05',50)
insert into DetailBill values(1005,'TV06',50)
insert into DetailBill values(1006,'TV07',20)
insert into DetailBill values(1006,'ST01',30)
insert into DetailBill values(1006,'ST02',10)
insert into DetailBill values(1007,'ST03',10)
insert into DetailBill values(1008,'ST04',8)
insert into DetailBill values(1009,'ST05',10)
insert into DetailBill values(1010,'TV07',50)
insert into DetailBill values(1010,'ST07',50)
insert into DetailBill values(1010,'ST08',100)
insert into DetailBill values(1010,'ST04',50)
insert into DetailBill values(1010,'TV03',100)
insert into DetailBill values(1011,'ST06',50)
insert into DetailBill values(1012,'ST07',3)
insert into DetailBill values(1013,'ST08',5)
insert into DetailBill values(1014,'BC02',80)
insert into DetailBill values(1014,'BB02',100)
insert into DetailBill values(1014,'BC04',60)
insert into DetailBill values(1014,'BB01',50)
insert into DetailBill values(1015,'BB02',30)
insert into DetailBill values(1015,'BB03',7)
insert into DetailBill values(1016,'TV01',5)
insert into DetailBill values(1017,'TV02',1)
insert into DetailBill values(1017,'TV03',1)
insert into DetailBill values(1017,'TV04',5)
insert into DetailBill values(1018,'ST04',6)
insert into DetailBill values(1019,'ST05',1)
insert into DetailBill values(1019,'ST06',2)
insert into DetailBill values(1020,'ST07',10)
insert into DetailBill values(1021,'ST08',5)
insert into DetailBill values(1021,'TV01',7)
insert into DetailBill values(1021,'TV02',10)
insert into DetailBill values(1022,'ST07',1)
insert into DetailBill values(1023,'ST04',6)

SELECT * FROM dbo.Customer
SELECT * FROM dbo.Product
SELECT * FROM dbo.Employee
SELECT * FROM dbo.Bill
SELECT * FROM dbo.DetailBill

--C.	Write the query to display the following requirements:

--1.Show ProductID, ProductName produced by “Viet Nam”
SELECT ProductID, ProductName, Country FROM dbo.Product
WHERE Country = 'Viet Nam'

--2.Show ProductID, ProductName has unit is “cay”, “quyen”
SELECT ProductID, ProductName, Unit FROM dbo.Product
WHERE Unit IN ('cay', 'quyen')

--3.Show ProductID, ProductName has product code start by “B” and end by “01”
SELECT ProductID, ProductName, Unit FROM dbo.Product
WHERE ProductID LIKE ('B%') AND ProductID LIKE ('%01') --truy vấn dữ liệu theo pattern thì dùng like và phép %

--4.Show ProductID, ProductName produced by “Trung Quoc” and price from 30.000 to 40.000
SELECT ProductID, ProductName, Price, Country FROM dbo.Product
WHERE Price IN (30000, 40000) AND Country LIKE 'Trung Quoc'

--5.Show ProductID, ProductName produced by “Trung Quoc” or “Viet Nam” and price from 30.000 to 40.000
SELECT ProductID, ProductName, Price, Country FROM dbo.Product
WHERE Price IN (30000, 40000) AND Country IN ('Trung Quoc', 'Viet Nam')

--6.Show BillID, BillVal are sold on 1/1/2007 and 2/1/2007
SELECT BillID, BillVal, BillDate FROM dbo.Bill
WHERE BillDate BETWEEN '2007/01/01' AND '2007/01/02'

--7.Show BillID, BillVal are sold on January 2007, order by date (ascending) and invoice value(descending) 
SELECT BillID, BillVal, BillDate FROM dbo.Bill
WHERE MONTH(BillDate) = 1 AND YEAR(BillDate) = 2007
ORDER BY BillDate ASC, BillVal DESC

--8.Show CustomerID, CustName have bought product on 1/1/2007
SELECT dbo.Customer.CustomerID, dbo.Customer.CustName, dbo.Bill.BillDate FROM dbo.Customer, dbo.Bill
WHERE dbo.Customer.CustomerID = dbo.Bill.CustomerID AND dbo.Bill.BillDate IN ('2007/01/01')


--9.Show BillID, BillVal are recorded by employee “Nguyen Van B” on 28/10/2006
SELECT dbo.Bill.BillID, dbo.Bill.BillVal, dbo.Bill.BillDate, dbo.Employee.EmpName FROM dbo.Bill, dbo.Employee
WHERE (dbo.Bill.EmpID = dbo.Employee.EmpID AND dbo.Bill.BillDate IN ('2006/10/28')) AND dbo.Employee.EmpName LIKE 'Nguyen Van B'

--10.Show ProductID, ProductName are bought by customer “Nguyen Van A” on 10/2006
SELECT Product.ProductID, ProductName, CustName, BillDate FROM dbo.Product, dbo.Customer,dbo.Bill,dbo.DetailBill
WHERE dbo.Customer.CustomerID = dbo.Bill.CustomerID AND dbo.Product.ProductID = dbo.DetailBill.ProductID AND dbo.Bill.BillID = dbo.DetailBill.BillID
AND dbo.Customer.CustName LIKE 'Nguyen Van A' AND MONTH(dbo.Bill.BillDate) = 10 AND YEAR(dbo.Bill.BillDate) = 2006

--11.Show BillID have ProductID is “BB01” or “BB02”
SELECT BillID, ProductID FROM dbo.DetailBill
WHERE ProductID IN ('BB01', 'BB02')

--12.Show BillID have ProductID is “BB01” or “BB02” with each quantity from 10 to 20
SELECT * FROM dbo.DetailBill
WHERE ProductID IN ('BB01', 'BB02') AND Quantity BETWEEN 10 AND 20

--13.Show BillID have bought 2 products “BB01” and “BB02” at the same time, each quantity from 10 to 20 (hint: use INTERSECT)
SELECT BillID FROM dbo.DetailBill
WHERE ProductID = 'BB01' AND Quantity BETWEEN 10 AND 20
INTERSECT
SELECT BillID FROM dbo.DetailBill
WHERE ProductID ='BB02' AND Quantity BETWEEN 10 AND 20

--14.Show ProductID, ProductName are produced by “Trung Quoc” and sold on 1/1/2007
SELECT ProductID, ProductName, Country FROM dbo.Product
WHERE Country = 'Trung Quoc' 
AND ProductID IN 
(SELECT ProductID FROM dbo.Bill, dbo.DetailBill WHERE Bill.BillID = DetailBill.BillID AND BillDate = '2007/01/01')

--15.Show the revenue in 2006
SELECT Revenue, RegisterDate FROM dbo.Customer
WHERE YEAR(RegisterDate) = 2006

--16.Show ProductID, ProductName not sold (hint: use NOT IN, NOT EXISTS or EXCEPT)
SELECT ProductID, ProductName FROM dbo.Product
WHERE ProductID NOT IN (SELECT ProductID FROM dbo.DetailBill)

--17.Show ProductID, ProductName not sold in 2006
SELECT ProductID, ProductName FROM dbo.Product
WHERE ProductID NOT IN (SELECT ProductID FROM dbo.DetailBill)
OR ProductID IN 
(SELECT ProductID FROM dbo.DetailBill, dbo.Bill WHERE DetailBill.BillID = Bill.BillID AND YEAR(BillDate) NOT IN (2006))

--18.Show ProductID, ProductName not sold in 2006 produced by “Trung Quoc”
--Cách 1: không bao gồm kết quả trùng
SELECT ProductID, ProductName, Country FROM dbo.Product
WHERE Country IN ('Trung Quoc') AND ProductID IN 
(SELECT ProductID FROM dbo.DetailBill, dbo.Bill WHERE DetailBill.BillID = Bill.BillID AND YEAR(BillDate) NOT IN (2006))

--Cách 2: có bao gồm kết quả trùng
SELECT * FROM dbo.Product
JOIN dbo.DetailBill ON DetailBill.ProductID = Product.ProductID AND Country IN ('Trung Quoc')
JOIN dbo.Bill ON Bill.BillID = DetailBill.BillID AND YEAR(BillDate) NOT IN (2006)

--Code test
SELECT * FROM dbo.Product
WHERE Country = 'Trung Quoc'
SELECT * FROM dbo.Bill
SELECT * FROM dbo.DetailBill
WHERE ProductID IN ('BB02', 'ST01', 'ST10', 'TV01', 'TV02', 'TV07')

--19.Show the number of invoices have bought by non-member customer
SELECT COUNT(*) AS 'Number of invoices have bought by non-member customer' FROM dbo.Bill
WHERE CustomerID IS NULL

--20.Show the number of different products were sold in 2006.
SELECT COUNT(DISTINCT(ProductName)) FROM dbo.Product
WHERE ProductID IN 
(SELECT ProductID FROM dbo.DetailBill, dbo.Bill WHERE DetailBill.BillID = Bill.BillID AND YEAR(BillDate) IN (2006))

--21.Show the highest  and lowest invoice value
SELECT MAX(BillVal) AS Highest_Invoice FROM dbo.Bill
SELECT MIN(BillVal) AS Lowest_Invoice FROM dbo.Bill

--22.Show the average of invoice value were sold in 2006
SELECT AVG(BillVal) AS 'Average of invoice' FROM dbo.Bill
WHERE YEAR(BillDate) = 2006


--23.Show BillID has the highest invoice value in 2006
SELECT BillID, BillVal, BillDate FROM dbo.Bill
WHERE BillVal = (SELECT MAX(BillVal) FROM dbo.Bill WHERE YEAR(BillDate) = '2006')

--24.Show CustName have bought the highest invoice value in 2006
SELECT Customer.CustomerID, CustName, BillID, BillVal, BillDate FROM dbo.Customer
JOIN dbo.Bill
ON Bill.CustomerID = Customer.CustomerID
AND BillVal = (SELECT MAX(BillVal) FROM dbo.Bill WHERE YEAR(BillDate) = '2006')

--25.Show 3 customers (CustomerID, CustName) have highest revenue
SELECT TOP(3) * FROM dbo.Customer
ORDER BY Revenue DESC 

--26.Show a list of products (ProductID, ProductName) that sells at one of the three highest prices.
SELECT TOP(3) * FROM dbo.Product
ORDER BY Price DESC


--27.Show a list of products (ProductID, ProductName) that sells at one of the three highest prices produced by “Thai Lan”
SELECT TOP(3) * FROM dbo.Product
WHERE Country IN ('Thai Lan')
ORDER BY Price DESC

--28.Show the total of products produced by “Trung Quoc”
SELECT COUNT(*) AS 'Total of products produced by “Trung Quoc”' FROM dbo.Product
WHERE Country = 'Trung Quoc'


--29.Show the total of products of each country.
SELECT Country, COUNT(*) AS 'Total of products of each country' FROM dbo.Product
GROUP BY Country

--30.Show the revenue per day.
SELECT AVG(Revenue) AS 'The revenue per day' FROM dbo.Customer

--31.Show the customer(CustomerID, CustName) have the number of times purchasing is highest
SELECT TOP(1) WITH TIES Customer.CustomerID, CustName, COUNT(Bill.CustomerID) AS 'The number of times purchasing' FROM dbo.Customer
JOIN dbo.Bill
ON Bill.CustomerID = Customer.CustomerID
GROUP BY Customer.CustomerID, CustName
ORDER BY COUNT(Bill.CustomerID) DESC

--32.Show the country where the total number of products is the largest
SELECT TOP(1) WITH TIES Country, SUM(Quantity) AS 'Total number of products is the largest' FROM dbo.DetailBill
JOIN dbo.Product
ON Product.ProductID = DetailBill.ProductID
GROUP BY Country
ORDER BY [Total number of products is the largest] DESC

--33.Show BillID have bought all products produced by Singapore (hiển thị billID mua tất cả sản phẩm được sản xuất bởi Singapore)
DECLARE @BillIDSingapore INT 
SELECT @BillIDSingapore =  COUNT(*) FROM dbo.Product WHERE Country = 'Singapore'

SELECT DISTINCT(BillID) FROM dbo.DetailBill
WHERE BillID IN
(SELECT BillID  FROM dbo.DetailBill
WHERE ProductID IN (SELECT ProductID FROM dbo.Product WHERE Country = 'Singapore')
GROUP BY BillID
HAVING COUNT(*) = (@BillIDSingapore))

--34.Show BillID have bought all products produced by Singapore in 2006.
DECLARE @BillIDSingapore2 INT 
SELECT @BillIDSingapore2 =  COUNT(*) FROM dbo.Product WHERE Country = 'Singapore'

SELECT DISTINCT(dbo.DetailBill.BillID) FROM dbo.Bill
JOIN dbo.DetailBill ON DetailBill.BillID = Bill.BillID
WHERE dbo.Bill.BillID IN
(SELECT BillID  FROM dbo.DetailBill
WHERE ProductID IN (SELECT ProductID FROM dbo.Product WHERE Country = 'Singapore')
GROUP BY BillID
HAVING COUNT(*) = @BillIDSingapore2) AND YEAR(BillDate) = '2006'