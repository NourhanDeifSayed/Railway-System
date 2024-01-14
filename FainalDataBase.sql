-- Create database
CREATE DATABASE [newRailWay2];
GO

USE [newRailWay2];
GO
CREATE TABLE RouteInformation (
    RouteID INT IDENTITY(1,1) PRIMARY KEY,
    ArrivalStation VARCHAR(50)  ,
    DepartureStation VARCHAR(50)  ,
    Distance INTEGER  
);

CREATE TABLE Station (
    StationID INT IDENTITY(1,1) PRIMARY KEY,
    LocationStation VARCHAR(50)  ,
    StationName VARCHAR(50)  
);

CREATE TABLE Train (
    TrainID INT IDENTITY(1,1) PRIMARY KEY,
    Capacity VARCHAR(3)  
);

CREATE TABLE Staff (
    StaffID INT IDENTITY(1,1) PRIMARY KEY,
    StaffName VARCHAR(50)  ,
    StaffAddress VARCHAR(50)  ,
    StaffPhone VARCHAR(11)  ,
    StaffRole VARCHAR(30) 
);

CREATE TABLE LogIn (
	UserID INT IDENTITY(1,1) PRIMARY KEY,
    UserName VARCHAR(50),
    UserPassword VARCHAR(20)  ,
    LastLogin DATE  
);

CREATE TABLE TrainSchedule (
    ScheduleID INT IDENTITY(1,1) PRIMARY KEY,
    ArrivalTime TIME  ,
    StationID INT  ,
    DepartureTime TIME  ,
    CONSTRAINT FK_Station_TrainSchedule FOREIGN KEY (StationID) REFERENCES Station(StationID) ON DELETE CASCADE
);

CREATE TABLE Passenger (
    PassengerID INT IDENTITY(1,1) PRIMARY KEY,
    PassengerName VARCHAR(50)  ,
    PassengerPhone VARCHAR(50),
    PassengerEmail VARCHAR(50) 
);

CREATE TABLE Complaints (
    ComplaintID INT IDENTITY(1,1) PRIMARY KEY,
    ComplaintDate DATE,
    ComplaintStatus VARCHAR(10)  ,
    ComplaintDescription TEXT  ,
    PassengerID INT REFERENCES Passenger(PassengerID) ON UPDATE CASCADE
);

CREATE TABLE Payment (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    PaymentStatus VARCHAR(20)  ,
    PaymentDate DATE,
    PaymentAmount FLOAT,
    PaymentMethod TEXT,
    PassengerID INT REFERENCES Passenger(PassengerID) ON UPDATE CASCADE
);

CREATE TABLE Ticket (
    TicketID INT IDENTITY(1,1) PRIMARY KEY,
    Fare INT  ,
    SeatNumber INT  ,
    Station TEXT,
    TicketTime TIMESTAMP,
    PassengerID INT REFERENCES Passenger(PassengerID) ON UPDATE CASCADE,
    TrainID INT REFERENCES Train(TrainID) ON DELETE CASCADE
);

CREATE TABLE Booking (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    BookingDate DATE,
    PassengerID INT REFERENCES Passenger(PassengerID) ON UPDATE CASCADE,
    TrainID INT REFERENCES Train(TrainID) ON DELETE CASCADE
);

CREATE TABLE LostFound (
    ItemID INT IDENTITY(1,1) PRIMARY KEY,
    Description VARCHAR(50)  ,
    FoundDate DATE  ,
    LostLocation VARCHAR(40)  ,
    StationID INT REFERENCES Station(StationID) ON DELETE CASCADE
);

CREATE TABLE Driver (
    DriverName VARCHAR(8),
    StaffID INT REFERENCES Staff(StaffID) ON DELETE SET NULL
);

CREATE TABLE TrainDriver (
    TrainID INT REFERENCES Train(TrainID) ON DELETE CASCADE,
    DriverID INT REFERENCES Staff(StaffID) ON DELETE CASCADE
);

CREATE TABLE RelationTrainSchedule (
    TrainID INT REFERENCES Train(TrainID) ON DELETE CASCADE,
    ScheduleID INT REFERENCES TrainSchedule(ScheduleID) ON DELETE CASCADE
);

CREATE TABLE RouteTrainStation (
    RouteID INT REFERENCES RouteInformation(RouteID) ON DELETE CASCADE,
    TrainID INT REFERENCES Train(TrainID) ON DELETE CASCADE,
    StationID INT REFERENCES Station(StationID) ON DELETE CASCADE
);

CREATE TABLE TrainTicket (
    TrainID INT REFERENCES Train(TrainID) ON DELETE CASCADE,
    TicketID INT REFERENCES Ticket(TicketID) ON DELETE NO ACTION
);

CREATE TABLE UserStaff (
    StaffID INT REFERENCES Staff(StaffID) ON DELETE CASCADE,
    UserId INT   REFERENCES LogIn(UserId) ON DELETE CASCADE
);


drop table LogIn
drop table UserStaff

-- Updating data in tables
UPDATE Complaints
SET PassengerID = '13'
WHERE PassengerID = '1';

UPDATE Payment
SET PassengerID = '18'
WHERE PassengerID = '5';

UPDATE Ticket
SET PassengerID = '20'
WHERE PassengerID = '8';



ALTER TABLE RouteTrainStation
ADD CONSTRAINT FK__RouteTrai__Train__60A75C0F FOREIGN KEY (TrainID) REFERENCES Train(TrainID) ON DELETE CASCADE;

ALTER TABLE RouteTrainStation
ALTER COLUMN TrainID VARCHAR(20) NOT NULL;

-- Recreate the primary key constraint
ALTER TABLE RouteTrainStation
ADD CONSTRAINT PK_RouteTrainStation PRIMARY KEY (RouteID, TrainID, StationID);
-- Drop the existing foreign key constraint
ALTER TABLE RelationTrainSchedule
DROP CONSTRAINT FK__RelationTrainSchedule__Train;




ALTER TABLE Ticket
ADD Ticket_Type varchar(50) ;


ALTER TABLE RouteInformation
ALTER COLUMN Distance INTEGER NULL;


ALTER TABLE Ticket
ALTER COLUMN Fare INT NULL;


ALTER TABLE Ticket
ALTER COLUMN SeatNumber INT NULL;










 -- Insert 30 rows of fake data into the Passenger table with Egyptian names including women starting from 001
 
    --Done
