/**
 * Created by xudp on 2017/1/13.
 */


var sql = require('../../config/sql')
var utils = require('../utils')

module.exports  = {
    getUser : function(req,callback){
        sql.redis.getSessionUser(req.sessionID,function(err,result){
            if(err || !result || result.length<1 || !result[0]){
                 callback()
            }else{
                callback({
                    userid : result[0]
                })
            }
        })
    },
    setSession : function(req,user,callback){
        req.session.regenerate(function(err) {
            if(err){
                utils.getError(err.message)
                return next(utils.getError('登陆失败111111!'))
            }
            sql.redis.setSessionUser(req.sessionID,user,function(err,result){
                if(!err){
                    callback({
                        userid : user
                    })
                }else{
                    callback()
                }
            })

        });
    },
    deleteSession : function (req,res,callback){
        sql.redis.removeSessionUser(req.sessionID,function(err){
            if(!err){
                req.session.destroy(function(err) {
                    if (err) {
                        utils.getError(err.message)
                       callback()
                    }else{
                        res.clearCookie('ip');
                        callback({
                            code : 0
                        })
                    }

                })
            }else{
                utils.getError(err.message)
                callback()
            }
        })
    }
}
