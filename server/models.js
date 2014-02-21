var Mongoose = require('mongoose');

var SongSchema = new Mongoose.Schema({
    'id': String,
    'score': Number
});

var PartySchema = new Mongoose.Schema({
    'id': Number,
    'name': String,
    'numPeople': Number,
    'numSongs': Number,
    'currSongID': String,
    'queue': [SongSchema]
});

exports.Song = Mongoose.model('Song', SongSchema);
exports.Party = Mongoose.model('Party', PartySchema);