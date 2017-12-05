/**
 * Created by nongzhizhong on 2017/1/4.
 */
var utils = require('../../config/utils')
var sql = require('../../config/sql')
var loginM = require('../modules/login.modules')
var async = require('async')
module.exports = {
    login: function (req, res, next) {
        var body = req.body
        if(utils.isEmpty(body) || utils.isEmpty(body.userid) || utils.isEmpty(body.password)){
            return next(  utils.getError(utils.errmsg.ms1)  )
        }
        sql.getConnection(function (err,conn) {
            if(err){
                return next(err)
            }
            loginM.login(conn,{
                userid : body.userid,
                password : body.password
            },function (result) {
                if(result){
                    sql.resSuccess(res,result,conn)
                }else{
                    sql.doRelease(conn)
                    return next(err)
                }
            })
        })
    },
    selectCompany:function (req,res,next) {

        sql.getConnection(function (err,conn) {
            if(err){
                return next(err)
            }
            loginM.selectCompany(conn,function (result) {
                var body={
                    "companyList":[]
                }
                body.companyList=result
                sql.resSuccess(res,body,conn)
            })
        })

    }
}