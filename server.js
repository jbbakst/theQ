var express = require('express'), app = express();
app.use(express.urlencoded());
app.use(express.json());
app.use(express.static(__dirname + '/dist'));
var port = process.env.PORT || 5000;
app.listen(port);

var mongoose = require('mongoose');
var database_uri = process.env.MONGOLAB_URI
mongoose.connect(database_uri);


var partyRoute = require('./server/partyRoute');
var queueRoute = require('./server/queueRoute');

app.get('/allSongs', queueRoute.getQueue);
app.post('/addSong', queueRoute.addSong);
app.post('/upvote', queueRoute.upvote);

app.get('/allParties', partyRoute.getParties);
app.post('/addParty', partyRoute.addParty);
