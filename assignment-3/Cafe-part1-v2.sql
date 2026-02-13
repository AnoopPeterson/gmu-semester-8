-- Drop tables if they already exist
DROP TABLE Sells;
DROP TABLE Likes;
DROP TABLE CoffeeDrink;
DROP TABLE Customer;
DROP TABLE Cafe;

CREATE TABLE Cafe (
    Name            VARCHAR2(50)   NOT NULL,
    City            VARCHAR2(50)   NOT NULL,
    YearEstablished NUMBER(4)
);

CREATE TABLE Customer (
    Name          VARCHAR2(50) NOT NULL,
    StreetNumber  NUMBER(5),
    StreetName    VARCHAR2(50),
    City          VARCHAR2(50)
);

CREATE TABLE CoffeeDrink (
    Name                VARCHAR2(50) NOT NULL,
    EspressoMilkRatio   VARCHAR2(10)
);

CREATE TABLE Likes (
    CName   VARCHAR2(50) NOT NULL,
    DName   VARCHAR2(50) NOT NULL
);

CREATE TABLE Sells (
    CName    VARCHAR2(50) NOT NULL,
    DName    VARCHAR2(50) NOT NULL,
    Price    NUMBER(5,2)
);

