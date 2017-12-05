/**
 * Created by air on 2016/5/3.
 */
var express = require('express');
var bodyParser = require ('body-parser');
var path = require('path');
var config = require('./config')
var utils = require('./utils')
var sql = require('./sql')

var fs = require('fs')


module.exports = function(){
    console.log('int express ....');
    var app = express();

    app.use(bodyParser.json({limit: '50mb'}));
    app.use(bodyParser.urlencoded({limit: '50mb', extended: true}));



    app.use(express.static("./public"));

    if(config.openlogs){
        app.use(function(req,res,next){
            var content = {}
            if(req.method == 'GET'){
                content  = req.query
            }else{
                content  = req.body
            }
            try{
                console.log(' \n请求url\n',req.url)
                console.log(' \n请求参数\n',JSON.stringify(content))
            }catch (e){
                console.error(e)
            }

            return next()
        })
    }
    app.all('*', function(req, res, next) {
        res.header("Access-Control-Allow-Origin", "*");
        res.header("Access-Control-Allow-Headers", "Content-Type,Content-Length, Authorization, Accept,X-Requested-With");
        res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");
        res.header("X-Powered-By",' 3.2.1')
        if(req.method=="OPTIONS") res.send(200);
        else next();
    });
    require('../app/routes/test.routes')(app);

    require('../app/routes/login.routes')(app);

    require('../app/routes/todo.routes')(app);

    require('../app/routes/details.routes')(app);

    require('../app/routes/submit.routes')(app);

    require('../app/routes/doneDetail.routes')(app);

    require('../app/routes/doneTodo.routes')(app);

    app.use(function(req,res){
        res.status(401);
        try {
            return res.json('Not Found');
        }catch (e){
            console.log('404 set header after sent');
        }
    });


    app.use(function(err,req,res,next){
        if(!err){
            return next()
        }
        res.status(200);
        try {
            return res.json({
                    code : 500,
                    message: err.message || 'server error'
                }
            );
        }catch (e){
            console.log('500 ser header after sent');
        }
    });


    return app;
};


