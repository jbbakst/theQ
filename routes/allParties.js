var parties = require("../dist/public/parties.json");

exports.getParties = function(req, res){
    res.send(parties);
}