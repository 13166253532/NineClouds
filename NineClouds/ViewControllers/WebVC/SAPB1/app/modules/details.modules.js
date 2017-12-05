/**
 * Created by leill on 2017/1/4.
 */
var config = require('../../config/config')
var sql = require('../../config/sql')
var utils = require('../../config/utils')
var async = require('async')
module.exports={
    selectDetails : function (conn,ordertype,docentry,callback) {
        var areas = []
        var content = []
        async.series([function (cb) {
            var _sql = "SELECT t.ID,t.COLUMNNAMECAN from MDB_FIELD t WHERE t.ORDERTYPE ="+sql.to(ordertype) + "and columntype = 'area' order by sort asc";
            sql.executeSql(conn, _sql, function (result) {
                if (result && result.length>0) {
                    utils.arrayAdd(areas,utils.toLowerArray(result))
                    cb(null);
                }
            })
        },
            function (cb) {
                for(var v of areas){
                    content.push({
                        id:  v.id,
                        fields : v.columnnamecan ,
                        nodetable : []
                    })
                }
                cb()
            },
            function (cb) {
                var i = 0
                async.whilst(function () {
                    return i < content.length
                },function (cb) {
                    var con = content[i]
                    var _sql = "SELECT t.VIEWTABLE,t.COLUMNS,t.COLUMNNAMECAN from MDB_FIELD t WHERE t.COLUMNPID ="+sql.to(con.id) + "and columntype = 'column' order by sort asc";
                    sql.executeSql(conn, _sql, function (result) {
                        if (result && result.length>0) {
                            result = utils.toLowerArray(result)
                            var k = 0
                            async.whilst(function () {
                                return k < result.length
                            },function (cb) {
                                var rj = result[k]
                                var _sql = "select "+rj.columns+" as a from "+rj.viewtable + " where DocEntry = " + sql.to(docentry)
                                sql.executeQuery(conn,_sql,function (result) {
                                    var cc = {
                                        key : rj.columnnamecan,
                                        value : ''
                                    }
                                    if(result.length>0){
                                        cc.value =  result[0].a
                                    }
                                    con.nodetable.push(cc)
                                    k++
                                    cb()
                                })

                            },function (err) {
                                i++
                                cb()
                            })

                        }else{
                            i++
                            cb()
                        }
                    })
                },function () {
                        cb()
                })
            }], function () {
            callback(content);
        })
    }

}


