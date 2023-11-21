SHOW DATABASES;
USE scooty_dealership;

#Creating tables using SQL queries

CREATE TABLE Region(
	RegionID int NOT NULL AUTO_INCREMENT,
    RegionPinCode char(6) NOT NULL,
    RegionName char(25) NOT NULL,
    PRIMARY KEY(RegionID)
);

CREATE TABLE Brands(
BrandID INT NOT NULL AUTO_INCREMENT,
BrandName char(25) NOT NULL,
PRIMARY KEY(BrandID)
);

CREATE TABLE Dealership(
DealershipID INT NOT NULL AUTO_INCREMENT,
RegionID INT NOT NULL,
RegionPincode INT NOT NULL,
BrandID INT NOT NULL,
DealershipName VARCHAR(25),
PRIMARY KEY(DealershipID),
FOREIGN KEY(RegionID) REFERENCES Region(RegionID),
Foreign KEY(BrandID) REFERENCES Brands(BrandID)

);

CREATE TABLE Vehicle(
VehicleID INT NOT NULL AUTO_INCREMENT,
DealershipID INT NOT NULL,
BrandID INT NOT NULL,
Make VARCHAR(15) NOT NULL,
Model VARCHAR(20) NOT NULL,
price INT NOT NULL,
ModelYear CHAR(4) NOT NULL,
PRIMARY KEY(VehicleID),
FOREIGN KEY (dealershipID) REFERENCES Dealership(DealershipID),
FOREIGN KEY (BrandID) REFERENCES Brands(BrandID)

);

CREATE TABLE Manager(
ManagerID INT NOT NULL AUTO_INCREMENT,
DealershipID INT NOT NULL,
BrandID INT NOT NULL,
MFirstName varchar(25) NOT NULL,
MLastName varchar(25) NOT NULL,
Salary NUMERIC(8,2) NOT NULL,
BONUS NUMERIC(8,2),
PRIMARY KEY(ManagerID),
FOREIGN KEY(DealershipID) REFERENCES Dealership(DealershipID),
FOREIGN KEY(BrandID) REFERENCES Brands(BrandID)
);

CREATE TABLE Sales_Agent(
AgentID INT NOT NULL AUTO_INCREMENT,
ManagerID INT NOT NULL,
DealershipID INT NOT NULL,
AFirstName varchar(25) NOT NULL,
ALastName varchar(25) NOT NULL,
Salary Numeric(8,2) NOT NULL,
PRIMARY KEY(AgentID),
FOREIGN KEY(ManagerID) REFERENCES Manager(ManagerID),
FOREIGN KEY(DealershipID) REFERENCES Dealership(DealershipID)
);

CREATE TABLE Customer(
CustomerID INT NOT NULL AUTO_INCREMENT,
AgentID INT NOT NULL,
CFirstName varchar(25) NOT NULL,
CLastName varchar(25) NOT NULL,
Phone_Number char(20),
Email VARCHAR(50),
PRIMARY KEY(CustomerID),
FOREIGN KEY (AgentID) REFERENCES Sales_Agent(AgentID)

);

CREATE TABLE Insaurance(
InsauranceID INT NOT NULL AUTO_INCREMENT,
PolicyType varchar(40) NOT NULL,
RenewalDate char(30) NOT NULL,
PRIMARY KEY(InsauranceID)
);

CREATE TABLE Deal(
DealID INT NOT NULL AUTO_INCREMENT,
VehicleID INT NOT NULL,
AgentID INT NOT NULL,
CustomerID INT NOT NULL,
InsauranceID INT,
DealDate char(30) NOT NULL,
PRIMARY KEY(DealID),
FOREIGN KEY(VehicleID) REFERENCES Vehicle(VehicleID),
FOREIGN KEY(AgentID) REFERENCES Sales_Agent(AgentID),
FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID),
FOREIGN KEY(InsauranceID) REFERENCES Insaurance(InsauranceID)
);
DROP TABLE Deal;