INSERT INTO Passenger (PassengerName, PassengerPhone, PassengerEmail)
VALUES
('Ahmed Abdel Nasser', '0123456789', 'ahmed.nasser@example.com'),
('Mohamed Ali', '0123456789', 'mohamed.ali@example.com'),
('Fatma Ahmed', '0123456789', 'fatma.ahmed@example.com'),
('Ali Mahmoud', '0123456789', 'ali.mahmoud@example.com'),
('Hassan Ibrahim', '0123456789', 'hassan.ibrahim@example.com'),
('Noura Mohamed', '0123456789', 'noura.mohamed@example.com'),
('Amr Salah', '0123456789', 'amr.salah@example.com'),
('Youssef Ahmed', '0123456789', 'youssef.ahmed@example.com'),
('Mariam Hassan', '0123456789', 'mariam.hassan@example.com'),
('Rania Ali', '0123456789', 'rania.ali@example.com'),
('Khaled Mohamed', '0123456789', 'khaled.mohamed@example.com'),
('Hoda Gamal', '0123456789', 'hoda.gamal@example.com'),
('Omar Mahmoud', '0123456789', 'omar.mahmoud@example.com'),
('Samir Ahmed', '0123456789', 'samir.ahmed@example.com'),
('Nadia Salah', '0123456789', 'nadia.salah@example.com'),
('Sara Mohamed', '0123456789', 'sara.mohamed@example.com'),
('Mohsen Ibrahim', '0123456789', 'mohsen.ibrahim@example.com'),
('Aya Ahmed', '0123456789', 'aya.ahmed@example.com'),
('Mahmoud Hassan', '0123456789', 'mahmoud.hassan@example.com'),
('Hosni Ali', '0123456789', 'hosni.ali@example.com'),
('Mona Omar', '0123456789', 'mona.omar@example.com'),
('Samer Salah', '0123456789', 'samer.salah@example.com'),
('Noha Mohamed', '0123456789', 'noha.mohamed@example.com'),
('Tarek Ahmed', '0123456789', 'tarek.ahmed@example.com'),
('Hesham Hassan', '0123456789', 'hesham.hassan@example.com'),
('Nadine Ali', '0123456789', 'nadine.ali@example.com'),
('Karim Mahmoud', '0123456789', 'karim.mahmoud@example.com'),
('Hani Ahmed', '0123456789', 'hani.ahmed@example.com'),
('Yara Hassan', '0123456789', 'yara.hassan@example.com'),
('Osama Ali', '0123456789', 'osama.ali@example.com');

INSERT INTO Passenger (PassengerName, PassengerPhone, PassengerEmail)
VALUES
('Mohamed Abdel Nasser', '01236056789', 'mohamed.nasser@example.com');



-- Insert 30 rows of fake data into the Station table for Egypt Railways

INSERT INTO Station (LocationStation, StationName)
VALUES
('Cairo', 'Cairo Central Station'),
('Alexandria', 'Alexandria Station'),
('Luxor', 'Luxor Junction'),
('Aswan', 'Aswan Terminal'),
('Hurghada', 'Hurghada Rail Hub'),
('Sharm El Sheikh', 'Sharm El Sheikh Station'),
('Damietta', 'Damietta Depot'),
('Port Said', 'Port Said Rail Center'),
('Ismailia', 'Ismailia Junction'),
('Suez', 'Suez Rail Station'),
('Minya', 'Minya Transit Hub'),
('Qena', 'Qena Railway Point'),
('Benha', 'Benha Rail Yard'),
('Tanta', 'Tanta Terminal'),
('Assiut', 'Assiut Rail Terminal'),
('Fayoum', 'Fayoum Rail Junction'),
('Damanhur', 'Damanhur Rail Center'),
('Sohag', 'Sohag Station'),
('Banha', 'Banha Rail Yard'),
('Damanhour', 'Damanhour Rail Depot'),
('Rashid', 'Rashid Rail Station'),
('Zagazig', 'Zagazig Rail Hub'),
('Mallawi', 'Mallawi Rail Point'),
('Bani Mazar', 'Bani Mazar Transit Center'),
('Matay', 'Matay Rail Terminal'),
('Luxor Airport', 'Luxor Airport Rail Station'),
('Sharm El Sheikh Airport', 'Sharm El Sheikh Airport Rail Terminal'),
('Alexandria Airport', 'Alexandria Airport Rail Hub'),
('Cairo Airport', 'Cairo Airport Rail Station');







	-- Insert 30 rows of fake data into the Staff table
INSERT INTO Staff (StaffName, StaffAddress, StaffPhone, StaffRole)
VALUES
    ('Mohamed Abdelrahman', '123 Main St', '01012345678', 'Conductor'),
    ('Fatima Ahmed', '456 Oak St', '01123456789', 'Ticket Checker'),
    ('Ahmed Mahmoud', '789 Pine St', '01234567890', 'Train Driver'),
    ('Nadia Ali', '101 Cedar St', '01345678901', 'Ticket Seller'),
    ('Amr Hussein', '202 Maple St', '01456789012', 'Train Driver'),
    ('Dina Mohamed', '303 Birch St', '01567890123', 'Conductor'),
    ('Hassan Ibrahim', '404 Elm St', '01678901234', 'Ticket Checker'),
    ('Amina Salah', '505 Walnut St', '01789012345', 'Ticket Seller'),
    ('Khaled Samir', '606 Pine St', '01890123456', 'Train Driver'),
    ('Laila Abdelaziz', '707 Oak St', '01901234567', 'Conductor'),
    ('Youssef Hossam', '808 Birch St', '02012345678', 'Ticket Checker'),
    ('Sarah Ahmed', '909 Walnut St', '02123456789', 'Ticket Seller'),
    ('Tarek Abdelmeguid', '1010 Cedar St', '02234567890', 'Train Driver'),
    ('Nourhan Hany', '1111 Maple St', '02345678901', 'Conductor'),
    ('Gamal Farouk', '1212 Pine St', '02456789012', 'Ticket Checker'),
    ('Mona Salah', '1313 Oak St', '02567890123', 'Ticket Seller'),
    ('Adel Mohamed', '1414 Elm St', '02678901234', 'Train Driver'),
    ('Sara Ali', '1515 Walnut St', '02789012345', 'Conductor'),
    ('Karim Hossam', '1616 Pine St', '02890123456', 'Ticket Checker'),
    ('Lina Abdelrahman', '1717 Birch St', '02901234567', 'Ticket Seller'),
    ('Omar Salah', '1818 Oak St', '03012345678', 'Train Driver'),
    ('Rana Hussein', '1919 Cedar St', '03123456789', 'Conductor'),
    ('Moustafa Ibrahim', '2020 Elm St', '03234567890', 'Ticket Checker'),
    ('Salma Ali', '2121 Walnut St', '03345678901', 'Ticket Seller'),
    ('Hazem Samir', '2222 Pine St', '03456789012', 'Train Driver'),
    ('Nada Abdelaziz', '2323 Oak St', '03567890123', 'Conductor'),
    ('Tamer Hossam', '2424 Birch St', '03678901234', 'Ticket Checker'),
    ('Hala Farouk', '2525 Walnut St', '03789012345', 'Ticket Seller'),
    ('Mina Salah', '2626 Pine St', '03890123456', 'Train Driver'),
    ('Riham Ahmed', '2727 Elm St', '03901234567', 'Conductor');






	-- Insert 30 rows of fake data into the LostFound table
