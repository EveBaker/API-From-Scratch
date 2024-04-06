const fs = require('fs');
const mysql = require('mysql');

const rawData = fs.readFileSync('space_cruise.json');
const spaceCruiseData = JSON.parse(rawData);

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
    database: 'SpaceCruiseDB'
});

connection.connect();

spaceCruiseData.SpaceCruise.forEach(spacecraft => {
    const { name, class: classType, capacity, crew, destinations, amenities, departureDate, returnDate } = spacecraft;
    const amenitiesStr = amenities.join(", ");
    const query = `INSERT INTO SpaceCrafts (name, class, capacity, crew, destinations, amenities, departureDate, returnDate) VALUES (?, ?, ?, ?, ?, ?, ?, ?)`;

    connection.query(query, [name, classType, capacity, crew, destinations, amenitiesStr, departureDate, returnDate], (error, results) => {
        if (error) {
            console.error(error.message);
            return;
        }
        console.log(`Inserted data for spacecraft: ${name}`);
    });
});

connection.end();