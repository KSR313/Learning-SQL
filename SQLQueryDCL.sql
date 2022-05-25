
-----------------------GRANT-----------------------------------
GRANT privileges_names ON object TO user;

GRANT SELECT ON Users TO'Amit'@'localhost';

--to all user
GRANT SELECT  ON Users TO '*'@'localhost';

--many privileges
GRANT SELECT, INSERT, DELETE, UPDATE ON Users TO 'Amit'@'localhost';
--ALL privileges
GRANT ALL ON Users TO 'Amit'@'localhost';

--دسترسی به اجرای تابع یا رویه ها
GRANT EXECUTE ON [ PROCEDURE | FUNCTION ] object TO user;

--display GRANTS
SHOW GRANTS FOR  'Amit'@'localhost'; 

---------------------------revoke---------------------------
REVOKE privileges ON object FROM user;

REVOKE SELECT, INSERT, DELETE, UPDATE ON Users TO 'Amit'@'localhost'; 

REVOKE ALL ON Users TO 'Amit'@'localhost'; 

REVOKE EXECUTE ON [ PROCEDURE | FUNCTION ] object FROM user; 
REVOKE EXECUTE ON FUNCTION Calculatesalary TO 'Amit'@'localhost'; 

--------------------------------DENY----------------------------------
DENY UPDATE ON USERS TO 'amir';