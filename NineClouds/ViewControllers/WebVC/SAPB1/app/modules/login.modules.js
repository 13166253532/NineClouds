/**
 * Created by leill on 2017/9/12.
 */
var config = require('../../config/config')
var sql = require('../../config/sql')
var utils = require('../../config/utils')
var async = require('async')
module.exports={
    login : function (conn,entity,callback) {
        var content = ''
        var _sql = "SELECT * from MDB_OUSR where USER_CODE = " + sql.to(entity.userid) + " and password = " + sql.to(entity.password)
        sql.executeQuery(conn,_sql,function (result) {
            content = 'N'
            if(result.length>0){
                content = 'Y'
            }
            utils.log('content',content)
            callback(content)
        })
    },
    selectCompany:function (conn,callback) {
       // var content = []
        var _sql = "SELECT DISTINCT t.ORG_ID , o.ORG_NAME from MDB_OUSR t LEFT JOIN ORGNAME o ON t.ORG_ID = o.ORG_ID ";
        sql.executeQuery(conn,_sql,callback);
    }
}


