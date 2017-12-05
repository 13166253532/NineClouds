/**
 * Created by air on 2016/4/27.
 */
var config = null;


if(process && process.env && process.env.NODE_ENV) {
    config = require('./env/' + process.env.NODE_ENV + '.js');
} else {
    config = require('./env/development_p.js');
    //config = require('./env/development.js');
    //config = require('./env/development_test.js');
    //config = require('./env/development_local.js');
}





module.exports = config;