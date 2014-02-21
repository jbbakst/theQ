var models = require('./models');

var currID = 0;

exports.getQueue = function(req, res) {
    models.Party
        .find({}, function(data) {
            console.log('>>>>>>>>', err);
            console.log('>>>>>>>>', data);
            console.log('>>>>>>>>');
            var queue = data.toObject.queue;
            queue.sort(queueSortFn);
            res.send(queue);
        });
}

exports.addSong = function(req, res) {
    var newSong = new models.Song({
        'id': currID++,
        'score' : 1
    });
    newSong.save(function() {
        res.send(newSong);
    });
}

exports.upvote = function(req, res) {
    models.Song
        .find({ 'id': req.body.id })
        .update({ $inc: 1 })
        .exec(function() {
            models.Party
                .find({}, function(data) {
                    var queue = data.toObject.queue;
                    queue.sort(queueSortFn);
                    res.send(queue);
                });
        });
}

queueSortFn = function(a, b) {
    return b.score - a.score;
}