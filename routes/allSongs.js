var songs = require("../dist/public/queue.json");

exports.getSongs = function(req, res){
    res.send(songs);
}