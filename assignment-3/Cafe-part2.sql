-- Drop tables if they already exist
DROP TABLE Likes;
DROP TABLE Sells;
DROP TABLE CoffeeDrink;
DROP TABLE Customer;
DROP TABLE Cafe;

CREATE TABLE Cafe (
    CafeName        VARCHAR2(50)   NOT NULL,
    City            VARCHAR2(50)   NOT NULL,
    YearEstablished NUMBER(4),
    CONSTRAINT pk_cafe PRIMARY KEY (CafeName)
);

CREATE TABLE Customer (
    CustomerName  VARCHAR2(50) NOT NULL,
    StreetNumber  NUMBER(5),
    StreetName    VARCHAR2(50),
    City          VARCHAR2(50),
    CONSTRAINT pk_customer PRIMARY KEY (CustomerName)
);

CREATE TABLE CoffeeDrink (
    DrinkName           VARCHAR2(50) NOT NULL,
    EspressoMilkRatio   VARCHAR2(10),
    CONSTRAINT pk_coffeedrink PRIMARY KEY (DrinkName)
);

CREATE TABLE Likes (
    CustomerName   VARCHAR2(50) NOT NULL,
    DrinkName      VARCHAR2(50) NOT NULL,
    CONSTRAINT pk_likes PRIMARY KEY (CustomerName, DrinkName),
    CONSTRAINT fk_likes_customer FOREIGN KEY (CustomerName) REFERENCES Customer(CustomerName),
    CONSTRAINT fk_likes_drink FOREIGN KEY (DrinkName) REFERENCES CoffeeDrink(DrinkName)
);

CREATE TABLE Sells (
    CafeName     VARCHAR2(50) NOT NULL,
    DrinkName    VARCHAR2(50) NOT NULL,
    Price        NUMBER(5,2),
    CONSTRAINT pk_sells PRIMARY KEY (CafeName, DrinkName),
    CONSTRAINT fk_sells_cafe FOREIGN KEY (CafeName) REFERENCES Cafe(CafeName),
    CONSTRAINT fk_sells_drink FOREIGN KEY (DrinkName) REFERENCES CoffeeDrink(DrinkName)
);

INSERT INTO Cafe VALUES ('Blue Heron Cafe', 'Seattle', 2008);
INSERT INTO Cafe VALUES ('Harbor Brew', 'Baltimore', 2015);
INSERT INTO Cafe VALUES ('Caffe Roma', 'San Francisco', 1998);
INSERT INTO Cafe VALUES ('Morning Tide', 'Boston', 2012);
INSERT INTO Cafe VALUES ('Bean and Barrel', 'Chicago', 2005);
INSERT INTO Cafe VALUES ('Sunrise Roasters', 'Austin', 2010);
INSERT INTO Cafe VALUES ('Fog City Coffee', 'San Francisco', 2020);
INSERT INTO Cafe VALUES ('Capital Grounds', 'Washington', 2003);

INSERT INTO Customer VALUES ('Alice Johnson', 120, 'Maple St', 'Seattle');
INSERT INTO Customer VALUES ('Brian Lee', 455, 'Harbor Ave', 'Baltimore');
INSERT INTO Customer VALUES ('Carla Mendes', 88, 'Mission St', 'San Francisco');
INSERT INTO Customer VALUES ('David Kim', 742, 'Boylston St', 'Boston');
INSERT INTO Customer VALUES ('Elena Rossi', 310, 'Lake Shore Dr', 'Chicago');
INSERT INTO Customer VALUES ('Frank Turner', 512, 'Congress Ave', 'Austin');
INSERT INTO Customer VALUES ('Grace Patel', 900, 'Market St', 'San Francisco');
INSERT INTO Customer VALUES ('Henry Adams', 44, 'Pennsylvania Ave', 'Washington');
INSERT INTO Customer VALUES ('Isabella Cruz', 77, 'Maple St', 'Seattle');
INSERT INTO Customer VALUES ('Jack Nguyen', 210, 'Harbor Ave', 'Baltimore');

INSERT INTO CoffeeDrink VALUES ('Espresso', '1:0');
INSERT INTO CoffeeDrink VALUES ('Macchiato', '2:1');
INSERT INTO CoffeeDrink VALUES ('Cortado', '1:1');
INSERT INTO CoffeeDrink VALUES ('Cappuccino', '1:2');
INSERT INTO CoffeeDrink VALUES ('Latte', '1:3');
INSERT INTO CoffeeDrink VALUES ('Flat White', '2:3');
INSERT INTO CoffeeDrink VALUES ('Mocha', '1:2');
INSERT INTO CoffeeDrink VALUES ('Americano', '1:4');

INSERT INTO Likes VALUES ('Alice Johnson', 'Latte');
INSERT INTO Likes VALUES ('Alice Johnson', 'Cappuccino');
INSERT INTO Likes VALUES ('Alice Johnson', 'Flat White');
INSERT INTO Likes VALUES ('Brian Lee', 'Espresso');
INSERT INTO Likes VALUES ('Carla Mendes', 'Flat White');
INSERT INTO Likes VALUES ('David Kim', 'Americano');
INSERT INTO Likes VALUES ('Elena Rossi', 'Mocha');
INSERT INTO Likes VALUES ('Frank Turner', 'Cortado');
INSERT INTO Likes VALUES ('Grace Patel', 'Latte');
INSERT INTO Likes VALUES ('Grace Patel', 'Cortado');
INSERT INTO Likes VALUES ('Henry Adams', 'Espresso');
INSERT INTO Likes VALUES ('Isabella Cruz', 'Cappuccino');
INSERT INTO Likes VALUES ('Jack Nguyen', 'Macchiato');

INSERT INTO Sells VALUES ('Blue Heron Cafe', 'Latte', 6.50);
INSERT INTO Sells VALUES ('Blue Heron Cafe', 'Espresso', 5.00);
INSERT INTO Sells VALUES ('Harbor Brew', 'Americano', 5.25);
INSERT INTO Sells VALUES ('Harbor Brew', 'Mocha', 6.75);
INSERT INTO Sells VALUES ('Caffe Roma', 'Cappuccino', 6.25);
INSERT INTO Sells VALUES ('Caffe Roma', 'Flat White', 6.50);
INSERT INTO Sells VALUES ('Morning Tide', 'Cortado', 5.75);
INSERT INTO Sells VALUES ('Bean and Barrel', 'Latte', 6.00);
INSERT INTO Sells VALUES ('Sunrise Roasters', 'Macchiato', 5.95);
INSERT INTO Sells VALUES ('Fog City Coffee', 'Espresso', 5.10);
INSERT INTO Sells VALUES ('Capital Grounds', 'Americano', 5.40);
INSERT INTO Sells VALUES ('Blue Heron Cafe', 'Cortado', 7.00);

commit;
