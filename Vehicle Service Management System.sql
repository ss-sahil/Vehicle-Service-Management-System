-- Vehicle Service Management System
-- DBMS Mini Project


-- 1. Creating the Database

CREATE DATABASE Vehicle_Service_DB;
USE Vehicle_Service_DB;


-- 2. Creating Customers Table

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    email VARCHAR(50),
    city VARCHAR(30)
);


-- 3. Creating Vehicles Table

CREATE TABLE Vehicles (
    vehicle_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    vehicle_number VARCHAR(20) NOT NULL,
    brand VARCHAR(30) NOT NULL,
    model VARCHAR(30) NOT NULL,
    fuel_type VARCHAR(15),
    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
);


-- 4. Creating Mechanics Table

CREATE TABLE Mechanics (
    mechanic_id INT PRIMARY KEY,
    mechanic_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(30),
    phone VARCHAR(15)
);


-- 5. Creating Service Records Table

CREATE TABLE Service_Records (
    service_id INT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    mechanic_id INT NOT NULL,
    service_date DATE NOT NULL,
    service_type VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL,
    cost DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (vehicle_id)
        REFERENCES Vehicles(vehicle_id),
    FOREIGN KEY (mechanic_id)
        REFERENCES Mechanics(mechanic_id)
);


-- 6. Creating Bills Table

CREATE TABLE Bills (
    bill_id INT PRIMARY KEY,
    service_id INT NOT NULL,
    bill_date DATE NOT NULL,
    service_cost DECIMAL(10,2) NOT NULL,
    tax DECIMAL(10,2) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    payment_mode VARCHAR(20) NOT NULL,
    FOREIGN KEY (service_id)
        REFERENCES Service_Records(service_id)
);


-- 7. Inserting Customer Details

INSERT INTO Customers
(customer_id, name, phone, email, city)
VALUES
(1, 'Rahul Sharma', '9876543210', 'rahul@gmail.com', 'Chandigarh'),
(2, 'Priya Singh', '9812345678', 'priya@gmail.com', 'Mohali'),
(3, 'Amit Verma', '9855512345', 'amit.v@yahoo.com', 'Panchkula'),
(4, 'Sneha Patel', '9988776655', 'sneha@gmail.com', 'Chandigarh'),
(5, 'Vikas Kumar', '9776655443', 'vikas.k@gmail.com', 'Kharar'),
(6, 'Ananya Roy', '9665544332', 'ananya@outlook.com', 'Mohali');


-- 8. Inserting Vehicle Details

INSERT INTO Vehicles
(vehicle_id, customer_id, vehicle_number, brand, model, fuel_type)
VALUES
(101, 1, 'CH01-AB-1234', 'Maruti', 'Swift', 'Petrol'),
(102, 1, 'CH01-CC-9900', 'Honda', 'Activa 6G', 'Petrol'),
(103, 2, 'PB65-XY-4567', 'Hyundai', 'i20', 'Diesel'),
(104, 3, 'HR03-MN-7890', 'Tata', 'Nexon', 'EV'),
(105, 4, 'CH01-CD-3456', 'Kia', 'Seltos', 'Petrol'),
(106, 5, 'PB11-BK-8822', 'Royal Enfield', 'Classic 350', 'Petrol'),
(107, 6, 'PB65-ZZ-1100', 'Toyota', 'Glanza', 'Petrol');


-- 9. Inserting Mechanic Details

INSERT INTO Mechanics
(mechanic_id, mechanic_name, specialization, phone)
VALUES
(201, 'Ramesh Kumar', 'Engine Expert', '9811122233'),
(202, 'Sukhwinder Singh', 'Brakes & Suspension', '9822233344'),
(203, 'Deepak Sharma', 'General Servicing', '9833344455'),
(204, 'Manoj Yadav', 'Electrical & Battery', '9844455566');


-- 10. Inserting Service Records

INSERT INTO Service_Records
(service_id, vehicle_id, mechanic_id, service_date,
 service_type, status, cost)
