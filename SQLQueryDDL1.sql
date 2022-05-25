
--comment = توضیح
--command = فرمان

--single line for comment

/*
multy lines for comments
*/


------------------create database-------------------------
create database university1;

------------------create database with option-------------
create database university ON PRIMARY (
name='university',
filename='C:\Users\User\Desktop\نشریه\present sql\university.mdf',
size=10MB,
maxsize=unlimited,
filegrowth=50%
)
LOG ON
(
name='university_log',
filename='C:\Users\User\Desktop\نشریه\present sql\DB1.ldf',
size = 10MB,
maxsize=unlimited,
filegrowth=50%
);

------------------Delete Database---------------------------
DROP DATABASE hospital;

-------------------get backupfrom database-------------------
BACKUP DATABASE university
TO DISK = 'C:\Users\User\Desktop\نشریه\present sql\backup\backup_university_db.bak'
WITH DIFFERENTIAL;

-------------------------------constraints-----------------------------------------------------------
/*he following constraints are commonly used in SQL:

NOT NULL - Ensures that a column cannot have a NULL value
UNIQUE - Ensures that all values in a column are different
PRIMARY KEY - A combination of a NOT NULL and UNIQUE. Uniquely identifies each row in a table
FOREIGN KEY - Prevents actions that would destroy links between tables
CHECK - Ensures that the values in a column satisfies a specific condition
DEFAULT - Sets a default value for a column if no value is specified
CREATE INDEX - Used to create and retrieve data from the database very quickly
*/
------------------------------------------------------------------------------------------------------


--------------------create table-----------------------------
-- general form
CREATE TABLE table_name (
  column_1 datatype, 
  column_2 datatype, 
  column_3 datatype
);

--we have 4 table
create table Students (
	StudentsName nvarchar(100) NOT NULL,
	StudentsCode  int NOT NULL,
	Sex    bit NOT NULL,
	city   nvarchar(50) NOT NULL,
	ads    char(1000) NOT NULL,
	PRIMARY KEY(StudentsCode)
);

create table Courses(
	CoursesName nvarchar(100),
	CoursesCode  int NOT NULL PRIMARY KEY,
	unit         int,
	Dep          char(4)
);

create table Teachers(
	TeachersName nvarchar(100),
	TeachersCode  int,
	salary   float(30),
	phone    int
	CONSTRAINT PK_Teachers PRIMARY KEY (TeachersCode)
);


create table Tea(
	TName nvarchar(100),
	TCode  int primary key,
	s   float(30),
	p   int
);

--چند فیلد باهم کلید باشند
create table Term(
	CoursesCode  int,
	StudentCode  int FOREIGN KEY REFERENCES Students(StudentsCode),
	TeachersCode int,
	grade      int,
	CONSTRAINT PK_Term PRIMARY KEY(CoursesCode,StudentCode,TeachersCode),
	CONSTRAINT FK_TeachersCode FOREIGN KEY (TeachersCode) REFERENCES Teachers(TeachersCode),
	FOREIGN KEY (CoursesCode)  REFERENCES Courses(CoursesCode)
	ON UPDATE CASCADE
);
-- ON UPDATE CASCADE یا set null یا  set defualt  یا  no action
-- ON DELETE CASCADE یا set null یا  set defualt  یا  no action

--دیدن تعداد کلیدهای خارجی
select schema_name(fk_tab.schema_id) + '.' + fk_tab.name as [table],count(*) foreign_keys, count (distinct referenced_object_id) referenced_tables
from sys.foreign_keys fk
inner join sys.tables fk_tab
on fk_tab.object_id = fk.parent_object_id
group by schema_name(fk_tab.schema_id) + '.' + fk_tab.name
order by count(*) desc

-- https://www.w3schools.com/sql/sql_foreignkey.asp

------------------delete table--------------------------
DROP TABLE table_name;
drop table Term;

-----------------add or delete columns in table---------

ALTER TABLE Courses 
ADD grade int;


ALTER TABLE Students
ADD PRIMARY KEY (StudentCode);


ALTER TABLE Students
DROP CONSTRAINT PK_Students;


ALTER TABLE Term
ADD FOREIGN KEY (TeachersCode) REFERENCES Teachers(TeachersCode);


ALTER TABLE Term
ADD CONSTRAINT FK_TeachersCode
FOREIGN KEY (TeachersCode) REFERENCES Teachers(TeachersCode);


ALTER TABLE Term
DROP CONSTRAINT FK_StudentCode;

--------------------check--------------------------

CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int CHECK (Age>=18 ) not null
);


CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City varchar(255),
    CONSTRAINT CHK_Person CHECK (Age>=18 AND City=N'Sandnes')
);

CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City varchar(255),
    CONSTRAINT CHK_Person CHECK (ID BETWEEN 1 and 10000)
);

------------------------DEFAULT---------------------------
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    City varchar(255) DEFAULT N'Sandnes'
);


CREATE TABLE Orders (
    ID int NOT NULL,
    OrderNumber int NOT NULL,
    OrderDate date DEFAULT GETDATE()
);

--add DEFAULT
ALTER TABLE Persons
ADD CONSTRAINT DF_City
DEFAULT 'Sandnes' FOR City;

--drop DEFAULT
ALTER TABLE Persons
ALTER COLUMN City DROP DEFAULT;

---------------------------------uniqe-----------------------
CREATE TABLE Persons (
    ID int NOT NULL UNIQUE,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);


CREATE TABLE Persons (
    ID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    CONSTRAINT UC_Person UNIQUE (ID,LastName)
);

--alter
ALTER TABLE Persons
ADD UNIQUE (ID);

ALTER TABLE Persons
ADD CONSTRAINT UC_Person UNIQUE (ID,LastName);

-- drop
ALTER TABLE Persons
DROP CONSTRAINT UC_Person;


----
--uniqe              UC
--PRIMARY KEY        PK
--FORIGHN KEY        FK
--CHECK              CHK
--DEFUALT            DF

-------------Auoto increment----------------------
--(start, step)
CREATE TABLE Persons (
    Personid int IDENTITY(1,1) PRIMARY KEY,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int
);

--------------------------------------------------