INSERT INTO LostFound (Description, FoundDate, LostLocation)
VALUES
    ('Wallet', '2023-12-15', 'Cairo Central Station'),
    ('Mobile Phone', '2023-12-16', 'Alexandria Station'),
    ('Laptop', '2023-12-17', 'Luxor Junction'),
    ('Keys', '2023-12-18', 'Aswan Terminal'),
    ('Sunglasses', '2023-12-19', 'Hurghada Rail Hub'),
    ('Umbrella', '2023-12-20', 'Sharm El Sheikh Station'),
    ('Headphones', '2023-12-21', 'Damietta Depot'),
    ('Backpack', '2023-12-22', 'Port Said Rail Center'),
    ('Watch', '2023-12-23', 'Ismailia Junction'),
    ('Gloves', '2023-12-24', 'Suez Rail Station'),
    ('Book', '2023-12-25', 'Minya Transit Hub'),
    ('Water Bottle', '2023-12-26', 'Qena Railway Point'),
    ('Hat', '2023-12-27', 'Benha Rail Yard'),
    ('Camera', '2023-12-28', 'Tanta Terminal'),
    ('Jacket', '2023-12-29', 'Assiut Rail Terminal'),
    ('Notebook', '2023-12-30', 'Fayoum Rail Junction'),
    ('Charger', '2023-12-31', 'Damanhur Rail Center'),
    ('Scarf', '2024-01-01', 'Sohag Station'),
    ('Glasses Case', '2024-01-02', 'Banha Rail Yard'),
    ('Power Bank', '2024-01-03', 'Damanhour Rail Depot'),
    ('Lunch Box', '2024-01-04', 'Rashid Rail Station'),
    ('Sunscreen', '2024-01-05', 'Zagazig Rail Hub'),
    ('Wallet', '2024-01-06', 'Mallawi Rail Point'),
    ('Sweater', '2024-01-07', 'Bani Mazar Transit Center'),
    ('Earphones', '2024-01-08', 'Matay Rail Terminal'),
    ('Hat', '2024-01-09', 'Luxor Airport Rail Station'),
    ('Pen', '2024-01-10', 'Sharm El Sheikh Airport Rail Terminal'),
    ('Hand Sanitizer', '2024-01-11', 'Alexandria Airport Rail Hub'),
    ('Snack', '2024-01-12', 'Cairo Airport Rail Station'),
    ('Notebook', '2024-01-13', 'Cairo Central Station');










	-- Insert 30 rows of fake data into the LogIn table
INSERT INTO LogIn (UserName, UserPassword, LastLogin)
VALUES
    ('user001', 'password001', '2023-12-15'),
    ('user002', 'password002', '2023-12-16'),
    ('user003', 'password003', '2023-12-17'),
    -- Continue adding rows
    ('user004', 'password004', '2023-12-18'),
    ('user005', 'password005', '2023-12-19'),
    ('user006', 'password006', '2023-12-20'),
    -- Continue adding rows
    ('user007', 'password007', '2023-12-21'),
    ('user008', 'password008', '2023-12-22'),
    ('user009', 'password009', '2023-12-23'),
    -- Continue adding rows
    ('user010', 'password010', '2023-12-24'),
    ('user011', 'password011', '2023-12-25'),
    ('user012', 'password012', '2023-12-26'),
    -- Continue adding rows
    ('user013', 'password013', '2023-12-27'),
    ('user014', 'password014', '2023-12-28'),
    ('user015', 'password015', '2023-12-29'),
    -- Continue adding rows
    ('user016', 'password016', '2023-12-30'),
    ('user017', 'password017', '2023-12-31'),
    ('user018', 'password018', '2024-01-01'),
    -- Continue adding rows
    ('user019', 'password019', '2024-01-02'),
    ('user020', 'password020', '2024-01-03'),
    ('user021', 'password021', '2024-01-04'),
    -- Continue adding rows
    ('user022', 'password022', '2024-01-05'),
    ('user023', 'password023', '2024-01-06'),
    ('user024', 'password024', '2024-01-07'),
    -- Continue adding rows
    ('user025', 'password025', '2024-01-08'),
    ('user026', 'password026', '2024-01-09'),
    ('user027', 'password027', '2024-01-10'),
    -- Continue adding rows
    ('user028', 'password028', '2024-01-11'),
    ('user029', 'password029', '2024-01-12'),
    ('user030', 'password030', '2024-01-13');






-- Insert 30 rows into the Train table
INSERT INTO Train (Capacity)
VALUES
    ('100'),
    ('150'),
    ('120'),
    ('200'),
    ('180'),
    ('130'),
    ('170'),
    ('160'),
    ('190'),
    ('140'),
    ('110'),
    ('170'),
    ('130'),
    ('150'),
    ('180'),
    ('120'),
    ('200'),
    ('160'),
    ('140'),
    ('190'),
    ('110'),
    ('100'),
    ('150'),
    ('120'),
    ('170'),
    ('160'),
    ('130'),
    ('190'),
    ('140'),
    ('180');




