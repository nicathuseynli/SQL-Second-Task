CREATE DATABASE AcademyDb 
CREATE TABLE Employee(
    ID INT PRIMARY KEY IDENTITY(1,1),
	OrderID INT FOREIGN KEY REFERENCES  [Order](ID),
	CategoryID INT FOREIGN KEY REFERENCES [Category](ID),
	[Name] NVARCHAR(30),
	[LastName] NVARCHAR(30),
	Age INT,
	Salary MONEY
)
CREATE TABLE Category(
   ID INT PRIMARY KEY IDENTITY(1,1),
   [Name] NVARCHAR(30),
   [Description] NVARCHAR(40)
)
CREATE TABLE [Order](
    ID INT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(30),
	[CategoryID] INT FOREIGN KEY REFERENCES [Category](ID),
	[Count] INT,
	[Unit Price] MONEY CHECK([Unit Price] > 20) ,
)
INSERT [Order]
VALUES('Beer',1,150,60),
		('Tequila',1,200,163),
		  ('Sushi',2,350,27),
		   ('Apple',3,100,30),
		     ('Steik',2,150,235),
			  ('RAM',5,235,200),
			   ('SSD',5,142,150),
			    ('VIDEO CARD',5,123,1350),
				 ('Potatoes',4,50,21),
				  ('Broccoli',4,50,25)

INSERT Category([Name],[Description])
VALUES('Alcohol Drink','you can drink after 18+'),
		('Food','fresh food'),
		  ('Fruit','fresh fruit'),
		   ('Vegetables','fresh vegatales'),
		     ('Electronics','PC Technology')

INSERT Employee
VALUES(2,1,'Cavid','Alakbarov',26,1520),
		(6,5,'Ruslan','Ibrahimov',23,2500),
		 (4,2,'Fidan','Kerimova',18,1358),
		  (10,2,'Valeh','Agayev',35,1520),
		   (2,1,'Onur','Ibadov',23,1520),
		    (1,1,'Cavid','Alakbarov',26,1520),
			 (8,5,'Ruslan','Ibrahimov',23,2500),
			  (2,1,'Nicat','Huseynli',18,2450),
			   (7,5,'Ruslan','Ibrahimov',23,2500),
			    (1,1,'Ali','Rehimov',24,2020),
				 (9,4,'Zahid','Nureliyev',22,1410),
				  (10,4,'Ayan','Huseynova',19,1520),
				   (1,1,'Cavid','Alakbarov',26,1520),
				    (10,2,'Aqil','Qarayev',30,950),
					 (4,3,'Sveta','Qarayeva',21,1520)

CREATE TABLE EmployessLog(
ID INT PRIMARY KEY IDENTITY,
Logdata NVARCHAR(MAX)
)
CREATE TRIGGER EmployeesTriggerLog
ON Employees
Instead of DELETE,INSERT,UPDATE
AS
DECLARE @DeleteEmp NVARCHAR(MAX), @InsertEmp NVARCHAR(MAX)
SELECT @DeleteEmp=[Name] FROM deleted
SELECT @InsertEmp=[Name] FROM inserted
INSERT EmployessLog VALUES(SUSER_SNAME()+ ' Adi isci terefinden ' + 
' saat: ' + CAST(GETDATE() AS NVARCHAR(MAX))+ '  adi ' + @DeleteEmp +
'  olan iscini '+ @InsertEmp + '  yeni adi ile evez etmek isteyib')
CREATE TRIGGER EmployeesTrigger
ON Employees
AFTER INSERT
AS 
SELECT @@IDENTITY

Insert Employees([Name],[LastName],[Age],[Salary])
Values ('Fikret','Emirov',56,1536)

CREATE VIEW CategoryAndOrder
AS SELECT [C].[Name], SUM([O].[Unit price])as [Sum Unit Price Category]
FROM [Category] [C] INNER JOIN [Order][O] 
ON C.Id=[O].[CategoryId] GROUP BY [C].[Name]