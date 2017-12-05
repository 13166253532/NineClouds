/**
 * Created by nongzhizhong on 2017/3/6.
 */
var controller = require('../controllers/test.controllers')
var config = require('../../config/config')

module.exports = function(app){
    app.route(config.basepath + '/test')
        .get(controller.test)
}