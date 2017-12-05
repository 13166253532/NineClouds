/**
 * Created by nongzhizhong on 2017/3/6.
 */
var controller = require('../controllers/todo.controllers')
var config = require('../../config/config')

module.exports = function(app){
    /*app.route(config.basepath + '/todo/list')
        .get(controller.list),*/
    app.route(config.basepath + '/todo/selectlist')
        .get(controller.selectlist)
}