VALUES
(301, 101, 201, '2026-10-01', 'Engine Oil Change', 'Completed', 1500.00),
(302, 102, 203, '2026-10-03', 'General Periodic Service', 'Completed', 800.00),
(303, 103, 202, '2026-10-05', 'Brake Pad Replacement', 'Completed', 2200.00),
(304, 104, 204, '2026-10-08', 'Battery Health Checkup', 'Completed', 1200.00),
(305, 105, 201, '2026-10-10', 'Full Engine Tune-up', 'Completed', 3500.00),
(306, 106, 203, '2026-10-15', 'Chain Lubing & Tuning', 'In Progress', 600.00),
(307, 107, 202, '2026-10-18', 'Suspension Overhaul', 'Pending', 2800.00);


-- 11. Inserting Bill Details

INSERT INTO Bills
(bill_id, service_id, bill_date, service_cost,
 tax, total_amount, payment_mode)
VALUES
(401, 301, '2026-10-01', 1500.00, 270.00, 1770.00, 'UPI - GPay'),
(402, 302, '2026-10-03', 800.00, 144.00, 944.00, 'Cash'),
(403, 303, '2026-10-05', 2200.00, 396.00, 2596.00, 'Debit Card'),
(404, 304, '2026-10-08', 1200.00, 216.00, 1416.00, 'UPI - PhonePe'),
(405, 305, '2026-10-10', 3500.00, 630.00, 4130.00, 'Credit Card');


-- 12. Displaying Customer Details

SELECT * FROM Customers;


-- 13. Displaying Vehicle Details

SELECT * FROM Vehicles;


-- 14. Displaying Mechanic Details

SELECT * FROM Mechanics;


-- 15. Displaying Service Records

SELECT * FROM Service_Records;


-- 16. Displaying Bill Details

SELECT * FROM Bills;


-- 17. Displaying Complete Service Details Using JOIN

SELECT
    c.name AS customer_name,
    v.vehicle_number,
    v.brand,
    s.service_type,
    m.mechanic_name,
    s.status,
    s.cost
FROM Customers c
INNER JOIN Vehicles v
    ON c.customer_id = v.customer_id
INNER JOIN Service_Records s
    ON v.vehicle_id = s.vehicle_id
INNER JOIN Mechanics m
    ON s.mechanic_id = m.mechanic_id;


-- 18. Finding Total Services and Spending of Each Customer

SELECT
    c.name,
    COUNT(s.service_id) AS total_services,
    SUM(s.cost) AS total_spent
FROM Customers c
INNER JOIN Vehicles v
    ON c.customer_id = v.customer_id
INNER JOIN Service_Records s
    ON v.vehicle_id = s.vehicle_id
GROUP BY c.customer_id, c.name;


-- 19. Displaying Billing Summary

SELECT
    b.bill_id,
    c.name AS customer,
    v.vehicle_number,
    s.service_type,
    b.total_amount,
    b.payment_mode
FROM Bills b
INNER JOIN Service_Records s
    ON b.service_id = s.service_id
INNER JOIN Vehicles v
    ON s.vehicle_id = v.vehicle_id
INNER JOIN Customers c
    ON v.customer_id = c.customer_id;


-- 20. Displaying Pending Services

SELECT *
FROM Service_Records
WHERE status = 'Pending';


-- 21. Displaying Services in Progress

SELECT *
FROM Service_Records
WHERE status = 'In Progress';


-- 22. Displaying Completed Services

SELECT *
FROM Service_Records
WHERE status = 'Completed';


-- 23. Sorting Services by Cost

SELECT *
FROM Service_Records
ORDER BY cost DESC;


-- 24. Counting Total Customers

SELECT COUNT(*) AS total_customers
FROM Customers;


-- 25. Counting Total Vehicles

SELECT COUNT(*) AS total_vehicles
FROM Vehicles;


-- 26. Calculating Total Service Revenue

SELECT SUM(cost) AS total_service_revenue
FROM Service_Records;


-- 27. Calculating Total Bill Amount

SELECT SUM(total_amount) AS total_bill_amount
FROM Bills;


-- 28. Displaying Payment Details

SELECT bill_id, bill_date, total_amount, payment_mode
FROM Bills;


-- 29. Finding Vehicles of a Customer

SELECT *
FROM Vehicles
WHERE customer_id = 1;


-- 30. Displaying Mechanic Details and Specializations

SELECT mechanic_name, specialization
FROM Mechanics;


-- End of Project
