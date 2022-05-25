
--حذف اطلاعات یک جدول نه خودش
TRUNCATE TABLE Categories;

------------------------ create index-----------------------------
CREATE UNIQUE INDEX index_name
ON table_name (column1, column2, ...);

--uniqe
CREATE UNIQUE INDEX index_name
ON table_name (column1, column2, ...);

--example
CREATE INDEX idx_pname
ON Students(StudentCode, StudentsName);

--delete
DROP INDEX table_name.index_name;

---------------create view----------------------------------------
CREATE VIEW view_1 AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;


CREATE VIEW view_1 AS
select  *
from Students
where Sex=1

-- use view
select city
from view_1

-- view for average any student
CREATE VIEW view_avg AS
select  Term.StudentCode,avg(grade) as avgg
from Students join Term on (Students.StudentsCode = Term.StudentCode) join Courses on (Term.CoursesCode = Courses.CoursesCode)
group by Term.StudentCode

-- use view
select avgg
from view_avg

-- FOR INSTANCE
CREATE VIEW [Products Above Average Price] AS
SELECT ProductName, Price
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

--delete view
DROP VIEW view_name;

--update view
CREATE OR REPLACE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;

CREATE OR REPLACE VIEW [Brazil Customers] AS
SELECT CustomerName, ContactName, City
FROM Customers
WHERE Country = 'Brazil';


---------------------create function-----------------------
--
-- توابع سیستمی .1 
https://www.sqlservertutorial.net/sql-server-system-functions/
--2. توابع رشته ای
https://www.sqlservertutorial.net/sql-server-string-functions/
--3. توابع زمان  تاریخ
https://www.sqlservertutorial.net/sql-server-date-functions/

-- شماره دانشجویی و سن دانشجویانی که سال تولد آنها بزرگتر از 1986 است
SELECT  s#,datediff (yy,getdate( ),birthdate)  FROM  STD  WHERE  Datepart(yy,birthdate)>1986

--4. توابع ریاضی
https://www.sqlservertutorial.net/sql-server-aggregate-functions/
--5. سایر توابع 
https://www.sqlservertutorial.net/sql-server-window-functions/


--User Defined Function = UDF

CREATE FUNCTION [database_name.]function_name (parameters)
RETURNS data_type AS

BEGIN
    SQL statements
    RETURN value
END;


-- EDIT function
ALTER FUNCTION [database_name.]function_name (parameters)
RETURNS data_type AS
BEGIN
    SQL statements
    RETURN value
END;
    
-- delete function
DROP FUNCTION [database_name.]function_name;

-----examples
--return scaler
-- دریافت شماره تلفن و ایمیل و شهر و بازگرداندن آن ها به صورت یک رشته بهم پیوسته
ALTER function fun_JoinEmpColumnInfo  
(  
   @EmpContact nchar(15),  
   @EmpEmail nvarchar(50),  
   @EmpCity varchar(30)  
)  
returns nvarchar(100) as  
begin 
return(select @EmpContact+ N'سلام' +@EmpEmail+ '%' + @EmpCity)  
end;


-- با دریافت شماره دانشجویی و شماره ترم معدل آن ترم را بر می گرداند

