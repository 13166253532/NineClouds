/**
 * Created by nongzhizhong on 2017/1/4.
 */
var utils = require('../../config/utils')
var sql = require('../../config/sql')
var M = require('../modules/todo.modules')
var async = require('async')
module.exports = {
    selectlist:function (req,res,next) {
        var approvalId = req.query.approvalId;//当前登录人工号
        var conDition = req.query.conDition;//搜索框内传进来的字符串
        var pagerNum = parseInt(req.query.pagerNum ) || 1
        var pagerCount = parseInt(req.query.pagerCount ) || 10
        var companyId = req.query.companyId;//当前登录人公司
        if( utils.isEmpty(approvalId) || utils.isEmpty(companyId)){
            return next(  utils.getError(utils.errmsg.ms1)  )
        }
        sql.getConnection(function (err,conn) {
            if(err){
                return next(err)
            }
            M.selectlist(conn,approvalId,pagerCount,pagerNum,conDition,companyId,function (result) {
                sql.resSuccess(res,result,conn)
            })
        })

    }
}