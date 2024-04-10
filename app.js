const express = require('express');
const bodyParser = require('body-parser');
const userRoutes = require('./routes/userRoutes');
const passengerRoutes = require('./routes/passengerRoutes');
const travelerRoutes = require('./routes/travelerRoutes');

const app = express();
const port = process.env.PORT || 3000;

app.use(bodyParser.json());
app.use('/api/users', userRoutes);


app.use(bodyParser.json());
app.use('/api/users', userRoutes);
app.use('/api/passengers', passengerRoutes);
app.use('/api/travelers', travelerRoutes);


app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