-- Insert 30 rows into the RouteTrainStation table
INSERT INTO RouteTrainStation (RouteID, TrainID, StationID)
VALUES
    (1, 1, 1),
    (2, 2, 2),
    (3, 3, 3),
    (4, 4, 4),
    (5, 5, 5),
    (6, 6, 6),
    (7, 7, 7),
    (8, 8, 8),
    (9, 9, 9),
    (10, 10, 10),
    (11, 11, 11),
    (12, 12, 12),
    (13, 13, 13),
    (14, 14, 14),
    (15, 15, 15),
    (16, 16, 16),
    (17, 17, 17),
    (18, 18, 18),
    (19, 19, 19),
    (20, 20, 20),
    (21, 21, 21),
    (22, 22, 22),
    (23, 23, 23),
    (24, 24, 24),
    (25, 25, 25),
    (26, 26, 26),
    (27, 27, 27),
    (28, 28, 28),
    (29, 29, 29);
    

 

 select * from Staff

 -- Create the table
CREATE TABLE EgyptianStationInsights (
    StationName NVARCHAR(100),
    TotalRevenue DECIMAL(18, 2),
    TotalSoldTickets INT,
    TotalExpenses DECIMAL(18, 2)
);

-- Insert 30 rows of hard-coded data into the table
INSERT INTO EgyptianStationInsights (StationName, TotalRevenue, TotalSoldTickets, TotalExpenses)
VALUES
    ('Cairo Station', 15000.50, 500, 7500.75),
    ('Alexandria Station', 12000.75, 400, 6000.25),
    ('Luxor Station', 8000.25, 300, 4000.50),
    -- Add more rows as needed...
    ('Aswan Station', 6000.00, 200, 3000.00),
    ('Port Said Station', 9500.25, 350, 4750.00),
    ('Sharm El Sheikh Station', 7200.75, 250, 3600.25),
    ('Hurghada Station', 8800.50, 300, 4400.25),
    -- Add more rows to reach 30...
    ('Mansoura Station', 5400.00, 180, 2700.00),
    ('Tanta Station', 7100.25, 240, 3550.50),
    ('Suez Station', 6800.75, 220, 3400.25),
    ('Cairo Station', 8900.00, 310, 4450.00),
    -- Add more rows to reach 30...
    ('Zagazig Station', 7700.25, 260, 3850.50),
    ('Ismailia Station', 6200.75, 210, 3100.25),
    ('Faiyum Station', 8300.50, 280, 4150.25),
    ('Cairo Station', 7200.00, 240, 3600.00),
    -- Add more rows to reach 30...
    ('Banha Station', 5800.25, 190, 2900.50),
    ('Sohag Station', 7900.75, 270, 3950.25),
    ('Qena Station', 6500.25, 220, 3250.50),
    ('Al Minya Station', 8400.00, 300, 4200.00),
    -- Add more rows to reach 30...
    ('Assiut Station', 7000.25, 240, 3500.50),
    ('Damanhur Station', 8100.75, 270, 4050.25),
    ('Alexandria Station', 6700.50, 230, 3350.25),
    ('Asyut Station', 8600.00, 290, 4300.00),
    -- Add more rows to reach 30...
    ('Port Fuad Station', 5900.25, 200, 2950.50),
    ('Mallawi Station', 7500.75, 260, 3750.25),
    ('Damietta Station', 6400.25, 220, 3200.50),
    ('Ras Gharib Station', 8700.00, 300, 4350.00);
	select * from StationManager

	CREATE TABLE StationManager (
    id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) ,
	
    password VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    role VARCHAR(50),
	name VARCHAR(50)
);
 
 CREATE TABLE Booking (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    BookingDate DATE,
    PassengerID INT REFERENCES Passenger(PassengerID) ON UPDATE CASCADE,
    TrainID INT REFERENCES Train(TrainID) ON DELETE CASCADE,
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    Email VARCHAR(255),
    PhoneNumber VARCHAR(20),
    DepartureCity VARCHAR(100),
    ArrivalCity VARCHAR(100),
    TicketType VARCHAR(50)
);
INSERT INTO Booking (BookingDate, PassengerID, TrainID, firstName, lastName, Email, PhoneNumber, DepartureCity, ArrivalCity, TicketType)
VALUES
    ('2024-01-05', 1, 1, 'John', 'Doe', 'john.doe@email.com', '1234567890', 'CityA', 'CityB', 'Standard'),
    ('2024-01-06', 2, 2, 'Jane', 'Smith', 'jane.smith@email.com', '9876543210', 'CityC', 'CityD', 'Premium'),
    ('2024-01-07', 3, 3, 'Alice', 'Johnson', 'alice.johnson@email.com', '5551112222', 'CityX', 'CityY', 'Deluxe'),
    ('2024-01-08', 4, 4, 'Bob', 'Brown', 'bob.brown@email.com', '3334445555', 'CityP', 'CityQ', 'Standard'),
    ('2024-01-09', 5, 5, 'Eva', 'Miller', 'eva.miller@email.com', '7778889999', 'CityM', 'CityN', 'Premium'),
    ('2024-01-10', 6, 6, 'Charlie', 'Williams', 'charlie.williams@email.com', '1112223333', 'CityR', 'CityS', 'Deluxe'),
    ('2024-01-11', 7, 7, 'Grace', 'Wilson', 'grace.wilson@email.com', '9998887777', 'CityT', 'CityU', 'Standard'),
    ('2024-01-12', 8, 8, 'Sam', 'Moore', 'sam.moore@email.com', '4445556666', 'CityZ', 'CityW', 'Premium'),
    ('2024-01-13', 9, 9, 'Sophia', 'Clark', 'sophia.clark@email.com', '6667778888', 'CityG', 'CityH', 'Deluxe'),
    ('2024-01-14', 10, 10, 'Oliver', 'Jones', 'oliver.jones@email.com', '2223334444', 'CityK', 'CityL', 'Standard'),
    ('2024-01-15', 11, 11, 'Emma', 'Anderson', 'emma.anderson@email.com', '8889990000', 'CityD', 'CityC', 'Premium'),
    ('2024-01-16', 12, 12, 'Liam', 'White', 'liam.white@email.com', '1112223333', 'CityX', 'CityY', 'Deluxe'),
    ('2024-01-17', 13, 13, 'Ava', 'Martin', 'ava.martin@email.com', '7778889999', 'CityM', 'CityN', 'Standard'),
    ('2024-01-18', 14, 14, 'Noah', 'Taylor', 'noah.taylor@email.com', '3334445555', 'CityP', 'CityQ', 'Premium'),
    ('2024-01-19', 15, 15, 'Mia', 'Brown', 'mia.brown@email.com', '9998887777', 'CityR', 'CityS', 'Deluxe'),
    ('2024-01-20', 16, 16, 'Jackson', 'Smith', 'jackson.smith@email.com', '5551112222', 'CityT', 'CityU', 'Standard'),
    ('2024-01-21', 17, 17, 'Sophie', 'Moore', 'sophie.moore@email.com', '4445556666', 'CityZ', 'CityW', 'Premium'),
    ('2024-01-22', 18, 18, 'Lucas', 'Wilson', 'lucas.wilson@email.com', '6667778888', 'CityG', 'CityH', 'Deluxe'),
    ('2024-01-23', 19, 19, 'Aria', 'Jones', 'aria.jones@email.com', '8889990000', 'CityK', 'CityL', 'Standard'),
    ('2024-01-24', 20, 20, 'Liam', 'Anderson', 'liam.anderson@email.com', '2223334444', 'CityD', 'CityC', 'Premium'),
    ('2024-01-25', 21, 21, 'Olivia', 'White', 'olivia.white@email.com', '1112223333', 'CityX', 'CityY', 'Deluxe'),
    ('2024-01-26', 22, 22, 'Ethan', 'Martin', 'ethan.martin@email.com', '7778889999', 'CityM', 'CityN', 'Standard'),
    ('2024-01-27', 23, 23, 'Emma', 'Taylor', 'emma.taylor@email.com', '3334445555', 'CityP', 'CityQ', 'Premium'),
    ('2024-01-28', 24, 24, 'Noah', 'Brown', 'noah.brown@email.com', '9998887777', 'CityR', 'CityS', 'Deluxe'),
    ('2024-01-29', 25, 25, 'Mia', 'Smith', 'mia.smith@email.com', '5551112222', 'CityT', 'CityU', 'Standard'),
    ('2024-01-30', 26, 26, 'Jackson', 'Moore', 'jackson.moore@email.com', '4445556666', 'CityZ', 'CityW', 'Premium');
	SELECT  *  FROM Booking
