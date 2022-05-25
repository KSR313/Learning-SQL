http://mehrtash-souri.ir/article/69/1/Transactions-%D8%AF%D8%B1-SQL-Server
-------------------------------------------------------------------
 CREATE TABLE Product (  
 Product_id INT PRIMARY KEY,   
 Product_name VARCHAR(40),   
 Price INT,  
 Quantity INT  
);

set IDENTITY_INSERT ON;
INSERT INTO Product VALUES(111, 'Mobile', 10000, 10),  
(112, 'Laptop', 20000, 15),  
(113, 'Mouse', 300, 20),  
(114, 'Hard Disk', 4000, 25),  
(115, 'Speaker', 3000, 20);  
GO

-----------------------------implicit-----------------------
SET IMPLICIT_TRANSACTIONS ON;
INSERT INTO Product VALUES(116, 'Headphone', 2000, 30)  
UPDATE Product SET Price = 450 WHERE Product_id = 113  
ROLLBACK;
--  بازیابی آی دی پاک شده
DBCC CHECKIDENT ('Color',RESEED,2);

-----------------------------explicit-----------------------
BEGIN TRANSACTION  
INSERT INTO Product VALUES(115,'Speaker', 3000, 25)  
-- Check for error  
IF(@@ERROR > 0)  
BEGIN  
    ROLLBACK TRANSACTION  
END  
ELSE  
BEGIN  
   COMMIT TRANSACTION  
END  
------------------------try catch--------------------------------------------
BEGIN TRANSACTION  

begin try
return
INSERT INTO Product VALUES(118, 'Desktop', 25000, 15)  
UPDATE Product SET Quantity = 'ten' WHERE Product_id = 113  
COMMIT TRANSACTION 
end 

begin catch
    ROLLBACK TRANSACTION  
end

----------------------------SAVE POINT------------------------------
BEGIN TRANSACTION   

INSERT INTO Product VALUES(117, 'USB Drive', 1500, 10)  

SAVE TRANSACTION a  
DELETE FROM Product WHERE Product_id = 116  
SELECT * FROM Product   

ROLLBACK TRANSACTION a 
COMMIT  TRANSACTION

SELECT * FROM Product;

---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------
---------------------------------------------------------------------