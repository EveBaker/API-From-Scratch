const express = require('express');
const mysql = require('mysql2');
require('dotenv').config();

const router = express.Router();

// Create a MySQL connection
const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME
});

// Create User
router.post('/', (req, res) => {
  const { username, email, password } = req.body;
  db.execute(
    'INSERT INTO users (username, email, password) VALUES (?, ?, ?)',
    [username, email, password],
    (error, results) => {
      if (error) return res.status(500).json({ error });
      res.status(201).json({ message: 'User created', userId: results.insertId });
    }
  );
});

// Get User by ID
router.get('/:id', (req, res) => {
  const { id } = req.params;
  db.execute('SELECT * FROM users WHERE id = ?', [id], (error, results) => {
    if (error) return res.status(500).json({ error });
    if (results.length === 0) return res.status(404).json({ message: 'User not found' });
    res.status(200).json(results[0]);
  });
});

// Add Passenger
router.post('/', (req, res) => {
    const { userId, name } = req.body;
    db.execute(
      'INSERT INTO passengers (user_id, name) VALUES (?, ?)',
      [userId, name],
      (error, results) => {
        if (error) return res.status(500).json({ error });
        res.status(201).json({ message: 'Passenger added', passengerId: results.insertId });
      }
    );
  });
  
  // Get Passenger by ID
  router.get('/:id', (req, res) => {
    const { id } = req.params;
    db.execute('SELECT * FROM passengers WHERE id = ?', [id], (error, results) => {
      if (error) return res.status(500).json({ error });
      if (results.length === 0) return res.status(404).json({ message: 'Passenger not found' });
      res.status(200).json(results[0]);
    });
  });

  // Add Passenger
router.post('/', (req, res) => {
    const { userId, name } = req.body;
    db.execute(
      'INSERT INTO passengers (user_id, name) VALUES (?, ?)',
      [userId, name],
      (error, results) => {
        if (error) return res.status(500).json({ error });
        res.status(201).json({ message: 'Passenger added', passengerId: results.insertId });
      }
    );
  });
  
  // Get Passenger by ID
  router.get('/:id', (req, res) => {
    const { id } = req.params;
    db.execute('SELECT * FROM passengers WHERE id = ?', [id], (error, results) => {
      if (error) return res.status(500).json({ error });
      if (results.length === 0) return res.status(404).json({ message: 'Passenger not found' });
      res.status(200).json(results[0]);
    });
  });

module.exports = router;
