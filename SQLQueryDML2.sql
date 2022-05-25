

------------------------ INNER join------------------------------------
https://www.sqlservertutorial.net/sql-server-basics/sql-server-joins/
SELECT column_name(s)
FROM table_1
JOIN table_2
  ON table_1.column_name = table_2.column_name;

--نمره های آنا
SELECT grade
FROM Students
INNER JOIN Term
  ON (Students.StudentsCode = Term.StudentCode) and StudentsName='anna';


--JOIN
SELECT grade
FROM Students, Term
WHERE Students.StudentsCode = Term.StudentCode and StudentsName='anna';

--نمره های ریاضی آنا
SELECT grade
FROM Students 
inner join Term
ON (Students.StudentsCode = Term.StudentCode) inner join Courses on(Term.CoursesCode = Courses.CoursesCode) and (StudentsName='anna') and (CoursesName='riazi');


SELECT grade
FROM Students ,Term , Courses
where (Students.StudentCode = Term.StudentCode) and (Courses.CoursesCode=Term.CoursesCode) and StudentsName='anna' and CoursesName='riazi';

------------------------left join---------------------------
SELECT column_name(s)
FROM table_1
LEFT JOIN table_2
  ON table_1.column_name = table_2.column_name

--دانشجویانی که انتخاب واحد کرده اند با تکراری 
SELECT StudentsName
FROM Term 
LEFT JOIN Students ON ( Students.StudentsCode=Term.StudentCode );


SELECT StudentsName
FROM Students
LEFT JOIN Term ON ( Students.StudentsCode=Term.StudentCode );

-- انتخاب واحد کرده ها بدون تکراری
SELECT StudentsName
FROM Term 
LEFT JOIN Students ON ( Students.StudentsCode=Term.StudentCode )
group by StudentsName;
-----------------------right join------------------------------
SELECT column_name(s)
FROM table1
RIGHT JOIN table2
ON table1.column_name = table2.column_name;

-- نام دانشجویانی که انتخاب واحد کرده اند
SELECT StudentsName
FROM Students 
right JOIN Term ON ( Students.StudentsCode=Term.StudentCode );

--------------------------full outer join---------------------------------------------
https://www.sqlservertutorial.net/sql-server-basics/sql-server-full-outer-join/

SELECT StudentsName
FROM Students 
FULL OUTER JOIN Term ON ( Students.StudentsCode=Term.StudentCode );

----------------------------self join-------------------------------------------------
https://www.sqlservertutorial.net/sql-server-basics/sql-server-self-join/

SELECT e.first_name + ' ' + e.last_name employee, m.first_name + ' ' + m.last_name manager
FROM sales.staffs e
INNER JOIN sales.staffs m ON m.staff_id = e.manager_id
ORDER BY manager;

--------------------------------cross join--------------------------------------------
https://www.sqlservertutorial.net/sql-server-basics/sql-server-cross-join/

SELECT *
FROM  Term
CROSS JOIN Students;


-------------------------merge-----------------------------------------
https://www.sqlservertutorial.net/sql-server-basics/sql-server-merge/


------------------------create a block for multi-task and show a massage------------------------------
SELECT column_name,
  CASE
    WHEN condition THEN 'Result_1'
    WHEN condition THEN 'Result_2'
    ELSE 'Result_3'
  END
FROM table_name

-- آیا این دانشجو دختر است یا نه
select StudentsName,
CASE
		when Sex = 0 then 'she is not a girl'
		when Sex = 1 then 'she is a girl'
END  as girl_or_no
FROM Students

------------------------AND------------------------------
SELECT column_name(s)
FROM table_name
WHERE column_1 = value_1
  AND column_2 = value_2;

--
SELECT StudentsName
FROM Students 
where (Sex = 0) and (city='qo');

----------------------OR---------------------------------
SELECT column_name
FROM table_name
WHERE column_name = value_1
   OR column_name = value_2;

-- درسی که سه واحدی باشه یا دانشکده شیمی ارائه کرده
select CoursesName
from Courses
where unit=3 or Dep='shi'

-----------------------BETWEEN--------------------------------
SELECT column_name(s)
FROM table_name
WHERE column_name BETWEEN value_1 AND value_2;

--نمره بین 12 و 19
select grade
from Term
where grade between 12 and 19

---------------------------is null------------------------------
SELECT column_name(s)
FROM table_name
WHERE column_name IS NULL;

--
select grade
from Term
where StudentCode is not null

--
select grade
from Term
where StudentCode is  null

------------------------ISNULL()-----------------------------
https://www.w3schools.com/sql/func_sqlserver_isnull.asp

-------------------------like--------------------------------
SELECT column_name(s)
FROM table_name
WHERE column_name LIKE pattern;

--حرف دوم ای باشه
select StudentsName
from Students
where StudentsName like '_a%';

--سه حرفی که حرف دوم ای باشه
select StudentsName
from Students
where StudentsName like '_a_';

-- حرف ال داره
select StudentsName
from Students
where StudentsName like '%l%';

--a اسامی با حرف اول
select StudentsName
from Students
where StudentsName like '[a]%'; 

==
--a اسامی با حرف اول
select StudentsName
from Students
where StudentsName like 'a_%';

-- شروع اسم a  یا  s
select StudentsName
from Students
where StudentsName like '[al]%';


