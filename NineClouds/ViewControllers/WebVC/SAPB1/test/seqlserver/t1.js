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

var connection = new Connection(config);

connection.on('connect', function(err) {
        // If no error, then good to go...
        if(err){
            utils.log(123113123)
            utils.error(err)
        }else{
            utils.log('success')
            var result = []
           var  request = new Request("SELECT * FROM test.dbo.test_uu", function(err, rowCount) {
                if (err) {
                    console.log(err);
                } else {
                    console.log(rowCount + ' result');
                }
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
                utils.log('result',result)
            })
            connection.execSql(request);

        }
    }
);
connection.on('error',function () {
    utils.log('EERRRIIIR')
})