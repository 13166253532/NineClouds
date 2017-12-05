/**
 * Created by air on 2016/6/29.
 */
var mysql      = require('mysql');
var config = require('../config/config');
var utils = require('./utils')
module.exports = {
    outformat :  {},
    mysql : mysql,
    pager : function(sql,start,end){
        return sql+' limit '+start+','+end;
    },
    getConnection : function(cb){
        console.log(config.mysqlsaas)
        var connection =   mysql.createConnection(
            //config.mysqlobj
            config.mysqlsaas
        );
        connection.connect(function(err) {
            if (err) {
                cb(err,null);
            }
            connection.beginTransaction(function(err){
                if(err){
                    cb(err,null);
                }
                cb(null,connection);
            })
        });
    },
    getConnectionC : function(cb){
        console.log(config.mysqlobj)
        var connection =   mysql.createConnection(
            config.mysqlobj
            //config.mysqlsaas
        );
        connection.connect(function(err) {
            if (err) {
                cb(err,null);
            }
            connection.beginTransaction(function(err){
                if(err){
                    cb(err,null);
                }
                cb(null,connection);
            })
        });
    },
    getConnectionE : function(cb){
        console.log(config.myssqlobj_caiyang)
        var connection =   mysql.createConnection(
            config.myssqlobj_caiyang
            //config.mysqlsaas
        );
        connection.connect(function(err) {
            if (err) {
                cb(err,null);
            }
            connection.beginTransaction(function(err){
                if(err){
                    cb(err,null);
                }
                cb(null,connection);
            })
        });
    },
    rollback : function (connection,callback) {
        connection.rollback(function(err) {
            if(err){
                utils.getError(err.message)
            }
            connection.end;
            callback(err)
        });
    },
    doRelease : function(connection){
        if(connection){
            if(!connection.xudp){
                connection.commit(function(err){
                    if(err){
                        utils.getError(err.message)
                        connection.rollback(function(err) {
                            if(err){
                                utils.getError(err.message)
                            }
                            console.log('rollback')
                            connection.end;
                        });
                    }else{
                        console.log('doRelease')
                        connection.end;
                    }
                })
            }else{
                connection.rollback(function(err) {
                    if(err){
                        utils.getError(err.message)
                    }
                    console.log('rollback')
                    connection.end;
                });
            }
        }else{
            console.log('doRelease Error')
        }
    },
    execute : function(conn,url,cb){
        conn.query(url,function(err,result){
            if(err){
                utils.info(url+'-->Error,execute')
                conn.xudp = err
                cb(err,null)
            }else{
                //cb(null,utils.toUpper(result))
                utils.info(url+'-->Success')
                if(!result || utils.isArray(result)){
                    cb(null,utils.toUpperArray(result))
                }else{
                    var obj = null
                    try {
                        obj =
                            {
                                id : result.insertId
                            }
                    }catch(e){
                        utils.getError(e.message)
                    }finally {
                        cb(null,obj)
                    }
                }

            }
        })
    }
}

