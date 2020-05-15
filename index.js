const express = require('express');
const app = express();
app.use('/', express.static('editor'));
app.use('/source', express.static('src'));

// app.get('/', (req, res) => {
//     res.send('An alligator approaches!');
// });

app.listen(8192, () => console.log('Editor listening on port 8192!'));