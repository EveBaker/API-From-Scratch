CREATE DATABASE IF NOT EXISTS SpaceCruiseDB;
USE SpaceCruseDB;

CREATE TABLE IF NOT EXISTS SpaceCrafts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(225) NOT NULL,
    class VARCHAR(100),
    capacity INT,
    crew INT,
    destinations TEXT,
    amenities TEXT,
    departureDate DATE,
    returnDate DATE
);