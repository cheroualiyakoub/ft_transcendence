const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const PORT = process.env.PORT || 3003;

app.use(bodyParser.json());

app.get('/', (req, res) => {
    res.send('Match service is running!');
});

app.listen(PORT, () => {
    console.log(`Match service is listening on port ${PORT}`);
});