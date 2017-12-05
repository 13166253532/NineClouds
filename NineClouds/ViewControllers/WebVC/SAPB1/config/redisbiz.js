/**
 * Created by xudp on 2017/1/2.
 */
var redis   = require('redis');
var utils = require('./utils')
var config = require('../config/config')
var async = require('async')
module.exports= {
    getClient : function(callback){
        getClient(callback)
    },
    doRelease : function(client){
        doRelease(client)
    },
    setStr : function(client,key,value,callback){
        local.setStr(client,key,value,callback)
    },
    getStr : function(client,key,callback){
        local.getStr(client,key,callback)
    }
    ,
    setObj : function(client,key,obj,callback){
        local.setObj(client,key,obj,callback)
    },
    getObj : function(client,key,objkey,callback){
        local.getObj(client,key,objkey,callback)
    },
    getAllObj : function(client,key,callback){
        local.getAllObj(client,key,callback)
    },
    remove :　function(client,key,callback){
      local.remove(client,key,callback)
    },
    removeObj :　function(client,key,keyObj,callback){
      local.removeObj(client,key,keyObj,callback)
    },
    setSessionUser : function(sessionid,userid,callback){
        var body  = null
        getClient(function(err,client){
            async.series([function(cb){
                if(err){
                    cb(utils.getError('创建sessionid失败!'))
                }else{
                    cb()
                }
            },function(cb){
                var obj = {}
                obj[sessionid] = userid
                local.setObj(client,'user_test',obj,function(err,result){
                    if(err){
                        cb(utils.getError('创建sessionid失败!'))
                    }else{
                        body =  result
                        cb()
                    }
                })
            }],function(err){
                doRelease(client)
                callback(err,body)
            })
        })
    },
    getSessionUser : function(sessionid,callback){
        var body  = null
        getClient(function(err,client){
            async.series([function(cb){
                if(err){
                    cb(utils.getError('获取sessionid失败!'))
                }else{
                    cb()
                }
            },function(cb){
                local.getObj(client,'user_test',sessionid,function(err,result){
                    if(err){
                        cb(utils.getError('获取sessionid失败!'))
                    }else{
                        body =  result
                        cb()
                    }
                })
            }],function(err){
                doRelease(client)
                callback(err,body)
            })
        })
    },
    removeSessionUser : function(sessionid,callback){
        var body  = null
        getClient(function(err,client){
            async.series([function(cb){
                if(err){
                    utils.info('1111')
                    utils.error(err)
                    cb(utils.getError('删除sessionid失败!'))
                }else{
                    cb()
                }
            },function(cb){
                local.removeObj(client,'user',sessionid,function(err,result){
                    if(err){
                        utils.info('2222')
                        utils.error(err)
                        cb(utils.getError('删除sessionid失败!'))
                    }else{
                        body =  result
                        cb()
                    }
                })
            }],function(err){
                doRelease(client)
                callback(err,body)
            })
        })
    }
}

var getClient = function(callback){
    var client  = redis.createClient(config.redis.port,config.redis.host);

    var err = null
    if(!client){
        err = utils.getError('获取Redis连接失败!')
    }
    callback(err,client)
}

var doRelease = function(client){
    if(client){
        utils.info('Redis release Success!')
        client.end(true)
    }else{
        utils.info('client is null. Redis release Error!')
    }
}

var setStr = function(db,client,key,value,callback){
    client.select(db, function(error){
        if(error) {
            console.log(error);
        } else {
            // set
            client.set(key, value, function(error, res) {
                callback(error,res)
            });
        }
    });
}

var getStr = function(db,client,key,callback){
    client.select(db, function(error){
        if(error) {
            console.log(error);
        } else {
            // get
            client.get(key, function(error, res){
                callback(error,res)
            });
        }
    });
}


var setObj = function(db,client,key,obj,callback){
    client.select(db, function(error){
        if(error) {
            console.log(error);
        } else {
            // set
            client.hmset(key, obj, function(error, res) {
                callback(error,res)
            });
        }
    });
}

var getObj = function(db,client,key,objkey,callback){
    client.select(db, function(error){
        if(error) {
            console.log(error);
        } else {
            // get
            client.hmget(key,objkey,function(error, res){
                callback(error,res)
            });
        }
    });
}

var getAllObj = function(db,client,key,callback){
    client.select(db, function(error){
        if(error) {
            console.log(error);
        } else {
            // get
            client.hgetall(key,function(error, res){
                callback(error,res)
            });
        }
    });
}

var remove =  function(db,client,key,callback){
    client.select(db, function(error){
        if(error) {
            console.log(error);
        } else {
            // get
            client.del(key,function(error, res){
                callback(error,res)
            });
        }
    });
}
var removeObj =  function(db,client,key,objkey,callback){
    client.select(db, function(error){
        if(error) {
            console.log(error);
        } else {
            // get
            client.hdel(key,objkey,function(error, res){
                callback(error,res)
            });
        }
    });
}

var local = {
    setStr : function(client,key,value,callback){
        setStr(config.currentC,client,key,value,callback)
    },
    getStr : function(client,key,callback){
        getStr(config.currentC,client,key,callback)
    },
    setObj : function(client,key,obj,callback){
        setObj(config.currentC,client,key,obj,callback)
    },
    getObj : function(client,key,objkey,callback){
        getObj(config.currentC,client,key,objkey,callback)
    },
    getAllObj :function(client,key,callback){
        getAllObj(config.currentC,client,key,callback)
    },
    remove :function(client,key,callback){
        remove(config.currentC,client,key,callback)
    },
    removeObj :function(client,key,objKey,callback){
        removeObj(config.currentC,client,key,objKey,callback)
    }
}