// filepath: /Users/ycheroua/CorCur42/ft_transcendence/ft_transcendence/services/ai/index.js
const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const PORT = process.env.PORT || 3005;

app.use(bodyParser.json());

app.get('/', (req, res) => {
    res.json({ service: 'ai', status: 'running', port: PORT });
});

app.listen(PORT, () => {
    console.log(`AI service is listening on port ${PORT}`);
});