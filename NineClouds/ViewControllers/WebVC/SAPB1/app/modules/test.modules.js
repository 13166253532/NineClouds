/**
 * Created by nongzhizhong on 2017/1/4.
 */
var config = require('../../config/config')
var sql = require('../../config/sql')
var utils = require('../../config/utils')
var async = require('async')
module.exports={
    test: {
        testquery:function(conn,cb){
            var _sql="SELECT * FROM test_uu"
            sql.executeSql(conn,_sql,function(result){
                if(result){
                    result=utils.toLowerArray(result)
                    cb(result)
                }else{
                    cb(null)
                }
            })
        }
    },


}


