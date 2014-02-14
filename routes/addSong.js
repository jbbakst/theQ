var queue = require("../dist/public/queue.json");

exports.addSong = function(req, res) {

    var newSong = {
        'name' : req.body.name,
        'artist' : req.body.artist,
        'album' : req.body.album,
        'score' : 1,
        'img' : 'http://lorempixel.com/500/500/people'
    }

    queue.push(newSong);

    res.send({ status: 'SUCCESS' , song: newSong });
}