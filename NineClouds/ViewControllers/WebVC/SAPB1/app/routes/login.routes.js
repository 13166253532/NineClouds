/**
 * Created by nongzhizhong on 2017/3/6.
 */
var controller = require('../controllers/login.controllers')
var config = require('../../config/config')

module.exports = function(app){
    app.route(config.basepath + '/login')
        .post(controller.login);
    app.route(config.basepath + '/login/selectCompany')
        .get(controller.selectCompany)
}