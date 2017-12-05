/**
 * Created by lenovo on 2017/7/6.
 */
var ConnectionPool = require('tedious-connection-pool');
var Request = require('tedious').Request;
var utils  = require('../../config/utils')
var async = require('async')
var poolConfig = {
    min: 2,
    max: 4,
    log: true
};

var connectionConfig = {
    userName: 'sa',
    password: 'Ekingwin,123',
    server: '222.187.245.149',
    options: {
        database : 'test'
    }
};

var getConnection = function(callback){
    var pool = new ConnectionPool(poolConfig, connectionConfig);
    utils.log('pool',JSON.stringify(pool))
    pool.on('error',function (err) {
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
               result = utils.arrayAdd(result,utils.toUpperArray(result))
            }
        })

        connection.execSql(request);
    });
}

getConnection(function (err,pool) {
    utils.info('获取连接池成功')
    var i = 0
    async .whilst(function (cb) {
        return i < 3
    },function (cb) {
        var _sql = "SELECT * FROM test_uu"
        execute(pool,_sql,function (err, result) {
            if(err){
                utils.error(err)
            }
            utils.log('rrrr'+i,result)
            i++
            cb()
        })
    },function (err) {
        doRelease(pool)
        utils.info('finish')
    })


})