create function fn_TrmGpa(@s# int,@TrmNo char(4))
returns dec(5,1)
begin
DECLARE @TotGrade  dec(5,1)
DECLARE @TrmRegUnit dec(5,1)
select @TrmRegUnit=sum(CRS.Unit),@TotGrade=sum(REG.Grade*CRS.Unit)

    from REG,CRS  WHERE

         REG.c# = CRS.c#

          and

         REG.TrmNo = @TrmNo

          and

         REG.s#=@s#

return(@TotGrade/@TrmRegUnit)
end;

SELECT  dbo.fn_TrmGpa(8008093,'3802')


--return table
ALTER function Fun_StudentsInformation()      
returns table  as     
begin
return(select * from Students) 
end;

--use func
print dbo.fun_JoinEmpColumnInfo('ali' , 'eii', 'elli') 

select dbo.Fun_StudentsInformation();


----------------------create cursor-------------------------
https://darsman.com/course/learn-to-work-with-cursors-in-sql-server/
--برای حر کت روی همه ی سطرهای جدول از حلقه وایل استفاده میکنیم و اسم و فامیل و شماره مشتری هارا نمایش میدهیم
Declare @fname nvarchar(100),@lname nvarchar(100),@stateCode tinyint
Declare cr Cursor
For(
          Select StudentCode,StudentsName,Sex
          From Students
)
Open cr
          fetch next from cr into @fname,@lname,@stateCode
          while(@@FETCH_STATUS=0)
          begin
                   Print(@fname + ' '+ @lname + ' '+Cast(@stateCode as nvarchar(20)))
                   fetch next from cr into @fname,@lname,@stateCode
          end
Close cr
Deallocate cr


--بروز رسانی سطرهای جدول
Declare @fname nvarchar(100),@lname nvarchar(100),@stateCode tinyint
Declare cr Cursor
For(
          Select StudentCode,StudentsName,Sex
          From Students
)
for update of LName
Open cr
          fetch next from cr into @fname,@lname,@stateCode
          while(@@FETCH_STATUS=0)
          begin
                   update Customers
                   Set LName='*'+LName+'*'
                   where current of cr
                   fetch next from cr into @fname,@lname,@stateCode
          end
Close cr
Deallocate cr


--scroll cursor
Declare @sum int =0
Declare @fname nvarchar(100),@lname nvarchar(100),@stateCode tinyint
Declare cr scroll Cursor
For(
          Select StudentCode,StudentsName,Sex
          From Students
)
Open cr
          fetch absolute 5 from cr into @fname,@lname,@stateCode
          while(@@FETCH_STATUS=0)
          begin
                   Set @sum+=@stateCode
                   Print(@fname + ' '+ @lname + ' '+Cast(@stateCode as nvarchar(20)))
                   print(@sum)
                   fetch relative 3 from cr into @fname,@lname,@stateCode
          end
Close cr
Deallocate cr


----------------------------create store procedure-------------------------
http://mehrtash-souri.ir/article/67/1/Stored-Procedure-%D8%AF%D8%B1-SQL-Server
CREATE PROCEDURE procedure_name
AS
BEGIN
sql_statement
END
--run
EXEC procedure_name;

--example
CREATE PROCEDURE SelectAllCustomers @City nvarchar(30)
AS
begin
SELECT * FROM Customers WHERE City = @City
end


--run example
EXEC SelectAllCustomers @City = 'London';
--OR
SelectAllCustomers 'London'
--OR
SelectAllCustomers 
@City 'London'

--
CREATE PROCEDURE SelectAllCustomers @City nvarchar(30), @PostalCode nvarchar(10)
AS
BEGIN
SELECT * FROM Customers WHERE City = @City AND PostalCode = @PostalCode
END
GO;
--
EXEC SelectAllCustomers @City = 'London', @PostalCode = 'WA1 1DP';

--دوباره کامپایل بشه
Execute pr_reg 
@S#= 8014681,@TRMNO=3822,@C#=1116554,@trmregunit output  
with recompile

--مثال با شرط  IF
create procedure InsertFirstName (@firatname nvarchar(100))
as
if @firatname like N'%آقای%'
insert into Student(FirstName) values(@firatname)
else
insert into Student (FirstName) values(N'آقای'+ Space(2)+ @firatname)
go
---------------------------cte--------------------------------------
https://www.dntips.ir/post/1478/%D8%A2%D8%B4%D9%86%D8%A7%DB%8C%DB%8C-%D8%A8%D8%A7-sql-server-common-table-expressions-cte

--غیر بازگشتی
WITH yourName [(Column1, Column2, ...)]
AS
(
   your query
)

--example
WITH digitList
AS
(
   SELECT [digit] from [digits]
)

--USE
SELECT
   a.[digit] * 10 + b.[digit] + 1 AS [Digit]
FROM [digitList] AS a CROSS JOIN [digitList] AS b

--بازگشتی
WITH cteName AS
(
   query1
   UNION ALL
   query2
)

--EXAMPLE
WITH cteReports(EmpID, FirstName, LastName, MgrID, EmpLevel)
AS
(
SELECT EmployeeID, FirstName, LastName, ManagerID, 1
FROM Employees
WHERE ManagerID ISNULL
UNION ALL
SELECT e.EmployeeID, e.FirstName, e.LastName, e.ManagerID,r.EmpLevel + 1
FROM Employees e INNERJOINcteReports r
ON e.ManagerID = r.EmpID
)

SELECT FirstName +' '+ LastName 
FROM Employees
WHERE EmployeeID = cteReports.MgrID AS Manager
FROM cteReports
ORDER BY EmpLevel, MgrID

----------------------------------sequence----------------------------
http://www.tahlildadeh.com/ArticleDetails/%D8%A2%D9%85%D9%88%D8%B2%D8%B4-Sequence-SQL-Server
--example
USE University6;
GO
CREATE SEQUENCE University6.SeqStudents
    AS Int
    START WITH   1
    INCREMENT BY 1;
GO
-- example
CREATE SCHEMA Inventory;
GO
CREATE SEQUENCE Inventory.ItemsCodes
    AS int
    START WITH 10001
    INCREMENT BY 1;
GO
CREATE TABLE Inventory.StoreItems
(
    ItemNumber int,
    ItemName nvarchar(60),
    UnitPrice money
);
GO
INSERT INTO Inventory.StoreItems
VALUES(NEXT VALUE FOR Inventory.ItemsCodes, N'Short Sleeve Shirt', 34.95),
      (NEXT VALUE FOR Inventory.ItemsCodes, N'Tweed Jacket', 155.00),
      (NEXT VALUE FOR Inventory.ItemsCodes, N'Evaded Mini-Skirt', 72.45),
      (NEXT VALUE FOR Inventory.ItemsCodes, N'Lombardi Men''s Shoes', 79.95);
GO
--------------------------------trigger----------------------------------------
http://mehrtash-souri.ir/article/68/1/Trigger-%D8%AF%D8%B1-SQL-Server
https://www.mssqltips.com/sqlservertip/5909/sql-server-trigger-example/
CREATE TRIGGER trigger_name   
ON { Table name or view name }   
[ WITH <Options> ]  
{ FOR | AFTER | INSTEAD OF }   
{ [INSERT], [UPDATE] , [DELETE] }



--تریگری بروی جدول شاگردان بنویسید که اگر آپدیتی بروی این جدول رخ داد زمان آنرا در جدولی ذخیره کند.
create trigger t1 on student
for update
as
insert into mylog ([TimeOfAct]) values (GETDATE())

--تریگریی بنویسید که جلو آپدیت فیلد های جدول شاگردان را بگیرد
create trigger t2 on student
instead of update
as
insert into mylog([TimeOfAct]) values (getdate())




--
--
create TRIGGER Sample_logon_Trigger
ON ALL SERVER
FOR LOGON
AS
BEGIN
INSERT INTO School.dbo.mylog ([TimeOfAct],NewFirstName) values (getdate(),'login')

END


--برای فعال کردن یک تریگر
ENABLE TRIGGER { [ schema_name . ] trigger_name [ ,...n ] | ALL }
ON { object_name | DATABASE | ALL SERVER } [ ; ]

--برای غیر فعال کردن
DISABLE TRIGGER { [ schema_name . ] trigger_name [ ,...n ] | ALL }
ON { object_name | DATABASE | ALL SERVER } [ ; ]

-------------------------temporal table-----------------------------
--جدول میانی که وجود نداره
SELECT * INTO newtable [IN externaldb]
FROM oldtable
WHERE condition;

--
SELECT * INTO Students IN 'Backup.mdb'
FROM Customers;

--جدول میانی که وجود داره
INSERT INTO table2 (column1, column2, column3, ...)
SELECT column1, column2, column3, ...
FROM oldtable
WHERE condition;

INSERT INTO Customers (CustomerName, City, Country)
SELECT SupplierName, City, Country FROM Suppliers
WHERE Country='Germany';

select * into #نام جدول موقت
from student
where Age>25
-- روی جدول موقت کوئری هم میتونیم بزنیم

select *
from  #ST2

