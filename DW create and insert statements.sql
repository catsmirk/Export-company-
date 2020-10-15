-- Drop tables if exist

DROP TABLE IF EXISTS DIM_PRODUCT;
DROP TABLE IF EXISTS DIM_DISCOUNT;
DROP TABLE IF EXISTS DIM_LOCATION;
DROP TABLE IF EXISTS DIM_EMPLOYEE;
DROP TABLE IF EXISTS DIM_SALES_LEAD;
DROP TABLE IF EXISTS DIM_CUSTOMER;
DROP TABLE IF EXISTS DIM_SUPPLIER;
DROP TABLE IF EXISTS FACT_SALES;

-------------------- Product --------------------------------

CREATE TABLE DIM_PRODUCT (
productID 			varchar(50) not null,
productName 		varchar(255) not null,
productCategory 	varchar(30) not null,
productUnit 		varchar(30) not null,
productPrice 		decimal(20, 2) not null,

CONSTRAINT ProductPk PRIMARY KEY (ProductID) );

-------------------- DISCOUNT--------------------------------

CREATE TABLE DIM_DISCOUNT(
discountID 		varchar(30) not null,
discountPercentage 	numeric not null,
discountNotes		varchar (200) not null,
CONSTRAINT discountPk PRIMARY KEY (discountID) );


-------------------- LOCATION--------------------------------

CREATE TABLE DIM_LOCATION(
locationID	varchar(30) not null,
region		varchar(50) not null,	
country	varchar(50) not null,
city		varchar(50) not null,
street		varchar(50) not null,
postalCode	varchar(50) not null,

CONSTRAINT locationID PRIMARY KEY (locationID) );

-------------------- EMPLOYEE--------------------------------

CREATE TABLE DIM_EMPLOYEE(
employeeID 		varchar(30) not null,
employeeName 	varchar(100) not null,
employeePosition 	varchar(30) not null,
hiredate 		date not null,
salary			numeric(30),

CONSTRAINT EmployeePK PRIMARY KEY (employeeID) );



-------------------- SAES LEAD --------------------------------

CREATE TABLE DIM_SALES_LEAD(
salesleadNo		integer not null,
leadName		varchar(255) not null,
leadEmail		varchar(255) not null,
leadPhone		numeric not null,
leadCompany		varchar(255) not null,
leadLocation	varchar(30) not null,	
leadRegion		varchar(50) not null,
leadCountry		varchar(50) not null,
salesleadResponse	Boolean,
salespersonID		varchar(30) not null,
salepersonName	varchar(30) not null,


CONSTRAINT salesleadPK PRIMARY KEY (salesleadNo), 
CONSTRAINT LocationFK FOREIGN KEY (leadLocation) REFERENCES DIM_LOCATION(locationID),
CONSTRAINT employeeFK FOREIGN KEY (salespersonID) REFERENCES DIM_EMPLOYEE(employeeID) );

-------------------- CUSTOMER--------------------------------

CREATE TABLE DIM_CUSTOMER(
customerID 		integer not null,
customerName 	varchar(255) not null,
customerEmail	varchar(100) not null,
customerPhone	numeric(20) not null,
customerCompany 	varchar(255) not null,
salesleadNo 		integer not null,
locationID		varchar(30),
region			varchar(50) not null,	
country	varchar(50) not null,
city		varchar(50) not null,
street		varchar(50) not null,
postalCode	varchar(50) not null,
CONSTRAINT CustomerPK PRIMARY KEY (customerID),
CONSTRAINT employeeFK FOREIGN KEY (salesleadNo) REFERENCES DIM_SALES_LEAD(salesleadNo) );

-------------------- SUPPLIER --------------------------------

CREATE TABLE DIM_SUPPLIER(
supplierID 		varchar(30) not null,
supplierName 		varchar(100) not null,
supplierLocation 	varchar(30) not null,
supplierEmail	 	varchar(100),
supplierPhone		numeric(20),			

CONSTRAINT SupplierPK PRIMARY KEY (supplierID) );

-------------------- SALES --------------------------------

CREATE TABLE FACT_SALES(
salesID 		char(11) not null,
salesQuantity		numeric (20) not null,
salesSubtotal		numeric (20) not null,
salesAfterDiscount	numeric (20) not null,
productName		varchar(30) not null,
salesUnit		varchar(50) not null,		
customerID		integer not null,		
supplierID 		varchar(30) not null,
productID		varchar(30) not null,
customerLocation	varchar(30) not null,
salesDate			date not null,
salespersonID 		varchar(30) not null,
discountID		varchar(30),
	
CONSTRAINT salesPK PRIMARY KEY (salesID,productID), 
CONSTRAINT customerFK FOREIGN KEY (customerID) REFERENCES DIM_CUSTOMER(customerID),
CONSTRAINT supplierFK FOREIGN KEY (supplierID) REFERENCES DIM_SUPPLIER(supplierID),
CONSTRAINT productFK FOREIGN KEY (productID) REFERENCES DIM_PRODUCT(productID),
CONSTRAINT locationFK FOREIGN KEY (customerLocation) REFERENCES DIM_LOCATION(locationID),
CONSTRAINT employeeFK FOREIGN KEY (salespersonID) REFERENCES DIM_EMPLOYEE(employeeID), 
CONSTRAINT discountFK FOREIGN KEY (discountID) REFERENCES DIM_discount(discountID) );

