var express = require('express');
var port = process.env.PORT || 5000;
var app = express();

app.configure(function(){
  app.use(express.bodyParser());
  app.use(app.router);
});

var queue = require("./dist/public/queue.json");
var parties = require("./dist/public/parties.json");
app.use(express.static(__dirname + '/dist'));
app.listen(port);

var allParties = require('./routes/allParties');
var allSongs = require('./routes/allSongs');

var addParty = require('./routes/addParty');
var addSong = require('./routes/addSong');

app.get('/allParties', allParties.getParties);
app.get('/allSongs', allSongs.getSongs);

app.post('/addParty', addParty.addParty);
app.post('/addSong', addSong.addSong);