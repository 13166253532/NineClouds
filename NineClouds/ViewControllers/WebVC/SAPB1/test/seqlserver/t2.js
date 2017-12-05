/**
 * Created by lenovo on 2017/7/5.
 */

var utils  = require('../../config/utils')
var Connection = require('tedious').Connection;
var Request = require('tedious').Request;

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

    var result = []
    var  request = new Request(url, function(err, rowCount) {
        if (err) {
            utils.info(url+'-->Error,execute')
            conn.xudp = err
            // cb(err,utils.toUpperArray(result))
        }
        doRelease(conn)
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
        var _sql = "SELECT * FROM test.dbo.test_uu"
        execute(conn,_sql,function (err, result) {

            if(err){
                utils.error(err)
            }else{
                utils.log('result',result)
            }
            // doRelease(conn)
        })
    }

})

