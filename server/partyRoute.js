var models = require('./models');

exports.getParties = function(req, res) {
    models.Party
        .find()
        .limit(9)
        .exec(function(err, parties) {
            res.send({parties: parties});
        });
}

exports.addParty = function(req, res) {
    var newParty = new models.Party({
        "id": 5,
        "name": req.body.name,
        "numPeople": 1,
        "numSongs": 0,
        "currSongID": 0,
        "queue": []
    });
    newParty.save(function() {
        res.send({party: newParty});
    });
}