-------------------- PRODUCT--------------------------------
INSERT INTO DIM_PRODUCT 
VALUES ('GLOVE0.6', 'HDPE Gloves 0.6gr', 'Gloves', 'Box', 0.17);

INSERT INTO DIM_PRODUCT 
VALUES ('GLOVE0.9', 'HDPE Gloves 0.9gr', 'Gloves', 'Box', 0.22);

INSERT INTO DIM_PRODUCT 
VALUES ('GLOVE1.0', 'HDPE Gloves 1.0gr', 'Gloves', 'Box', 0.22);

INSERT INTO DIM_PRODUCT 
VALUES ('GLOVE1.1', 'HDPE Gloves 1.1gr', 'Gloves', 'Box', 0.23);

INSERT INTO DIM_PRODUCT 
VALUES ('TSHIRT', 'T-shirt Bag', 'Bags', 'Carton', 15.50);

INSERT INTO DIM_PRODUCT 
VALUES ('PRODUCE', 'Produce Bag', 'Bags', 'Carton', 17.00);

INSERT INTO DIM_PRODUCT 
VALUES ('GARBAGE', 'Garbage Bag', 'Bags', 'Carton', 11.00);

INSERT INTO DIM_PRODUCT 
VALUES ('ROLL', 'Bags on roll', 'Bags', 'Roll', 2.50);

-------------------- DISCOUNT--------------------------------
INSERT INTO DIM_DISCOUNT
VALUES ('LONGTERM', 20, 'For customers who have traded with the company for more than 5 years');

INSERT INTO DIM_DISCOUNT
VALUES ('LARGE1STORDER', 30, 'For customers who placed the first order of at least USD 50,000');

INSERT INTO DIM_DISCOUNT
VALUES ('MULTI', 10, 'For customers who have multiple orders in a month. Applied on 3rd order onwards');


-------------------- LOCATION--------------------------------

INSERT INTO DIM_LOCATION
VALUES ('USA1', 'North America', 'USA', 'New York', '23 Cordlant Street', '203521');

INSERT INTO DIM_LOCATION
VALUES ('SGP1', 'Asia', 'Singapore', 'Singapore', '5 Toa Payoh Lane', 'S460226');

INSERT INTO DIM_LOCATION
VALUES ('ITA1', 'Europe', 'Italy', 'Rome', '26 Via Angelo', '123678');

INSERT INTO DIM_LOCATION
VALUES ('THA1', 'Asia', 'Thailand', 'Bangkok', 'Charoen Nakhon Road', '10600');

INSERT INTO DIM_LOCATION
VALUES ('ESP1', 'Europe', 'Spain', 'Barcelona', 'Gran Via de les Corts Catalanes núm. 373-385', '18015');

INSERT INTO DIM_LOCATION
VALUES ('MYS1', 'Asia', 'Malaysia', 'Penang', '163 C & D Persiaran Gurney', '13231');

INSERT INTO DIM_LOCATION
VALUES ('UAE1', 'Asia', 'UAE', 'Abu Dhabi', 'Al Falah road', '000000');

INSERT INTO DIM_LOCATION
VALUES ('AUS1', 'Oceania', 'Australia', 'Perth', '622 Hay St', '6000');

INSERT INTO DIM_LOCATION
VALUES ('VNI1', 'Asia', 'Vietnam', 'Ha Noi', '24 Long Thanh St', '130000');

INSERT INTO DIM_LOCATION
VALUES ('VN2', 'Asia', 'Vietnam',  'Bac Ninh', '1120 Long Avenue', '170000' );

INSERT INTO DIM_LOCATION
VALUES ('VN3', 'Asia', 'Vietnam', 'Hai Phong', '53 Vo Nguyen Giap Street', '1800000');




-------------------- EMPLOYEE--------------------------------

INSERT INTO DIM_EMPLOYEE
VALUES ('CEO', 'Thomas P', 'CEO', '2020-05-01', 2000);

INSERT INTO DIM_EMPLOYEE
VALUES ('QC', 'Henry N', 'Quality Controller', '2020-05-01', 500);
INSERT INTO DIM_EMPLOYEE
VALUES ('SALES1', 'Kim N', 'Sales Manager', '2020-05-01', 1000);

INSERT INTO DIM_EMPLOYEE
VALUES ('SALES2', 'Daisy P', 'Sales Executive', '2020-06-01', 200);

INSERT INTO DIM_EMPLOYEE
VALUES ('SALES3', 'Hayley L', 'Sales Executive', '2020-06-01', 200);

-------------------- SAES LEAD --------------------------------

INSERT INTO DIM_SALES_LEAD
VALUES (1, 'Daniel Iosu', 'd.io@crad.ro', 40744178001, 'CRAD RO', 'ESP1', 'Europe', 'Spain', 'Yes', 'SALES3', 'Hayley L');

