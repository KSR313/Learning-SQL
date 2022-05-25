
-- document MS SQL SERVER
https://docs.microsoft.com/en-us/sql/sql-server/?view=sql-server-ver15

--operator
https://www.w3schools.com/sql/sql_operators.asp

--wildcard
https://www.w3schools.com/sql/sql_wildcards.asp


------------------use special database-----------------------
USE university1
GO
SELECT StudentsName 
FROM Students

----------------special value------------------------
SELECT 1 as tt;
select 'abc';
SELECT 'HELLO'+' *    '+'KOSAR';
--------------------define variable-----------------------
declare @i int
set @i=133

select @i
declare @j nvarchar(5) = N'how'

select @j

select @i

---------------insert data in table-------------------
INSERT INTO table_name (column_1, column_2, column_3) 
VALUES (value_1, 'value_2', value_3);

INSERT INTO Teachers (TeachersName, TeachersCode, salary,phone)
VALUES ('hadi',1,300,0912333333);

INSERT INTO Teachers (TeachersName, TeachersCode, salary,phone)
VALUES ('mirzakhani',2,4500,0912666666);

INSERT INTO Teachers (TeachersName, TeachersCode, salary,phone)
VALUES ('ebnesina',3,6000,0912444444);

INSERT INTO Teachers (TeachersName, TeachersCode, salary,phone)
VALUES ('bakery',4,9700,0912888888);

INSERT INTO Teachers 
VALUES ('hafez',5,2300,0912222222);


-----
INSERT INTO Students (StudentsName, StudentsCode, Sex, city, ads)
VALUES ('ali',110,0,'a','aaaaaaaaaaaaaaaaaaaaa'),
	('narges',111,1,'n','nnnnnnnnnnnnnnnnnnnnnnn'),
	('anna',112,1,'an','ananananananananananan'),
	('sami',113,0,'s','sssssssssssssssssssssssss'),
	('sami',114,0,'qo','qoqoqoqoqoqoqoqoqoqoqoqoq');


----

INSERT INTO Courses (CoursesName, CoursesCode, unit, Dep)
VALUES ('riazi',001,3,'zir');

INSERT INTO Courses (CoursesName, CoursesCode, unit, Dep)
VALUES ('zaban',002,2,'eng');

INSERT INTO Courses (CoursesName, CoursesCode, unit, Dep)
VALUES ('shimi',003,3,'shi');

-------

INSERT INTO Term (CoursesCode, StudentCode, TeachersCode,grade)
VALUES (001,112,2,20);

INSERT INTO Term (CoursesCode, StudentCode, TeachersCode,grade)
VALUES (003,112,1,19);

INSERT INTO Term (CoursesCode, StudentCode, TeachersCode,grade)
VALUES (001,110,3,12);

INSERT INTO Term (CoursesCode, StudentCode, TeachersCode,grade)
VALUES (001,111,2,18);


-----------------------update inserted data------------------------
UPDATE table_name
SET some_column = some_value
WHERE some_column = some_value;

update Students
set Sex=1
where StudentsName='narges'

update Students
set Sex=1
where StudentsName='anna'

---------------------delete a row in the table------------------------
DELETE FROM table_name
WHERE some_column = some_value;

delete from Students
where city='qo';

-------------------------select----------------------------------------
SELECT [column name]
FROM table_name;

--نام دانشجویان با اسامی تکراری
select  Studentsname
from Students

select *
from Teachers;
--------------------select distinct-----------------
SELECT DISTINCT column_name
FROM table_name;

--نام دانشجویان با اسامی غیرتکراری
select distinct Studentsname
from Students

----------------------AS---------------------------
SELECT column_name AS 'Alias'
FROM table_name;

select  Studentsname as 'name'
from Students;

---------------------select with condition---------
SELECT column_name(s)
FROM table_name
WHERE column_name operator value;

select *
from Teachers

--نام دانشجویان دختر
select  Studentsname
from Students
where Sex=1

--آدرس دانشجویان دختر
select  ads
from Students
where Sex != 0

--کد درس زبان
select CoursesCode
from Courses
where CoursesName ='zaban'

--حقوق استاد ابن سینا
select salary
from Teachers
where TeachersName='ebnesina'

--------------------------aggregate function----------------
MIN()
MAX()
COUNT()
SUM()
AVG()
--------------------------max-------------------------------
SELECT MAX(column_name)
FROM table_name;


--بیشترین نمره
select max(grade) as max_grade
from Term

-------------------------min--------------------------------
SELECT MIN(column_name)
FROM table_name;

--کمترین نمره
select min(grade)
from Term

------------------------AVG------------------------------
SELECT AVG(column_name)
FROM table_name;

-- میانگین نمرات
select AVG(grade)
from Term
----------------------sum------------------------------------
SELECT SUM(column_name)
FROM table_name;

--جمع نمرات
select SUM(grade)
from Term
-----------------------counter-------------------------------
SELECT COUNT(column_name)
FROM table_name;

--تعداد دانشجویان   
select COUNT(StudentsName)
from Students

--تعداد دانشجویان پسر
select count(Sex)
from Students
where Sex=0
------------------group by -----------------------------
SELECT column_name, COUNT(*)
FROM table_name
GROUP BY column_name;

select Studentsname
from Students
group by Studentsname;

--AS--
select Studentsname as nnn ,COUNT(*) as num
from Students
group by Studentsname;

--error
select Studentsname,COUNT(*) as num
from Students
group by COUNT(*);



--having
SELECT column_name, COUNT(*)
FROM table_name
GROUP BY column_name
HAVING COUNT(*) > value;

-- دسته بندی براساس نام دانشجویان بیشتر از یک
select Studentsname,COUNT(*) AS KK
from Students
group by Studentsname
having COUNT(*) > 1;

-- دسته بندی براساس نام دانشجویان کمتر از دو
select Studentsname,COUNT(*) 
from Students
group by Studentsname
HAVING COUNT(*) < 2;

--شماره دانشجویی و میانگین نمرات دانشجویانی که میانگین آن ها از  10 بیشتره
select Studentsname, avg(grade) > 10 as average
from Term
group by Studentsname
--کد بالا ارور میدهد زیرا از عملگرها در سلکت نمیتوانیم استفاده کنیم


--کد صحیح
select StudentCode, avg(grade) as average
from Term
group by StudentCode
having avg(grade) >10

------------------------order by--------------------------------
SELECT column_name
FROM table_name
ORDER BY column_name ASC | DESC;

-- نمرات به ترتیب پیش فرض صعودی اند 
select grade
from Term
order by grade 


-- نمرات به ترتیب صعودی
select grade
from Term
order by grade ASC

--نمرات به ترتیب نزولی
select grade
from Term
order by grade DESC

---------------order used groupby,having,orderby----------------
SELECT column_name(s)
FROM table_name
WHERE condition
GROUP BY column_name(s)
HAVING condition
ORDER BY column_name(s);
----------------------------------------------------------------

--------------------- ROUND-CAST-----------------------------------
--EXAMPLE
SELECT CAST(ROUND(AVG(list_price),2) AS DEC(10,2)) as avg_product_price
FROM production.products;

