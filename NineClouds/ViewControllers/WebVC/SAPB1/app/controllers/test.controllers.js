/**
 * Created by nongzhizhong on 2017/1/4.
 */
var utils = require('../../config/utils')
var sql = require('../../config/sql')
var testM = require('../modules/test.modules')
var async = require('async')
module.exports = {
    test: function (req, res, next) {
        sql.getConnection(function (err,conn) {
            if(err){
                return next(utils.getError(utils.errmsg.ms1))
            }
            testM.test.testquery(conn,function (result) {
                sql.resSuccess(res,result,conn)
            })
        })
    }

}