INSERT INTO StationManager (username, password, email, phone, role, name)
VALUES 
    ('maneger_1', 'maneger_1', 'john@example.com', '123456789', 'manager', 'Hassan Youssef'),
    ('maneger_2', 'maneger2', 'jane@example.com', '987654321', 'admin', 'Adel Emam'),
    ('maneger_3', 'maneger_2', 'bob@example.com', '555555555', 'supervisor', 'Tawfik-Eldiken');
 
	-- Insert 30 rows of fake data into the Booking table with Passenger IDs matching Passenger table
INSERT INTO Booking (BookingDate, PassengerID, TrainID)
VALUES
    ('2023-12-01', 1, 1),
    ('2023-12-02', 2, 2),
    ('2023-12-03', 3, 3),
    ('2023-12-04', 4, 4),
    ('2023-12-05', 5, 5),
    ('2023-12-06', 6, 6),
    ('2023-12-07', 7, 7),
    ('2023-12-08', 8, 8),
    ('2023-12-09', 9, 9),
    ('2023-12-10', 10, 10),
    ('2023-12-11', 11, 11),
    ('2023-12-12', 12, 12),
    ('2023-12-13', 13, 13),
    ('2023-12-14', 14, 14),
    ('2023-12-15', 15, 15),
    ('2023-12-16', 16, 16),
    ('2023-12-17', 17, 17),
    ('2023-12-18', 18, 18),
    ('2023-12-19', 19, 19),
    ('2023-12-20', 20, 20),
    ('2023-12-21', 21, 21),
    ('2023-12-22', 22, 22),
    ('2023-12-23', 23, 23),
    ('2023-12-24', 24, 24),
    ('2023-12-25', 25, 25),
    ('2023-12-26', 26, 26),
    ('2023-12-27', 27, 27),
    ('2023-12-28', 28, 28),
    ('2023-12-29', 29, 29) ;




INSERT INTO Driver (DriverName, StaffID)
VALUES
    ('Driver1', 'S001'),
    ('Driver2', 'S002'),
    ('Driver3', 'S003'),
    ('Driver4', 'S004'),
    ('Driver5', 'S005'),
    ('Driver6', 'S006'),
    ('Driver7', 'S007'),
    ('Driver8', 'S008'),
    ('Driver9', 'S009'),
    ('Driver10', 'S010'),
    ('Driver11', 'S011'),
    ('Driver12', 'S012'),
    ('Driver13', 'S013'),
    ('Driver14', 'S014'),
    ('Driver15', 'S015'),
    ('Driver16', 'S016'),
    ('Driver17', 'S017'),
    ('Driver18', 'S018'),
    ('Driver19', 'S019'),
    ('Driver20', 'S020'),
    ('Driver21', 'S021'),
    ('Driver22', 'S022'),
    ('Driver23', 'S023'),
    ('Driver24', 'S024'),
    ('Driver25', 'S025'),
    ('Driver26', 'S026'),
    ('Driver27', 'S027'),
    ('Driver28', 'S028'),
    ('Driver29', 'S029'),
    ('Driver30', 'S030');


-- Insert 15 rows of fake data into the TrainDriver table
INSERT INTO TrainDriver (TrainID, DriverID)
VALUES
    ('T001', 'S001'),
    ('T002', 'S002'),
    ('T003', 'S003'),
    ('T004', 'S004'),
    ('T005', 'S005'),
    ('T006', 'S006'),
    ('T007', 'S007'),
    ('T008', 'S008'),
    ('T009', 'S009'),
    ('T010', 'S010'),
    ('T011', 'S011'),
    ('T012', 'S012'),
    ('T013', 'S013'),
    ('T014', 'S014'),
    ('T015', 'S015'),
    ('T016', 'S016'),
    ('T017', 'S017'),
    ('T018', 'S018'),
    ('T019', 'S019'),
    ('T020', 'S020'),
    ('T021', 'S021'),
    ('T022', 'S022'),
    ('T023', 'S023'),
    ('T024', 'S024'),
    ('T025', 'S025'),
    ('T026', 'S026'),
    ('T027', 'S027'),
    ('T028', 'S028'),
    ('T029', 'S029'),
    ('T030', 'S030');



	-- Insert 30 rows of fake data into the Ticket table with matching Station names
