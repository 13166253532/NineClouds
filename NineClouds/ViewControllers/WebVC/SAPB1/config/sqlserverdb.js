/**
 * Created by lenovo on 2017/7/6.
 */
var ConnectionPool = require('tedious-connection-pool');
var Request = require('tedious').Request;
var utils  = require('../config/utils')
var config = require('../config/config');
var poolConfig = {
    min: 2,
    max: 4,
    log: false
};

var connectionConfig = {
    userName: config.mysqlsaas.user,
    password: config.mysqlsaas.password,
    server: config.mysqlsaas.host,
    options: {
        database : config.mysqlsaas.database
    }
};
module.exports = {
    outformat :  {},
    pager : function(_sql,start,end){
        _sql = _sql.replace(/select/i,'select top 100 percent ')
        _sql = " select * "+
        "   from ( "+
        "      select row_number()over(order by tempcolumn)temprownumber,* "+
        "  from (select top "+end+" tempcolumn=0,a.* from ( "+_sql+" ) a )t "+
        "  )tt "+
        "    where temprownumber> "+start

        return _sql
    },
    getConnection : function (callback) {
        getConnection(callback)
    },
    doRelease : function (pool) {
        doRelease(pool)
    },
    execute : function (pool,url,callback) {
        execute(pool,url,callback)
    }
}
var getConnection = function(callback){
    var pool = new ConnectionPool(poolConfig, connectionConfig);
    utils.log('pool',JSON.stringify(pool))
    pool.on('error',function (err) {
        callback(err,pool)
        pool.drain();
    })
    callback(null,pool)

}
var doRelease = function (pool) {
    pool.drain();
    utils.info('doRelease')
}

var execute = function (pool,url,callback) {

    var   result = []
    //acquire a connection
    pool.acquire(function (err, connection) {
        if (err) {
            callback(null,utils.toUpperArray(result))
        }

        //use the connection as normal
        var request = new Request(url, function(err, rowCount) {
            if (err) {
                callback(err,null)
            }
            //release the connection back to the pool when finished
            connection.release();
            callback(null,result)
        });

        request.on('row', function(columns)
        {
            var row = {};
            columns.forEach(function(column)
            {
                row[column.metadata.colName] = column.value;
            });
            result.push(row);
        });
        request.on('doneProc', function ( rowCount, more, rows) {
            if(!more){
                utils.info(url+'-->Success')
                result = utils.toUpperArray(result)
            }
        })

        connection.execSql(request);
    });
}