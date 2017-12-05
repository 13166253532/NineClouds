/**
 * Created by lenovo on 2017/7/5.
 */

var utils  = require('../../config/utils')
var Connection = require('tedious').Connection;
var Request = require('tedious').Request;
var async = require('async')
var config = {
    userName: 'sa',
    password: 'Ekingwin,123',
    server: '222.187.245.149',

    // If you're on Windows Azure, you will need this:
    options: {
        connectTimeout : '2000',//连接超时
        encrypt: true
    }
};

var getConnection = function(cb){
    var connection = new Connection(config);

    connection.on('connect', function(err) {
            cb(err,connection)
        }
    );
}

var execute = function(conn,url,cb){
    // conn.beginTransaction(function (err) {
    //     if(err){
    //         utils.error(err)
    //     }
    //     console.log('beginTransaction')
    // })
    var result = []
    var  request = new Request(url, function(err, rowCount) {
        if (err) {
            utils.error(err)
            utils.info(url+'-->Error,execute')
        }
        // doRelease(conn)
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
            cb(null,utils.toUpperArray(result))
        }
    })



    conn.execSql(request);



}

var doRelease = function(connection){
    if(connection){
        connection.close()
        console.log('doRelease')
    }else{
        console.log('doRelease Error')
    }
}

getConnection(function (err, conn) {
    if(err){
        utils.error(err)
    }else{

        async.series([function (cb) {
            var _sql = "SELECT * FROM test.dbo.test_uu where id = 2"
            // var _sql = "insert into test.dbo.test_uu (name) VALUES('8888')"
            execute(conn,_sql,function (err, result) {

                if(err){
                    utils.error(err)
                }else{
                    utils.log('result',result)
                }
                cb()
            })

        },function (cb) {
            var _sql = "SELECT * FROM test.dbo.test_uu where id = 3"
            // var _sql = "insert into test.dbo.test_uu (name) VALUES('8888')"
            execute(conn,_sql,function (err, result) {

                if(err){
                    utils.error(err)
                }else{
                    utils.log('result',result)
                }
                cb()
            })

        }],function (err) {
            // doRelease(conn)
            utils.log('finish')
        })

    }




})

