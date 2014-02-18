var express = require('express'), app = express();
app.use(express.urlencoded());
app.use(express.json());
app.use(express.static(__dirname + '/dist'));
var port = process.env.PORT || 5000;
app.listen(port);


var parties = require("./parties.json");
app.get('/allParties', function(req, res) {
    res.send(parties);
});
app.post('/addParty', function(req, res) {
    var newParty = {
        "id": 5,
        "name": req.body.name,
        "location": {
            "x": 124.5875,
            "y": 825.9827
        },
        "numPeople": 1,
        "numSongs": 0,
        "currSongID": "kh6k6g"
    }
    parties.unshift(newParty);
    res.send({ status: 'SUCCESS' , party: newParty });
});


var queue = require("./queue.json");
app.get('/allSongs', function(req, res) {
    res.send(queue);
});
app.post('/addSong', function(req, res) {
    var newSong = {
        'name' : req.body.name,
        'artist' : req.body.artist,
        'album' : req.body.album,
        'score' : 1,
        'img' : 'http://lorempixel.com/500/500/people'
    }
    queue.push(newSong);
    res.send({ status: 'SUCCESS' , song: newSong });
});