INSERT INTO DIM_SALES_LEAD
VALUES (2, 'Michell Zubairi', 'michelle@zubairi.tr', 971669920381, 'Zubairi Trading', 'UAE1', 'Asia', 'UAE', 'No', 'SALES3', 'Hayley L');

INSERT INTO DIM_SALES_LEAD
VALUES (3, 'Ayhan Kiritas', 'ay.kiritas@gmail.com', 906227870621, 'Ugrik Plastik', 'MYS1', 'Asia', 'Malaysia', 'No', 'SALES2', 'Daisy P');

INSERT INTO DIM_SALES_LEAD
VALUES (4, 'Claude Sed', 'c.sed@saniaus', 61406923126, 'Sani Import & Export', 'AUS1', 'Oceania', 'Australia', 'Yes', 'SALES1', 'Kim N');

INSERT INTO DIM_SALES_LEAD
VALUES (5, 'Ruth de la Torre', 'ruth.admin@ecohouse.net', 9714692345, 'Eco House', 'THA1', 'Asia', 'Thailand', 'Yes', 'SALES1', 'Kim N');
INSERT INTO DIM_SALES_LEAD
VALUES (6, 'Thomas Paulson', 'thomas.paulson@nest.llc', 658932167, 'Nest Packaging Ltd.','SGP1', 'Asia', 'Singapore', 'Yes', 'SALES2', 'Daisy P');

INSERT INTO DIM_SALES_LEAD
VALUES (7, 'Leo Franco', 'leo.franco@churrofaccil.net', 3926031124, 'Churro faccil', 'ITA1', 'Europe', 'Italia', 'No', 'SALES2', 'Daisy P');

INSERT INTO DIM_SALES_LEAD
VALUES (8, 'Luke Vella', 'Lvella@longbeach.net', 35640692458, 'Long Beach Resort', 'USA1', 'North America', 'The United States', 'No', 'SALES3', 'Hayley L');

-------------------- CUSTOMER--------------------------------

INSERT INTO DIM_CUSTOMER
VALUES (1, 'Thomas Paulson', 'thomas.paulson@nest.llc', 658932167, 'Nest Packaging Ltd.', 6, 'SGP1', 'Asia', 'Singapore', 'Singapore', '5 Toa Payoh Lane', 'S406206');

INSERT INTO DIM_CUSTOMER
VALUES (2, 'Ruth de la Torre', 'ruth.admin@ecohouse.net', 9714692345, 'Eco House', 5, 'THA1', 'Asia', 'Thailand', 'Bangkok', 'Charoen Nakhon Road', '10600');

INSERT INTO DIM_CUSTOMER
VALUES (3, 'Daniel Iosu', 'd.io@crad.ro', 40744178001, 'CRAD RO', 1, 'ESP1', 'Europe', 'Spain', 'Barcelona', 'Gran Via de les Corts Catalanes núm. 373-385', '18015');

INSERT INTO DIM_CUSTOMER
VALUES (4, 'Claude Sed', 'c.sed@saniaus', 61406923126, 'Sani Import & Export', 4, 'AUS1', 'Oceania', 'Australia', 'Perth', '622 Hay St', '6000');

-------------------- SUPPLIER --------------------------------

INSERT INTO DIM_SUPPLIER
VALUES (1, 'HN Plastic', 'VNI1',  'info.hnplas@gmail.com', 84248613228 );

INSERT INTO DIM_SUPPLIER
VALUES (2, 'Plastic World JSC.', 'VNI2',  'info@plasticworld.net', 843485331628 );

INSERT INTO DIM_SUPPLIER
VALUES (3, 'LC Partners', 'VNI3',  'info.lcpartners@yahoo.com', 842831136780 );

-------------------- SALES --------------------------------

INSERT INTO FACT_SALES
VALUES (1, 100000, 17000, 17000, 'HDPE Gloves 0.6gr', 'Box', 1, 1, 'GLOVE0.6', 'SGP1', '2020-06-05' , 'SALES1', NULL);

INSERT INTO FACT_SALES
VALUES (2, 100000, 22000, 15400, 'HDPE Gloves 0.9gr', 'Box', 2, 1, 'GLOVE0.9', 'THA1', '2020-06-15', 'SALES1', 'LARGE1STORDER');

INSERT INTO FACT_SALES
VALUES (2, 5000, 77500, 54250, 'T-shirt Bag', 'Carton', 2, 3, 'TSHIRT', 'THA1', '2020-06-15', 'SALES1', 'LARGE1STORDER');

INSERT INTO FACT_SALES
VALUES (3, 10000, 25000, 25000, 'Bag on roll', 'Roll', 3, 2, 'ROLL', 'ESP1', '2020-09-08', 'SALES3', null);

INSERT INTO FACT_SALES
VALUES (4, 2000, 22000, 22000, 'Garbage Bag', 'Carton', 4, 3, 'GARBAGE', 'AUS1', '2020-09-06', 'SALES2', null);
