var parties = require("../dist/public/parties.json");

exports.addParty = function(req, res){

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

	parties.push(newParty);

	res.send({ status: 'SUCCESS' , party: newParty });
}