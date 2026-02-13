--drop table tblHondaAuto;
--drop table tblHondaDealer;

-- dealer table with primary key specified
create table tblHondaDealer
(
	DealerID number Primary Key,
	DealerName varchar2(50),
	DealerState varchar2(2)
);

-- auto table with primary key not specified
-- during table creation time
create table tblHondaAuto
(
	VIN varchar2(16),
	Year number,
	Model varchar2(10),
	MTrim varchar2(10),
	Color varchar2(10),
	Price number,
	DealerID number,
	IsSold number
);

commit;

-- add primary key and foreign key
alter table tblHondaAuto add constraint HA_PK primary key (VIN);
alter table tblHondaAuto add constraint HA_FK1 foreign key (DealerID) references tblHondaDealer (DealerID) on delete cascade;

INSERT INTO tblHondaDealer (DealerID, DealerName, DealerState) VALUES (1, 'Capital Honda', 'VA');
INSERT INTO tblHondaDealer (DealerID, DealerName, DealerState) VALUES (2, 'Bayview Honda', 'MD');
INSERT INTO tblHondaDealer (DealerID, DealerName, DealerState) VALUES (3, 'Patriot Honda', 'VA');
INSERT INTO tblHondaDealer (DealerID, DealerName, DealerState) VALUES (4, 'Blue Ridge Honda', 'NC');
INSERT INTO tblHondaDealer (DealerID, DealerName, DealerState) VALUES (5, 'Seaside Honda', 'DE');
INSERT INTO tblHondaDealer (DealerID, DealerName, DealerState) VALUES (6, 'Metro Honda', 'NC');
INSERT INTO tblHondaDealer (DealerID, DealerName, DealerState) VALUES (7, 'Lakeside Honda', 'VA');
INSERT INTO tblHondaDealer (DealerID, DealerName, DealerState) VALUES (8, 'Sunrise Honda', 'FL');
INSERT INTO tblHondaDealer (DealerID, DealerName, DealerState) VALUES (9, 'Mountain Honda', 'WV');
INSERT INTO tblHondaDealer (DealerID, DealerName, DealerState) VALUES (10, 'Heritage Honda', 'NY'); 

INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('1HG2025ACC001001', 2025, 'Accord', 'EX', 'White', 28950, 1, 0);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('1HG2025ACC001002', 2025, 'Accord', 'Sport', 'Black', 30500, 2, 1);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('1HG2026ACC001003', 2026, 'Accord', 'Touring', 'Blue', 35500, 3, 0);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('2HG2025CVC001004', 2025, 'Civic', 'LX', 'Silver', 22500, 4, 0);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('2HG2026CVC001005', 2026, 'Civic', 'EX', 'Red', 24500, 5, 1);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('2HG2026CVC001006', 2026, 'Civic', 'Sport', 'Gray', 25500, 6, 0);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('3CZ2025HRV001007', 2025, 'HRV', 'LX', 'White', 25500, 7, 0);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('3CZ2025HRV001008', 2025, 'HRV', 'EX-L', 'Black', 29500, 2, 1);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('3CZ2026HRV001009', 2026, 'HRV', 'Sport', 'Blue', 27500, 9, 0);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('5J62025CRV001010', 2025, 'CRV', 'EX', 'Gray', 33500, 10, 0);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('5J62025CRV001011', 2025, 'CRV', 'LX', 'Silver', 31500, 1, 1);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('5J62026CRV001012', 2026, 'CRV', 'Touring', 'Black', 38500, 2, 0);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('1HG2026ACC001013', 2026, 'Accord', 'LX', 'Red', 27900, 3, 0);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('2HG2025CVC001014', 2025, 'Civic', 'Touring', 'Blue', 27500, 4, 1);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('3CZ2026HRV001015', 2026, 'Civic', 'EX', 'Green', 26500, 5, 1);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('5J62026CRV001016', 2026, 'CRV', 'Sport-L', 'White', 36500, 6, 0);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('1HG2025ACC001017', 2025, 'Accord', 'EX-L', 'Gray', 32500, 7, 1);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('2HG2026CVC001018', 2026, 'Civic', 'LX', 'Black', 23000, 8, 0);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('3CZ2025HRV001019', 2025, 'HRV', 'LX', 'Silver', 25900, 9, 0);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('5J62025CRV001020', 2025, 'CRV', 'EX-L', 'Red', 34900, 10, 1);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('1HG2026ACC001021', 2026, 'Accord', 'Sport-L', 'Blue', 34500, 1, 0);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('2HG2025CVC001022', 2025, 'Civic', 'EX-L', 'White', 25500, 5, 1);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('3CZ2026HRV001023', 2026, 'HRV', 'Touring', 'Black', 30500, 3, 1);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('5J62026CRV001024', 2026, 'CRV', 'LX', 'Gray', 32500, 4, 1);
INSERT INTO tblHondaAuto (VIN, Year, Model, MTrim, Color, Price, DealerID, IsSold) VALUES ('1HG2025ACC001025', 2025, 'Accord', 'LX', 'Silver', 27500, 5, 0);

commit;
