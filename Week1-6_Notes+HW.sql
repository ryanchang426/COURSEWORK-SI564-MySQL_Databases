-- ------------------------------------------------ --
-- ------------------------------------------------ --
------------ MySQL Query Notes & Homework ------------
-- ------------------------------------------------ --
-- ------------------------------------------------ --

## Notes ##
-- every queries end with ";""
-- USE <database_name>: use a database
-- SHOW TABLES: 
-- DESC <table_name>: describe all fields, data type, and percies informations of tables
-- SELECT * FROM <table_name>: return all data from the table /// SELECT field1, field2... FROM <table_name> /// SELECT DISTINCT <field_name> FROM <table_name>: only return one unique entries of fieldnmame (can be useful in tables that have multiple rows for the same information)
-- LIMIT 0,50: will return first 50 rows
-- WHERE field = something /// WHERE field LIKE "Ry%": fuzzy matching /// WHERE field IN (1,2,3 or "A","B","C") ///  WHERE field BETWEEN something AND something
-- ORDER BY field /// ORDER BY DESC,ASC: descending (4321), ascending (1234) /// ORDER BY RAND() /// ORDER BY field1 DESC, field2 ASC


## HW3 ##
-- AND, OR, IN, BETWEEN (use with WHERE)
SELECT name, expenses FROM taxdata WHERE year=2013 AND name In ('KAISER FOUNDATION HEALTH PLAN INC','KAISER FOUNDATION HOSPITALS','Partners HealthCare System Inc & AffiliatesGroup Return','UPMC GROUP','DIGNITY HEALTH','Thrivent Financial for Lutherans','THE CLEVELAND CLINIC FOUNDATION GROUP RETURN','NEW YORK STATE CATHOLIC HEALTH PLANINC','Ochsner Clinic Foundation','NEW YORK UNIVERSITY','JOHNS HOPKINS UNIVERSITY','Trustees of the University of Pennsylvania','DELTA DENTAL OF CALIFORNIA','THE BOARD OF TRUSTEES OF THE LELAND STANFORDJUNIOR UNIVERSITY','CareSourc','PROVIDENCE HEALTH & SERVICES - WASHINGTON','BATTELLE MEMORIAL INSTITUTE','President and Fellows of Harvard College','THE CLEVELAND CLINIC FOUNDATION','WAL-MART STORES INCASSOCIATES" HEALTH & WELFARE TRUST');
SELECT ein, city FROM taxdata WHERE revenue BETWEEN 1 AND 100000 AND expenses BETWEEN 10000 AND 200000 ORDER BY RAND() LIMIT 20;
SELECT * FROM taxdata WHERE purpose LIKE 'toy%';
SELECT * FROM taxdata WHERE ptname LIKE 'smith%' AND revenue IS NOT NULL AND revenue > 0;
SELECT name , LENGTH(name) FROM taxdata WHERE ptid='P01345770' ORDER BY RAND() LIMIT 50;
SELECT * FROM taxdata WHERE LENGTH(purpose)<10 AND purpose IS NOT NULL;
SELECT COUNT(1) FROM employees WHERE YEAR(hire_date) in (1994,1995,1990);
SELECT COUNT(1) FROM titles WHERE title='Senior Engineer' AND from_date<='1986-06-26' AND to_date>='1986-06-26';
SELECT DISTINCT first_name, last_name FROM employees WHERE emp_no IN (SELECT emp_no FROM titles WHERE title LIKE '%Engineer%');


## HW4 ##
SELECT R1.RecipeTitle, R1.RecipeClassID, R2.RecipeClassDescription FROM Recipes R1 LEFT OUTER JOIN Recipe_Classes R2 ON R1.RecipeClassID=R2.RecipeClassID WHERE RecipeClassDescription LIKE '%Vegetable%' OR RecipeClassDescription LIKE '%Salad%';
SELECT e.fname emp_fname, e.lname emp_lname, d.name dept_name FROM employee e LEFT OUTER JOIN department d ON e.dept_id = d.dept_id WHERE name = 'Operations';
SELECT a.open_date acc_open_date, c.address cust_address, a.open_emp_id, e.fname emp_fname, e.lname emp_lname FROM account a LEFT OUTER JOIN customer c ON a.cust_id = c.cust_id LEFT OUTER JOIN employee e ON a.open_emp_id = e.emp_id WHERE fname='Paula' AND lname='Roberts';
SELECT emp_id, fname emp_fname, lname emp_lname, superior_emp_id FROM employee;
SELECT a.status acct_status, a.avail_balance acct_avail_balance, c.state cust_state, b.name bus_name FROM account a LEFT OUTER JOIN customer c ON a.cust_id = c.cust_id LEFT OUTER JOIN business b ON c.cust_id = b.cust_id WHERE a.status LIKE 'ACTIVE' ;
SELECT br.address br_address, e.fname emp_fname, e.lname emp_lname FROM branch br LEFT OUTER JOIN employee e ON br.branch_id = e.assigned_branch_id WHERE br.address LIKE '%422 Maple St.%';
SELECT c1.Name city_name, c1.population city_population, c2.Continent FROM city c1 LEFT OUTER JOIN country c2 ON c1.CountryCode = c2.Code WHERE c2.Continent != 'North America' AND c1.population>13000 AND c1.population<500000 ORDER BY RAND() LIMIT 5;
SELECT c1.Name city_name, c2.GovernmentForm FROM city c1 LEFT OUTER JOIN country c2 ON c1.CountryCode = c2.Code WHERE c2.GovernmentForm LIKE '%Constitutional Monarchy%';
SELECT c1.Name city_name, c1.population city_population, c2.Language, c3.GovernmentForm FROM city c1 LEFT OUTER JOIN countrylanguage c2 ON c1.CountryCode = c2.CountryCode LEFT OUTER JOIN country c3 ON c2.CountryCode = c3.Code WHERE c2.Language != 'English' AND c3.GovernmentForm NOT LIKE '%Republic%' AND c1.population>13000 AND c1.population<500000 ORDER BY RAND() LIMIT 5;