-- Insert 30 rows of fake data into the Ticket table with formatted random dates
INSERT INTO Ticket (Fare, SeatNumber, Station, PassengerID, TrainID)
VALUES
    (50, 10, 'Cairo Central Station', 1, 1),
    (60, 15, 'Alexandria Station', 2, 2),
    (40, 20, 'Luxor Junction', 3, 3),
    (55, 8, 'Aswan Terminal', 4, 4),
    (70, 12, 'Hurghada Rail Hub', 5, 5),
    (45, 18, 'Sharm El Sheikh Station', 6, 6),
    (65, 9, 'Damietta Depot', 7, 7),
    (75, 14, 'Port Said Rail Center', 8, 8),
    (55, 22, 'Ismailia Junction', 9, 9),
    (60, 11, 'Suez Rail Station', 10, 10),
    (40, 16, 'Minya Transit Hub', 11, 11),
    (70, 21, 'Qena Railway Point', 12, 12),
    (45, 7, 'Benha Rail Yard', 13, 13),
    (55, 13, 'Luxor Junction', 14, 14),
    (65, 19, 'Aswan Terminal', 15, 15),
    (80, 10, 'Hurghada Rail Hub', 16, 16),
    (50, 15, 'Sharm El Sheikh Station', 17, 17),
    (60, 21, 'Damietta Depot', 18, 18),
    (70, 12, 'Port Said Rail Center', 19, 19),
    (45, 17, 'Ismailia Junction', 20, 20),
    (75, 23, 'Suez Rail Station', 21, 21),
    (50, 14, 'Minya Transit Hub', 22, 22),
    (65, 20, 'Qena Railway Point', 23, 23),
    (85, 8, 'Benha Rail Yard', 24, 24),
    (55, 11, 'Cairo Central Station', 25, 25),
    (60, 16, 'Alexandria Station', 26, 26),
    (40, 22, 'Luxor Junction', 27, 27),
    (55, 9, 'Aswan Terminal', 28, 28),
    (70, 13, 'Hurghada Rail Hub', 29, 29);






-- Insert 30 rows of fake data into the Payment table
INSERT INTO Payment (PaymentStatus, PaymentDate, PaymentAmount, PaymentMethod, PassengerID)
VALUES
    ('Paid', '2023-12-15', 50.0, 'Credit Card', 1),
    ('Paid', '2023-12-16', 60.0, 'Debit Card', 2),
    ('Pending', '2023-12-17', 40.0, 'Cash', 3),
    ('Paid', '2023-12-18', 55.0, 'Credit Card', 4),
    ('Pending', '2023-12-19', 70.0, 'Debit Card', 5),
    ('Paid', '2023-12-20', 45.0, 'Cash', 6),
    ('Pending', '2023-12-21', 65.0, 'Credit Card', 7),
    ('Paid', '2023-12-22', 75.0, 'Debit Card', 8),
    ('Paid', '2023-12-23', 55.0, 'Cash', 9),
    ('Paid', '2023-12-24', 60.0, 'Credit Card', 10),
    ('Pending', '2023-12-25', 40.0, 'Debit Card', 11),
    ('Paid', '2023-12-26', 70.0, 'Cash', 12),
    ('Paid', '2023-12-27', 45.0, 'Credit Card', 13),
    ('Pending', '2023-12-28', 65.0, 'Debit Card', 14),
    ('Paid', '2023-12-29', 55.0, 'Cash', 15),
    ('Pending', '2023-12-30', 50.0, 'Credit Card', 16),
    ('Paid', '2023-12-31', 80.0, 'Debit Card', 17),
    ('Paid', '2024-01-01', 55.0, 'Cash', 18),
    ('Paid', '2024-01-02', 65.0, 'Credit Card', 19),
    ('Pending', '2024-01-03', 70.0, 'Debit Card', 20),
    ('Paid', '2024-01-04', 45.0, 'Cash', 21),
    ('Pending', '2024-01-05', 75.0, 'Credit Card', 22),
    ('Paid', '2024-01-06', 60.0, 'Debit Card', 23),
    ('Paid', '2024-01-07', 40.0, 'Cash', 24),
    ('Paid', '2024-01-08', 55.0, 'Credit Card', 25),
    ('Pending', '2024-01-09', 70.0, 'Debit Card', 26),
    ('Paid', '2024-01-10', 45.0, 'Cash', 27),
    ('Pending', '2024-01-11', 65.0, 'Credit Card', 28),
    ('Paid', '2024-01-12', 50.0, 'Debit Card', 29),
    ('Paid', '2024-01-13', 75.0, 'Cash', 30);

DELETE FROM Payment
WHERE PaymentId=33;

INSERT INTO Payment (PaymentStatus, PaymentDate, PaymentAmount, PaymentMethod )
VALUES
    ('Paid', '2023-12-15', 50.0, 'Credit Card');

	-- Insert 3 rows of data into the RouteInformation table
INSERT INTO RouteInformation (ArrivalStation, DepartureStation, Distance)
VALUES
    ('Cairo Central Station', 'Alexandria Station', 100),
    ('Luxor Junction', 'Aswan Terminal', 150),
    ('Hurghada Rail Hub', 'Sharm El Sheikh Station', 200),
    ('Damietta Depot', 'Port Said Rail Center', 120),
    ('Ismailia Junction', 'Suez Rail Station', 180),
    ('Minya Transit Hub', 'Qena Railway Point', 220),
    ('Benha Rail Yard', 'Tanta Terminal', 90),
    ('Assiut Rail Terminal', 'Fayoum Rail Junction', 130),
    ('Damanhur Rail Center', 'Sohag Station', 170),
    ('Banha Rail Yard', 'Damanhour Rail Depot', 200),
    ('Rashid Rail Station', 'Zagazig Rail Hub', 110),
    ('Mallawi Rail Point', 'Bani Mazar Transit Center', 160),
    ('Matay Rail Terminal', 'Luxor Airport Rail Station', 140),
    ('Sharm El Sheikh Airport Rail Terminal', 'Alexandria Airport Rail Hub', 190),
    ('Cairo Airport Rail Station', 'Cairo Central Station', 210),
    ('StationA', 'StationB', 100),
    ('StationC', 'StationD', 150),
    ('StationE', 'StationF', 200),
    ('StationG', 'StationH', 120),
    ('StationI', 'StationJ', 180),
    ('StationK', 'StationL', 220),
    ('StationM', 'StationN', 90),
    ('StationO', 'StationP', 130),
    ('StationQ', 'StationR', 170),
    ('StationS', 'StationT', 200),
    ('StationU', 'StationV', 110),
    ('StationW', 'StationX', 160),
    ('StationY', 'StationZ', 140),
    ('StationAA', 'StationBB', 190);
 





	-- Insert 30 rows into the TrainSchedule table
