/**
 * Created by nongzhizhong on 2017/1/4.
 */
var config = require('../../config/config')
var sql = require('../../config/sql')
var utils = require('../../config/utils')
var async = require('async')
module.exports={
    submit : function (conn,DocEntry,OrderType,UserID,Approval,ApprovalMemo,companyId,callback) {

        var  StepCode =''
        async.series([
            function (cb) {
                var _sql='INSERT INTO MDB_TODOLIST SELECT * FROM  MOB_TodoList t WHERE t.OrderType = '+sql.to(OrderType)+ 'AND t.DocEntry = '+sql.to(DocEntry)
                sql.executeSql(conn,_sql,function(result){
                    if(result){
                        result=utils.toLowerArray(result)
                       cb()
                    }else{
                        cb(utils.getError('数据库操作有误!'))
                    }
                })
            },function (cb) {
                var _sql=''
               switch(OrderType){
                    case 'PUR':
                        _sql='INSERT INTO MDB_PUR_DETAILS SELECT * from MOB_PUR_Details t WHERE t.DocEntry = '+sql.to(DocEntry)
                        break;
                    case 'SAL':
                        _sql='INSERT INTO MDB_SAL_DETAILS SELECT * from MOB_SAL_Details t WHERE t.DocEntry ='+sql.to(DocEntry)
                        break;
                    case 'PAY':
                        _sql='INSERT INTO MDB_PAYMENT_DETAILS SELECT * from MOB_Payment_Details t WHERE t.DocEntry ='+sql.to(DocEntry)
                        break;

                }
                sql.executeSql(conn,_sql,function(result){
                    if(result){
                        result=utils.toLowerArray(result)
                        cb()
                    }else{
                        cb(utils.getError('数据库操作有误!'))
                    }
                })
            }, function (cb) {
            var _sql = 'SELECT t.StepCode from MOB_TodoList t WHERE' +
                ' t.DocEntry = '+sql.to(DocEntry)
            sql.executeSql(conn, _sql, function (result) {
                if (result && result.length>0) {
                    StepCode = result[0].StepCode;
                    cb(null);
                }else {
                    cb( utils.getError('数据库操作有误!'))
                }
            })
        },function (cb) {
            if(ApprovalMemo==''){
                var sqlstr=" EXEC MOB_UpdateDocStatus "+DocEntry+","+OrderType+",'"+UserID+"',"+Approval+",'',"+StepCode+","+companyId+""
            }else {
                var sqlstr= " EXEC MOB_UpdateDocStatus "+DocEntry+","+OrderType+",'"+UserID+"',"+Approval+","+ApprovalMemo+","+StepCode+","+companyId+""
            }
            sql.executeSql(conn, sqlstr, function (result) {
             cb()
            })
        }], function (err) {
            callback(err);
        })
    },

    submitSave : function (conn,DocEntry,OrderType,cb) {
        var _sql='INSERT INTO MDB_TODOLIST SELECT * FROM  MOB_TodoList t WHERE t.OrderType = '+sql.to(OrderType)+ 'AND t.DocEntry = '+sql.to(DocEntry)
        sql.executeSql(conn,_sql,function(result){
            if(result){
                result=utils.toLowerArray(result)
                cb(result)
            }else{
                cb(null)
            }
        })
        },
    submitSaveDetail:function(conn,DocEntry,OrderType,cb){
        var _sql=''
        switch(OrderType){
            case 'PUR':
                _sql='INSERT INTO MDB_PUR_DETAILS SELECT * from MOB_PUR_Details t WHERE t.DocEntry = '+sql.to(DocEntry)
            break;

            case 'SAL':
                _sql='INSERT INTO MDB_SAL_DETAILS SELECT * from MOB_SAL_Details t WHERE t.DocEntry ='+sql.to(DocEntry)
            break;

            case 'PAY':
                _sql='INSERT INTO MDB_PAYMENT_DETAILS SELECT * from MOB_Payment_Details t WHERE t.DocEntry ='+sql.to(DocEntry)
            break;

        }
        sql.executeSql(conn,_sql,function(result){
            if(result){
                result=utils.toLowerArray(result)
                cb(result)
            }else{
                cb(null)
            }
        })
    }
}


