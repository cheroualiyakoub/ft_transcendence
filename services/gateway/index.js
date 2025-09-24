const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {
    res.json({ service: 'gateway working', status: 'running', port: PORT });
});

app.listen(PORT, '0.0.0.0', () => {
    console.log(`Gateway service listening on port ${PORT}`);
});