INSERT INTO TrainSchedule (ArrivalTime, StationID, DepartureTime)
VALUES
    ('08:00:00', 1, '08:30:00'),
    ('09:00:00', 2, '09:30:00'),
    ('10:00:00', 3, '10:30:00'),
    ('11:00:00', 4, '11:30:00'),
    ('12:00:00', 5, '12:30:00'),
    ('13:00:00', 6, '13:30:00'),
    ('14:00:00', 7, '14:30:00'),
    ('15:00:00', 8, '15:30:00'),
    ('16:00:00', 9, '16:30:00'),
    ('17:00:00', 10, '17:30:00'),
    ('18:00:00', 11, '18:30:00'),
    ('19:00:00', 12, '19:30:00'),
    ('20:00:00', 13, '20:30:00'),
    ('21:00:00', 14, '21:30:00'),
    ('22:00:00', 15, '22:30:00'),
    ('23:00:00', 16, '23:30:00'),
    ('00:00:00', 17, '00:30:00'),
    ('01:00:00', 18, '01:30:00'),
    ('02:00:00', 19, '02:30:00'),
    ('03:00:00', 20, '03:30:00'),
    ('08:30:00', 21, '09:00:00'),
    ('09:30:00', 22, '10:00:00'),
    ('10:30:00', 23, '11:00:00'),
    ('11:30:00', 24, '12:00:00'),
    ('12:30:00', 25, '13:00:00'),
    ('13:30:00', 26, '14:00:00'),
    ('14:30:00', 27, '15:00:00'),
    ('15:30:00', 28, '16:00:00'),
    ('16:30:00', 29, '17:00:00');
 


 


-- Insert 30 rows into the RelationTrainSchedule table
INSERT INTO RelationTrainSchedule (TrainID, ScheduleID)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (6, 6),
    (7, 7),
    (8, 8),
    (9, 9),
    (10, 10),
    (11, 11),
    (12, 12),
    (13, 13),
    (14, 14),
    (15, 15),
    (16, 16),
    (17, 17),
    (18, 18),
    (19, 19),
    (20, 20),
    (21, 21),
    (22, 22),
    (23, 23),
    (24, 24),
    (25, 25),
    (26, 26),
    (27, 27),
    (28, 28),
    (29, 29);




-- Insert 30 rows into the TrainTicket table with matching TrainID values from the Train table





	-- Insert 30 rows into the Complaints table
INSERT INTO Complaints (ComplaintDate, ComplaintStatus, ComplaintDescription, PassengerID)
VALUES
    ('2023-01-01', 'Open', 'Delay in train schedule', 1),
    ('2023-01-02', 'Closed', 'Lost luggage', 2),
    ('2023-01-03', 'Open', 'Unclean compartment', 3),
    ('2023-01-04', 'Closed', 'Unfriendly staff', 4),
    ('2023-01-05', 'Open', 'Noisy environment', 5),
    ('2023-01-06', 'Closed', 'Faulty air conditioning', 6),
    ('2023-01-07', 'Open', 'Late arrival at destination', 7),
    ('2023-01-08', 'Closed', 'Ticketing issue', 8),
    ('2023-01-09', 'Open', 'Crowded seating', 9),
    ('2023-01-10', 'Closed', 'Unreliable Wi-Fi', 10),
    ('2023-01-11', 'Open', 'Dirty restrooms', 11),
    ('2023-01-12', 'Closed', 'Noisy passengers', 12),
    ('2023-01-13', 'Open', 'Uncomfortable seats', 13),
    ('2023-01-14', 'Closed', 'Train cleanliness', 14),
    ('2023-01-15', 'Open', 'Inadequate security', 15),
    ('2023-01-16', 'Closed', 'Poor communication', 16),
    ('2023-01-17', 'Open', 'Overcrowded platforms', 17),
    ('2023-01-18', 'Closed', 'Late departure', 18),
    ('2023-01-19', 'Open', 'Lost and found issues', 19),
    ('2023-01-20', 'Closed', 'Unresponsive staff', 20),
    ('2023-01-21', 'Open', 'Train cleanliness', 21),
    ('2023-01-22', 'Closed', 'Faulty equipment', 22),
    ('2023-01-23', 'Open', 'Lost luggage', 23),
    ('2023-01-24', 'Closed', 'Unclean compartments', 24),
    ('2023-01-25', 'Open', 'Ticketing issues', 25),
    ('2023-01-26', 'Closed', 'Late arrival at destination', 26),
    ('2023-01-27', 'Open', 'Inadequate security', 27),
    ('2023-01-28', 'Closed', 'Unreliable Wi-Fi', 28),
    ('2023-01-29', 'Open', 'Dirty restrooms', 29),
    ('2023-01-30', 'Closed', 'Crowded seating', 30);




/*=============================================================================================================*/
/*login page*/

/* query for add new recorde in login table remmove */
INSERT INTO LogIn (UserName, UserPassword, LastLogin)
VALUES ('rahma', 'Rahmamourad', GETDATE());


/* query for rerive information about users*/

SELECT * FROM LogIn
WHERE UserName = 'user003' AND UserPassword = 'password003';

/*Retrieve user information for a specific username*/
SELECT * FROM LogIn WHERE UserName = 'user003';



/*Update the last login date for a user*/
UPDATE LogIn SET LastLogin = '2023-12-16' WHERE UserName = 'john_doe';



/*Delete a user from the LogIn table based on the username remove */
DELETE FROM LogIn WHERE UserName = 'john_doe';




/*Check if a username and password combination exists in the LogIn table*/
SELECT * FROM LogIn WHERE UserName = 'john_doe' AND UserPassword = 'password123';



insert into Staff (StaffID,StaffName,StaffRole,StaffAddress,StaffPhone)
values('s032','Ali','accountant','fayoum','010222')




/*=============================================================================================================*/





/*complaint Page*/



/* query for add new record for complaints table  */
INSERT INTO Complaints (ComplaintDate, ComplaintStatus, ComplaintDescription, PassengerID,ComplaintID)
VALUES (GETDATE(), 'Pending', 'Poor service on the train.', 'P001','31');


