/**
 * Created by air on 2016/7/25.
 */
var config = require('./config');
var utils = require('./utils')
var db = null;
switch (config.currentEnv){
    case 'oracle' :
        db = require('./oracledb')
        break;
    case 'mysql' :
        db = require('./mysqldb')
        break;
    case 'sqlserver' :
        db = require('./sqlserverdb')
        break;

}
var redis = require('./redisbiz')
var async = require('async')
module.exports= {

    outformat : db.outformat,
    redis : redis,
    getConnection : function(cb){
        db.getConnection(cb)
    },
    getConnectionC : function(cb){
        db.getConnectionC(cb)
    },
    getConnectionE : function(cb){
        db.getConnectionE(cb)
    },
    doRelease : function(conn){
        if(conn!=null){
            db.doRelease(conn)
        }
    },
    img : function(_sql){
        //+ config.basepath
        return  " select fn_ip_imgpath('"+config.urlpre + "',(imgi.path ) ) "+
        "  as url,imgi.id as imgid,imgt.* FROM ("+_sql+") imgt left join "+config.mysqlsaas.database+".ip_s_imgs imgi on imgt.urlid = imgi.id "
    },
    pager : function(sql,start,end){
      return db.pager(sql,start,end)
    },
    execute : function(conn,url,cb){
        db.execute(conn,url,cb)
    },
    rollback : function(conn,cb){
        utils.info('rollback')
        db.rollback(conn,cb)
    },
    executeSql : function(conn,url,callback){
        execute(conn,url,function(err,result){
            if(err){
                utils.getError(err.message)
                callback(null)
            }else {
                if(result && result.length>0 || result && (result != undefined || result != null) ){
                    callback(result)
                }else {
                    callback(null)
                }
            }
        })
    },
    executeQuery : function(conn,url,callback){
        execute(conn,url,function(err,result){
            if(err){
                utils.getError(err.message)
                callback([])
            }else {
                if(result && result.length>0  ){
                    callback(utils.toLowerArray(result))
                }else {
                    callback([])
                }
            }
        })
    },
    executeInsert : function(conn,url,callback){
        execute(conn,url,function(err,result){
            var id = -1
            if(err){
                utils.getError(err.message)
            }else {
                id = result && result.id ? result.id : -1
            }
            callback(id)
        })
    },

    resSuccess :function(res,content,conn){
        if(conn){
            db.doRelease(conn)
        }
        utils.resSuccess(res,content)
    }
    ,
    resSuccessWithMSG :function(res,content,message,conn){
        if(conn){
            db.doRelease(conn)
        }
        utils.resSuccessWithMSG(res,content,message)
    }
    ,
    udid : {
        getStatus : function(udid){
            if(!config.openudid){
                return (true)
            }else {
                db.getConnection(function(err,conn){
                    if(err){
                        utils.getError(err.message)
                        db.doRelease(conn)
                        return(false)
                    }
                    db.execute(conn,"SELECT t.STATUS FROM BAS_MOBILE_IDENTITY t WHERE t.UDID = "+to(udid)+" AND ROWNUM = 1",function(err,result){
                        if(err){
                            utils.getError(err.message)
                            db.doRelease(conn)
                            return(false)
                        }else{
                            db.doRelease(conn)
                            if(result.length>0 && result[0]['STATUS'] == 'Y'){
                                return(true)
                            }else {
                                return(false)
                            }
                        }
                    })
                })
            }
        }
    },
    to : function(data){
        //return to(data+'').replace(/'/g,"'||Chr(39)||'")
        return to(data)
    }


}
function to(data){
    var reult = null;
    if(config.currentEnv)
        switch (config.currentEnv)
        {
            case 'mysql' :
                reult = db.mysql.escape(data)
                break;
            case 'sqlserver' :
                reult = "\'"+data+"\'"
                break;
        }
    return reult
}


var execute = function(conn,url,cb){
    db.execute(conn,url,cb)
}

