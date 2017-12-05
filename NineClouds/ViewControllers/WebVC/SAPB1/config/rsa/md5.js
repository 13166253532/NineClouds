/**
 * Created by air on 2016/5/27.
 */
module.exports = {
    encode : function (data) {
        //var Buffer = require("buffer").Buffer;
        //var buf = new Buffer(data);
        //var str = buf.toString("binary");
        var crypto = require("crypto");
        //return crypto.createHash("md5").update(str).digest("hex").toUpperCase();
        return crypto.createHash("md5").update(data).digest("hex").toUpperCase();
    }
}