## HW5 ##
SELECT AVG(creditLimit) From customers;
SELECT c.customerName, c.phone, p.checkNumber, p.paymentDate, p.amount FROM customers c LEFT JOIN payments p ON c.customerNumber = p.customerNumber;
SELECT SUM(p.amount) FROM customers c LEFT JOIN payments p ON c.customerNumber = p.customerNumber WHERE c.phone = "2125558493";
SELECT SUM(p.amount) FROM customers c LEFT JOIN payments p ON c.customerNumber = p.customerNumber WHERE c.state = "NY";
SELECT SUM(p.amount) FROM customers c LEFT JOIN payments p ON c.customerNumber = p.customerNumber WHERE c.state != "NY";
SELECT o.orderNumber, od.priceEach From orders o LEFT JOIN orderdetails od ON o.orderNumber = od.orderNumber WHERE o.status = "Shipped";
SELECT e1.lastName, e1.firstName, e2.lastName, e2.firstName FROM employees e1 LEFT JOIN employees e2 ON e1.reportsTo = e2.employeeNumber;
SELECT p.buyPrice, p.MSRP, (p.MSRP-p.buyPrice) markup, LEFT(pl.textDescription,5) FROM products p LEFT JOIN productlines pl ON p.productLine = pl.productLine ORDER BY markup DESC LIMIT 5;
SELECT e.employeeNumber, e.lastName, e.firstName FROM orders o LEFT JOIN customers c ON o.customerNumber = c.customerNumber LEFT JOIN employees e ON c.salesRepEmployeeNumber = e.employeeNumber WHERE YEAR(o.orderDate) = 2005;
SELECT count(1) FROM customers c LEFT JOIN orders o ON c.customerNumber = o.customerNumber WHERE c.postalCode = "97562" OR c.postalCode = "80686" OR c.postalCode = "44000";

# the usage of GROUP BY #
cannot use SELECT* with GROUP BY

# the difference betweeen WHERE & HAVING #
WHERE : Filt before the GROUP BY (ex: WHERE quantity > 5)
HAVING : Filt after the GROUP BY (ex: HAVING SUM(quantity_1) > 5)


## HW6 ##
# PART1
SELECT COUNT(1), MONTH(birth_date) FROM employees GROUP BY MONTH(birth_date) ORDER BY MONTH(birth_date) ASC;
SELECT COUNT(1), hire_date FROM employees GROUP BY hire_date ORDER BY count(1) ASC
SELECT AVG(s.salary) FROM employees e JOIN salaries s ON e.emp_no = s.emp_no;
SELECT YEAR(e.hire_date), AVG(s.salary) FROM employees e JOIN salaries s ON e.emp_no = s.emp_no JOIN titles t ON e.emp_no = t.emp_no WHERE YEAR(t.to_date) = 9999 GROUP BY YEAR(e.hire_date) ORDER BY YEAR(e.hire_date) DESC ;
# PART2
SELECT u.name, AVG(fitbit_steps) FROM users_field_data u JOIN day_entity d ON u.uid = d.user_id WHERE MONTH(d.fitbit_date) = 7 GROUP BY u.name;
SELECT MONTH(f.fitbit_date), AVG(f.fitbit_timeinbed) FROM fitbit_sleep f JOIN users_field_data u ON u.uid = f.user_id WHERE u.name ="f9f67f5beddc05e72d4c1715c26df95d" GROUP BY MONTH(f.fitbit_date) ORDER BY MONTH(f.fitbit_date) ASC;
SELECT MONTH(fitbit_date), AVG(fitbit_timeinbed) FROM fitbit_sleep WHERE user_id = 907 GROUP BY MONTH(fitbit_date) ORDER BY MONTH(fitbit_date) ASC;
select * from users_field_data where name = "f9f67f5beddc05e72d4c1715c26df95d" ;
SELECT f.user_id, u.name, f.fitbit_date, f.fitbit_timeinbed FROM fitbit_sleep f JOIN users_field_data u ON u.uid = f.user_id WHERE f.fitbit_timeinbed/60 > 8;