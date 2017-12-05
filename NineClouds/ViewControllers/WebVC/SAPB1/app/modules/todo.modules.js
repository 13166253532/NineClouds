/**
 * Created by nongzhizhong on 2017/1/4.
 */
var config = require('../../config/config')
var sql = require('../../config/sql')
var utils = require('../../config/utils')
var async = require('async')
module.exports={
    login : function (conn,entity,callback) {
        var _sql = "SELECT * from MOB_OUSR where userid = " + sql.to(entity.userid) + " and password = " + sql.to(entity.password)
        sql.executeQuery(conn,_sql,function (result) {
            var content = 'N'
            if(result.length>0){
                content = 'Y'
            }
            utils.log('content',content)
            callback(content)
        })
    },
  /*  list : function (conn,userid,pagerNum,pagerCount,callback) {
    var _sql = "SELECT * from MOB_TodoList where ApprovalID = "+sql.to(userid) + " ORDER BY DocDate desc"
    _sql = sql.pager(_sql,(pagerNum-1)*pagerCount,pagerNum*pagerCount)
    sql.executeQuery(conn,_sql,callback)
},*/

    selectlist:function (conn,approvalId,pagerCount,pagerNum,conDition,companyId,callback) {
        var _sql = "SELECT * FROM MOB_TodoList WHERE  ORG_ID = "+sql.to(companyId)+" and  ApprovalID= "+sql.to(approvalId)+"and CONCAT(DocDate,DocEntry,U_SP_PURDocNum,DocType,OrderType,Sales) like '%"+conDition+"%'"
        _sql = sql.pager(_sql,(pagerNum-1)*pagerCount,pagerNum*pagerCount)
        sql.executeQuery(conn,_sql,callback)
    }
}


