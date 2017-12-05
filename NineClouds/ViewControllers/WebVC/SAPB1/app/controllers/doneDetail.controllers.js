/**
 * Created by nongzhizhong on 2017/1/4.
 */
var utils = require('../../config/utils')
var sql = require('../../config/sql')
var M = require('../modules/doneDetail.modules')
var async = require('async')
module.exports = {
    selectDoneDetail: function (req, res, next) {
        var types = req.query.ordertype;
        var docentry = req.query.docentry;

        if(utils.isEmpty(types) || utils.isEmpty(docentry)){
            return next(utils.getError(utils.errmsg.ms1))
        }
        sql.getConnection(function (err,conn) {
            if(err){
                return next(utils.getError(err.message))
            }
            M.selectDoneDetail(conn,types,docentry,function (result) {
                sql.resSuccess(res,result,conn)
            })
        })
    }
}