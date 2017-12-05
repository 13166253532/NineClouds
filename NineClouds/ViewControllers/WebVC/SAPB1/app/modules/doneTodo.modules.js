/**
 * Created by nongzhizhong on 2017/1/4.
 */
var config = require('../../config/config')
var sql = require('../../config/sql')
var utils = require('../../config/utils')
var async = require('async')
module.exports={

    selectDonelist:function (conn,approvalId,pagerCount,pagerNum,conDition,companyId,callback) {
        var _sql = "SELECT * FROM MDB_TODOLIST WHERE ORG_ID = "+sql.to(companyId)+" and ApprovalID= "+sql.to(approvalId)+"and CONCAT(DocDate,DocEntry,U_SP_PURDocNum,DocType,OrderType,Sales) like '%"+conDition+"%'"
        _sql = sql.pager(_sql,(pagerNum-1)*pagerCount,pagerNum*pagerCount)
        sql.executeQuery(conn,_sql,callback)
    }
}


