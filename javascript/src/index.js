const express    = require('express');
const app        = express();
const http       = require('http').Server(app);
const db         = require('./database');
const bodyParser = require('body-parser');

let user_id = 0;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(__dirname + '/public/'));

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html');
});

app.post('/add', (req, res) => {
    db.add_user(req.body)
        .then (r => {
            user_id = r;
            res.status(200).send(r);
        })
        .catch(e => console.log(e));
});

app.post('/edit', (req, res) => {
    // console.log(req.query.user_id);
    db.edit_user(req.query.user_id, req.body)
        .then (r => res.status(200).send(r))
        .catch(e => console.log(e));
});

http.listen(process.env.PORT || 3000, function () {
    console.log('listening on 0.0.0.0:3000');
});