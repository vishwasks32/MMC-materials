-- This is a comment
-- This file contains the queries executed during the session
-- ON 02 Aug 2024

-- To See the list of databases
SHOW databases;

-- To use the northwind database
USE Northwind;

-- To list the tables
SHOW TABLES;

-- To describe structure of a table
DESCRIBE employees;

-- To see all records of the table employees
SELECT * FROM employees;

-- To see selected columns
SELECT LastName, FirstName FROM employees;

-- To filter record based on lastname
SELECT * FROM employees WHERE LastName='King';

-- Get all the customers from UK
SELECT * FROM customers WHERE Country='UK';

-- get all the orders where number of items is greater than 25
SELECT * FROM orderdetails WHERE Quantity > 25;

-- get customers where country is not uk
SELECT * FROM customers WHERE country <> 'UK';
SELECT * FROM customers WHERE country != 'UK';

-- get all customers whose country name ends in 'den'
SELECT * FROM customers WHERE Country LIKE '%den';

-- % for 0 or more characters
-- _ for single character
-- in a more advanced way we can use regexp

-- get all customers whose country starts with den
SELECT * FROM customers WHERE Country LIKE 'den%';
SELECT * FROM customers WHERE Country LIKE '%den%';

-- get the customers whose name has 'im' in second & 3rd characters
SELECT * FROM customers WHERE CustomerName LIKE '_im%';

-- To get customers from UK, Mexico
SELECT * FROM customers WHERE Country IN ('UK', 'Mexico');

-- Get distinct countries FROM customer table
SELECT distinct Country FROM customers;

-- get employees born between 1958 and 1968;
select * from employees where YEAR(birthdate) > '1958'AND YEAR(birthdate) < '1968';
SELECT * FROM employees WHERE year(Birthdate) between 1958 AND 1968;

-- Sorting
SELECT * FROM employees ORDER BY BirthDate DESC;

-- Aggregate function - MIN, MAX, AVG, COUNT, SUM
-- get number of products whose price is greater than 50
SELECT COUNT(*) FROM products WHERE price > 50;
SELECT COUNT(price) FROM products WHERE price > 50;

-- how many distinct countries are there in customers table
SELECT COUNT(DISTINCT COUNTRY) FROM customers;

-- get the orders and their total items
SELECT SUM(Quantity) FROM orderdetails GROUP BY orderID;

-- get the country and number of customers only for those countries
-- where number of customers > 5
SELECT Country, count(customerID) FROM customers
GROUP BY Country
HAVING count(CustomerID)> 5;

-- Above query using sub-queries
SELECT countrycount, country FROM
 (
SELECT count(customerID) AS countrycount, country FROM customers
GROUP BY Country
) AS subquery
WHERE countrycount > 5;

-- Get orderdetails for all the orders with their customer ids
SELECT o.orderID, o.customerID, od.productID, od.Quantity FROM orderdetails od
INNER JOIN orders o
ON o.OrderID = od.OrderID;

SELECT o.orderID, o.customerID, od.productID, od.Quantity FROM orderdetails od
INNER JOIN orders o
USING(orderID);

-- get all the customers with their orders(RIGHT JOIN)
SELECT o.orderID, c.customerName, c.CustomerID FROM orders o
RIGHT JOIN customers c
ON o.CustomerID = c.CustomerID order by o.OrderID;

-- get all the customers with their orders(LEFT JOIN)
SELECT o.orderID, c.customerName FROM customers c
LEFT JOIN orders o 
ON  c.CustomerID = o.CustomerID;

-- Customer and order data one below the other
SELECT customerid, customername FROM customers 
UNION
SELECT customerid,orderid FROM orders;

-- Find the customers who have placed orders worth more than 
-- the average order value
-- See which tables contain data
SELECT * FROM orderdetails;
SELECT * FROM products;

-- First lets get the total of each order
SELECT o.orderid,SUM(p.price*o.quantity) AS Total FROM OrderDetails o
INNER JOIN Products p
ON o.productID=p.ProductID
GROUP BY OrderID;

-- Get the average of totals
SELECT AVG(total) FROM (
SELECT o.orderid as ordid,SUM(p.price*o.quantity) AS Total FROM OrderDetails o
INNER JOIN Products p
ON o.productID=p.ProductID
GROUP BY OrderID
) as innertable;

-- Implement the last step