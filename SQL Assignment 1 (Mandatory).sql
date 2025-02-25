--CREATING A DATABASE NAME SQL_Assignment1

Create database SQL_Assignment1
go 
use SQL_Assignment1

---Creating Tables Salesman, Customer and Orders using 'CREATE TABLE' Command and inserting the value into the tables using 'INSERT' command

CREATE TABLE Salesman(
    SalesmanId INT,
    Name VARCHAR(255),
    Commission DECIMAL(10, 2),
    City VARCHAR(255),
    Age INT
);
go
INSERT INTO Salesman (SalesmanId, Name, Commission, City, Age)
VALUES
    (101, 'Joe', 50, 'California', 17),
    (102, 'Simon', 75, 'Texas', 25),
    (103, 'Jessie', 105, 'Florida', 35),
    (104, 'Danny', 100, 'Texas', 22),
    (105, 'Lia', 65, 'New Jersey', 30);
go
CREATE TABLE Customer(
    SalesmanId INT,
    CustomerId INT,
    CustomerName VARCHAR(255),
    PurchaseAmount INT
);
go
INSERT INTO Customer (SalesmanId, CustomerId, CustomerName, PurchaseAmount)
VALUES
    (101, 2345, 'Andrew', 550),
    (103, 1575, 'Lucky', 4500),
    (104, 2345, 'Andrew', 4000),
    (107, 3747, 'Remona', 2700),
    (110, 4004, 'Julia', 4545);
go
CREATE TABLE Orders(
    OrderId INT,
    CustomerId INT,
    SalesmanId INT,
    Orderdate DATE,
    Amount MONEY
);
go
INSERT INTO Orders (OrderId, CustomerId, SalesmanId, Orderdate, Amount)
VALUES
    (5001, 2345, 101, '2021-07-01', 550),
    (5003, 1234, 105, '2022-02-15', 1500);

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*
TO check the name and the numbers of tables present in the database we can use:
*/

Select NAME
From sys.tables

/* 
To take the over view of how the tables look like we can use bellow statement:
*/

Select * from Salesman
Select * from Customer
Select * from Orders
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

/*
Problem no 1-- Insert a new record in Orders table.
Ans- To insert a new record into the Orders table, we use the INSERT INTO statement.
*/

INSERT INTO Orders (OrderId, CustomerId, SalesmanId, Orderdate, Amount)
VALUES (5004, 1575, 103, '2023-06-25', 3000);

-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

/*
Problem no 2--
Add Primary key constraint for SalesmanId column in Salesman table. 
Add default constraint for City column in Salesman table. 
Add Foreign key constraint for SalesmanId column in Customer table. 
Add not null constraint in Customer_name column for the Customer table.
*/

---- Make sure that there are no NULL values in SalesmanId column in Customer table using 'UPDATE' Statement:

UPDATE Customer
SET SalesmanId = 101
WHERE SalesmanId IS NULL
   OR SalesmanId NOT IN (SELECT SalesmanId FROM Salesman);

---- Add Primary key constraint to SalesmanId column in Salesman table ensuring that SalesmanID column is not null using Alter Statement:

ALTER TABLE Salesman
ALTER COLUMN SalesmanId INT NOT NULL;
ALTER TABLE Salesman
ADD CONSTRAINT PK_Salesman PRIMARY KEY (SalesmanId);

---- Add default constraint to City column in Salesman table where DEFAULT value is set to 'Dallas' using Alter Statement:

ALTER TABLE Salesman
ADD CONSTRAINT DF_Salesman_City DEFAULT 'Dallas' FOR City;

---- Add Foreign key constraint to SalesmanId column in Customer table using Alter Command :

ALTER TABLE Customer
ADD CONSTRAINT FK_Customer_Salesman FOREIGN KEY (SalesmanId)
REFERENCES Salesman (SalesmanId);

----- Add NOT NULL constraint to CustomerName column in Customer table making sure of it that the null vlues are replced with 'Sangeet' :

UPDATE Customer
SET CustomerName = 'Sangeet'
WHERE CustomerName IS NULL;

ALTER TABLE Customer
ALTER COLUMN CustomerName VARCHAR(255) NOT NULL;

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

/*
Problem no 3 ---
Fetch the data where the Customer’s name is ending with ‘N’ also get the purchase
amount value greater than 500
*/

/*To fetch the data from Customer where Customer's name is ending with 'N' we use "LIKE '%N'" command and check if the purchase
amount value greater than 500 we use arthematic operator '>' using 'WHERE' Condition:
*/

SELECT 
    CustomerId, 
    CustomerName, 
    PurchaseAmount
FROM 
    Customer
WHERE 
    CustomerName LIKE '%N' 
    AND PurchaseAmount > 500

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

/*
Problem no 4 ---
Using SET operators, retrieve the first result with unique SalesmanId values from two
tables, and the other result containing SalesmanId with duplicates from two tables.
*/

/*
Ans--
To use SET operators and retrieve the first result with unique SalesmanId values from two tables (Salesman and Customer), and another result
containing SalesmanId with duplicates, you can use the UNION and UNION :
*/

----Retrieve unique SalesmanId values from two tables using UNION:

SELECT SalesmanId
FROM Salesman

UNION

SELECT SalesmanId
FROM Customer;

---- Retrieve SalesmanId values with duplicates from two tables using UNION ALL:

SELECT SalesmanId
FROM Salesman

UNION ALL

SELECT SalesmanId
FROM Customer;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

/*
Problem no 5 ---
Display the below columns which has the matching data.
Orderdate, Salesman Name, Customer Name, Commission, and City which has the range of Purchase Amount between 500 to 1500
*/

SELECT O.Orderdate,
       S.Name as SalesmanName,
	   C.CustomerName,
	   S.Commission,
	   S.City
FROM Orders as O
JOIN Salesman as S ON O.SalesmanID = S.SalesmanID
JOIN Customer as C ON C.CustomerID = O.CustomerID
WHERE
C.PurchaseAmount BETWEEN 500 AND 1500 ;

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------

/*
Using Right Join Fetch all the results form Salesman and Orders Table
*/

Select top 1 * from Salesman
Select top 1 * from Customer
Select top 1 * from Orders


SELECT S.SalesmanID,
       S.Name as SalesmanName,
	   S.Commission,
	   S.City,
	   S.Age,
	   O.OrderID,
	   O.CustomerID,
	   O.SalesmanID,
	   O.Orderdate,
	   O.Amount
FROM Orders as O
RIGHT JOIN
Salesman as S ON O.SalesmanID = S.SalesmanID ;

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------