-- start with 'a' or 'b' or 'c'
select StudentsName
from Students
where StudentsName like '[a-c]%';

--  با اس شروع نشه
select StudentsName
from Students
where StudentsName like '[^sad]%';

------------------------top---------------------------------
SELECT column_name(s)
FROM table_name
LIMIT number;

----سه تای اول

--mysql
select grade
from Term
LIMIT 3;


--sql server
select top 3 grade
from Term

-----پنجاه درصد اول
select top 50 percent grade
from Term

-------------------------while--------------------------------------
declare @i int
set @i=1
while (@i<=10)
begin
print @i
set @i=@i+1
end

------------------------nested query----------------------
DELETE FROM Grade 
SELECT StNo = [SELECT stNo FROM Student] 
WHERE Lname ='رضا'
--------------------------IN------------------------------
https://www.sqlservertutorial.net/sql-server-basics/sql-server-in/

column IN (v1, v2, v3)
equivalent
column = v1 OR column = v2 OR column = v3

column | expression IN (subquery)


--example
SELECT product_name,list_price
FROM production.products
WHERE list_price IN (89.99, 109.99, 159.99)
ORDER BY list_price;

--NOT IN
 SELECT product_name,list_price
FROM production.products
WHERE list_price NOT IN (89.99, 109.99, 159.99)
ORDER BY list_price;

SELECT product_name,list_price
FROM production.products
WHERE product_id IN ( SELECT product_id
                      FROM production.stocks
                      WHERE store_id = 1 AND quantity >= 30)
ORDER BY product_name;

------------------------ALL--------------------------------
SELECT ALL column_name(s)
FROM table_name
WHERE condition;


select all StudentsName
from Students

--
SELECT column_name(s)
FROM table_name
WHERE column_name operator ALL
  (SELECT column_name
   FROM table_name
   WHERE condition);
--
SELECT ProductName
FROM Products
WHERE ProductID = ALL
  (SELECT ProductID
  FROM OrderDetails
  WHERE Quantity = 10);

https://www.w3schools.com/sql/sql_any_all.asp

------------------------ANY--------------------------------
SELECT ANY column_name(s)
FROM table_name
WHERE condition;
--
SELECT column_name(s)
FROM table_name
WHERE column_name operator ANY
  (SELECT column_name
  FROM table_name
  WHERE condition);

--
SELECT ProductName
FROM Products
WHERE ProductID = ANY
  (SELECT ProductID
  FROM OrderDetails
  WHERE Quantity = 10);

--help
select Quantity 
from  OrderDetails
where ProductID = 41

------------------------unionاجتماع ------------------------------
SELECT column_name(s) FROM table1
UNION
SELECT column_name(s) FROM table2;

-- 

SELECT column_name(s) FROM table1
UNION ALL
SELECT column_name(s) FROM table2;

--
SELECT City FROM Customers
UNION
SELECT City FROM Suppliers
ORDER BY City;

https://www.w3schools.com/sql/sql_union.asp

----------------------------intersetاشتراک--------------------------------
SELECT column_name(s) FROM table1
INTERSECT
SELECT column_name(s) FROM table2;

--example
SELECT city
FROM sales.customers
INTERSECT
SELECT city
FROM sales.stores
ORDER BY city;
-----------------------------exceptتفاضل ---------------------------------
SELECT column_name(s) FROM table1
EXCEPT
SELECT column_name(s) FROM table2;

SELECT product_id
FROM production.products
EXCEPT
SELECT product_id
FROM sales.order_items;

-----------------------------Exist----------------------------------
https://www.w3schools.com/sql/sql_exists.asp
--The EXISTS operator is used to test for the existence of any record in a subquery.
--The EXISTS operator returns TRUE if the subquery returns one or more records.

SELECT column_name(s)
FROM table_name
WHERE EXISTS (SELECT column_name FROM table_name WHERE condition);


-- کد همه  دانشجویانی که انتخاب واحد کرده اند
select StudentsCode 
from Students
where StudentsCode IN (select StudentsCode from Term)


select StudentsCode 
from Students
where StudentsCode = (select StudentsCode from Term)


select StudentsCode 
from Students
where exists (select *
			  from Term
			  where Students.StudentsCode = Term.StudentCode)
	

-----------------------------not Exist------------------------------
--  اسم دانشجویانی که انتخاب واحد نکرده اند

select StudentName 
from Students
where  not exists (select *
			  from Term
			  where Students.StudentsCode = Term.StudentCode)
				


--دانشجویانی که هیچ درس ثبت نشده ای ندارند
select StudentsCode 
from Students
where  exists 
(                select *
				 from Term
				 where (Students.StudentsCode = Term.StudentCode) 
)


--اسم دانشجویانی که همه درس هارا انتخاب کرده اند
select StudentsName
from Students
where  not exists ( select * 
					from Term
					where not exists (select * 
									  from Courses
									  where (Term.CoursesCode=Courses.CoursesCode) and (Students.StudentsCode = Term.StudentCode)

					                  )

)


--حالات خاص
--NOT EXIST       EXIST            هیچ
--NOT EXIST       NOT EXIST        همه
--EXIST           EXIST            حداقل
--EXIST          NOT EXIST        بعضی     
