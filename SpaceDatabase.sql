-- Create the database
CREATE DATABASE IF NOT EXISTS galactic_destinations_db;
USE galactic_destinations_db;

-- Creating the 'Travellers' table
CREATE TABLE Travellers (
    traveller_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    username VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255)  -- Consider using more secure methods for storing passwords
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Creating the 'Destinations' table
CREATE TABLE Destinations (
    destination_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255), -- e.g., 
    description TEXT, -- info on the destination
    experience TEXT, -- moonwalk, spacewalk, etc.
    image_url VARCHAR(255), -- URL to an image of the planet
    location VARCHAR(255), -- planet, moon, etc.
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Creating the 'Tiers' table
CREATE TABLE Tiers (
    tier_id INT AUTO_INCREMENT PRIMARY KEY,
    destination_id INT, -- Foreign key to the Destinations table
    tier_name VARCHAR(255), -- mainstrea, premium, luxury
    tier_description TEXT, -- e.g., 'Mainstream', 'Premium', 'Luxury'
    max_destinations INT, -- 2, 4, 6
    trip_days INT,  -- 2 4 6
    base_price DECIMAL(10, 2)  -- 1000.00, 2000.00, 3000.00 ?
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Creating the 'Cruises' table
CREATE TABLE CruiseShips (
    cruise_ship_id INT AUTO_INCREMENT PRIMARY KEY,
    destination_id INT, -- Foreign key to the Destinations table
    tier_id INT,  -- Foreign key to the Tiers table
    ship_name VARCHAR(255),
    capacity INT, -- number of passengers the ship can accommodate
    crew INT, -- number of crew members on the ship
    FOREIGN KEY (tier_id) REFERENCES Tiers(tier_id)
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Creating the 'Tickets' table
CREATE TABLE Tickets (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    traveller_id INT, -- Foreign key to the Travellers table
    cruise_ship_id INT,
    quantity INT,  -- number of tickets purchased
    departureDate DATE,
    returnDate DATE,
    FOREIGN KEY (traveller_id) REFERENCES Travellers(traveller_id),
    FOREIGN KEY (cruise_ship_id) REFERENCES CruiseShips(cruise_ship_id),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Creating the 'Cart' table
CREATE TABLE Cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    traveller_id INT,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (traveller_id) REFERENCES Users(traveller_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE Market_Item_Types (
    item_type_id INT AUTO_INCREMENT PRIMARY KEY,
    item_type_name VARCHAR(255)  -- e.g., 'souvenir', 'photo_package'
    item_description TEXT  -- Added as part of the table creation
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Creating a table for the Galactic Market offerings
CREATE TABLE Galactic_Market (
    market_id INT AUTO_INCREMENT PRIMARY KEY,
    item_type_id INT, --brings item_type_name item_description from Market_Item_Types
    item_price DECIMAL(10, 2)
    FOREIGN KEY (item_type_id) REFERENCES Market_Item_Types(item_type_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Creating the 'Cart_Items' table
CREATE TABLE Cart_Items (
    cart_item_id INT AUTO_INCREMENT PRIMARY KEY,
    cart_id INT,
    ticket_id INT,
    market_id INT,
    quantity INT,
    subtotal DECIMAL(10, 2),
    FOREIGN KEY (cart_id) REFERENCES Cart(cart_id),
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id)
    FOREIGN KEY (market_id) REFERENCES Galactic_Market(market_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Creating the 'Reviews' table
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    traveller_id INT,
    destination_id INT,
    rating INT,
    comment TEXT,
    FOREIGN KEY (traveller_id) REFERENCES Users(traveller_id),
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;