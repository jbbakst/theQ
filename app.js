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


/*
*I am not sure if any of the blow shit woorks, Saraf
*if you could take a look at this and help me out. 
*
*/

var addParty = require('./routes/addParty');

app.post('/addParty', addParty.addParty);

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
function newParty(req, res){
	console.log("User clicked add Party")

	parties.parties.push();
}

//app.get('/new', addParty);
//app.get('/', addSong);