/* query for rerive all information about complains */
select * from Complaints




/*querey for retrive information of complaints for specific passenger to determine the problem*/
select Complaints.ComplaintID,Complaints.ComplaintStatus,Complaints.ComplaintDescription
from Complaints
where Complaints.PassengerID='p007'



/*querey for insert new record in complaints table for the same passenger */

insert into Complaints(ComplaintID,ComplaintStatus,ComplaintDescription,PassengerID)
values ('33','pending','crowded station','P007')


/*Retrieve complaint information for a specific complaint ID*/
SELECT * FROM Complaints WHERE ComplaintID = 1;


/*Update the complaint status for a specific complaint:*/


UPDATE Complaints SET ComplaintStatus = 'Resolved' WHERE ComplaintID = 1;



/*Delete a complaint from the Complaints table based on the complaint ID*/

DELETE FROM Complaints WHERE ComplaintID = 1;



/*Retrieve open complaints*/

SELECT * FROM Complaints WHERE ComplaintStatus = 'pending';

/*=============================================================================================================*/








/*Booking Page*/

/* retrive ticket id for each passenger */
select Passenger.PassengerID ,Passenger.PassengerName , Ticket.TicketID
from Passenger
inner join Ticket on Passenger.PassengerID=Ticket.PassengerID



/* retrive the stations for each train */ 
select train.TrainID, station.StationName , station.LocationStation,RouteTrainStation.StationID
from train 
inner join RouteTrainStation on RouteTrainStation.TrainID= Train.TrainID
inner join Station on RouteTrainStation.StationID=Station.StationID 






/* querey to add new record in ticket table for the same train to check the number of passenger */
insert into Ticket(TicketID,Fare,SeatNumber,Station,PassengerID,TrainID)
values('TT033',50,90,'Alex','p002','T005')



/* query for add new record for booking table  */
INSERT INTO Booking (BookingDate, PassengerID, TrainID,BookingID)
VALUES (GETDATE(), 'P001', 'T001','31');


/*Retrieve all bookings from the Booking table*/
SELECT * FROM Booking;

/*Retrieve booking information for a specific booking ID:*/
SELECT * FROM Booking WHERE BookingID = 'B001';





/*Update the booking date for a specific booking*/

UPDATE Booking SET BookingDate = '2023-12-16' WHERE BookingID = 'B001';


/*Delete a booking from the Booking table based on the booking ID*/
DELETE FROM Booking WHERE BookingID = 'B001';



/*=============================================================================================================*/



/*manger page*/


/*retrive the driver name who drive each train */ 
select TrainDriver.TrainID , Driver.DriverName
from TrainDriver
inner join Driver on Driver.StaffID=TrainDriver.DriverID
where DriverName='Driver30'



/*retrive the count of each payment statues */ 
select Payment.PaymentStatus,COUNT(Payment.PaymentID) AS paymentCount
from Payment 
group by Payment.PaymentStatus








/* retrive the number of passenger in each passenger  */ 
SELECT COUNT(Ticket.TicketID) AS NumberOfPassengers, Train.TrainID
FROM Train
INNER JOIN Ticket ON Ticket.TrainID = Train.TrainID
GROUP BY Train.TrainID;


/* querey for retrive the staff don't login more than one month  */

select Staff.StaffID,Staff.StaffName,Staff.StaffRole
from Staff
inner join LogIn on login.UserName=Staff.StaffID
where LogIn.LastLogin < DATEADD(MONTH, -1, GETDATE());



/* query for add new reocode in userstaff table  */
INSERT INTO UserStaff (StaffID, UserName)
VALUES ('S001', 'hossam');






/* retrive all information about specific passenger*/
select * from Passenger
where PassengerID='P005';


/* retrive the information for passengers whoes payment statues is successful */
select Passenger.PassengerID,Passenger.PassengerName
from Passenger
inner join Payment on Payment.PassengerID=Passenger.PassengerID
where Payment.PaymentStatus='pending'




/*=============================================================================================================*/





/*Lost&Found Page*/


/* RETRIVE	the information about the lost item based on item id */

select LostFound.Description,LostFound.ItemID,LostFound.LostLocation,LostFound.StationID
from LostFound
where LostFound.ItemID in ('LF025','LF004') 



/*Insert a new row into the LostFound table*/
INSERT INTO LostFound (ItemID, Description, FoundDate, LostLocation, StationID)
VALUES ('ABC123', 'Black wallet', '2023-12-15', 'Central Park', 'ram');


/*Retrieve all rows from the LostFound table*/
SELECT * FROM LostFound;

/*Retrieve items that were found on a specific date:*/
SELECT * FROM LostFound WHERE FoundDate = '2023-12-15';


/*Retrieve items that were lost at a specific location*/
SELECT * FROM LostFound WHERE LostLocation = 'Damanhur Rail Center';

/*Update the description of an item with a specific ItemID*/
UPDATE LostFound SET Description = 'Blue wallet' WHERE ItemID = 'ABC123';


/*Delete a row from the LostFound table based on the ItemID*/
DELETE FROM LostFound WHERE ItemID = 'ABC123';


/*Retrieve the ItemID and Description of items found at a specific station*/
SELECT ItemID, Description FROM LostFound WHERE StationID = 'ZGR';





/*=============================================================================================================*/

/*payment page */


/*Insert a new payment into the Payment table*/


INSERT INTO Payment (PaymentID, PaymentStatus, PaymentDate, PaymentAmount, PaymentMethod, PassengerID)
VALUES (33, 'Completed', '2023-12-15', 100.50, 'Credit Card', 'P030');


/*Retrieve all payments from the Payment table*/
SELECT * FROM Payment;


/*SELECT * FROM Payment WHERE PaymentID = 1;*/
SELECT * FROM Payment WHERE PaymentID = 1;


/*Update the payment status for a specific payment*/
UPDATE Payment SET PaymentStatus = 'Refunded' WHERE PaymentID = 1;


/*Calculate the total payment amount for all payments:*/
SELECT SUM(PaymentAmount) AS TotalPaymentAmount FROM Payment;

/*Retrieve payments associated with a specific passenger ID:*/

SELECT * FROM Payment WHERE PassengerID = 'P001';


	SELECT  *  FROM Booking
		SELECT  *  FROM Staff
			SELECT  *  FROM Passenger
				SELECT  *  FROM Complaints
					SELECT  *  FROM LostFound









































 








