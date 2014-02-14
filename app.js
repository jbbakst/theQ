var express = require('express');
var port = process.env.PORT || 5000;
var app = express();
var queue = require("/queue.json");
var parties = require("/parties.json");
app.use(express.static(__dirname + '/dist'));
app.listen(port);


/*
*I am not sure if any of the blow shit woorks, Saraf
*if you could take a look at this and help me out. 
*
*/


/* Adds song imput the othe queue.json)
*
*/ 
function songToData(req, res) {
	var newSong = {'name' : req.query.title,
		'artist' : req.query.artist,
		'album' : req.query.album,
		'score' : 1,
		'img' : 'http://lorempixel.com/500/500/people'}
	console.log(newSong);
	queue.push(newSong); 
}

/*Pair with the other function. this needs some work. 
*
*/
function newParty(){
	console.log("User clicked add Party")
	$.post("/parties", {""}, )
}

/*Adds the party to party.json
*
*/

function partyToData(req, res){
	var newParty = {
		"id": 5,
		"name": req.query.name,
		"location": {
			"x": 124.5875,
			"y": 825.9827
		},
		"numPeople": 80, 
		"numSongs": 40,
		"currSongID": "kh6k6g"
	}

	console.log(newParty);

	queue.push(newParty); 
}

app.get('/new', addParty);
app.get('/', addSong);