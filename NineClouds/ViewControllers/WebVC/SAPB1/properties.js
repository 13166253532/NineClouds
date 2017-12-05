

//    项目路径/properties.js
var domain = "112.74.32.187"
var basepath = '/sapb1'
//var domainport = "1080"
module.exports = {
    port : 7001,
    currentC : 1,
    host : '112.74.32.187',
    basepath : basepath,
    currentEnv : 'sqlserver',
    openlogs : true,
    domain : domain,
   // domainport : domainport,
    //urlpre : "http://"+domain+":"+domainport,
    urlpre : "http://"+domain+":8692"+basepath,
    apiversion : {
        v1 : '/v1'
    },
    jd : {
        appkey:"32DD7C627B5B39FFD82DF95B6E005C57",//
        appsecret:"6cf464e817df4893a1bf6fc0461ae8e6",//
        imgbase:"http://img30.360buyimg.com/jgsq-productsoa/",//
        baseurl:"https://api.jd.com/routerjson?",//
    },
    redis : {//
        host : 'localhost',
        port : '6379',
    },
    db :{
        saas : {
            host : '196.6.27.139',
            port : '1433',
            user : 'sa',
            password : 'Password1',
            database : 'MIDDATA',
        },
        tenant : {
            host : 'rm-wz97y7l1g1dg7rq6go.mysql.rds.aliyuncs.com',
            port : '3306',
            user : 'admin_1',
            password : 'JJ_passWORD@2017',
            database : 'bas_ip',
        }
    },
    targetDir : '/home/admin/node/pics/file/',
    cas : {
        //ssoBaseURL: 'http://112.74.32.187/sso',
        //serverBaseURL: 'http://112.74.32.187:8691',
        //casLoginUrl: 'http://112.74.32.187/sso/login?service=http%3A%2F%2F112.74.32.187%3A8691%2Fip%2Fip%2Fhomepage%2Fview%2Fhomepage.html'
        // ssoBaseURL: 'http://112.74.32.187:8010/sso',
        // serverBaseURL: 'http://112.74.32.187:8010/',
        // casLoginUrl: 'http://112.74.32.187:8010/sso/login?service=http%3A%2F%2F112.74.32.187:8692%2Fip%2Fip%2Fhomepage%2Fview%2Fhomepage.html'
        ssoBaseURL: 'http://112.74.32.187:8010/sso',
        serverBaseURL: 'http://112.74.32.187:8692/',
        casLoginUrl: 'http://112.74.32.187:8010/sso/login?service=http%3A%2F%2F112.74.32.187:8692%2Fip%2Fip%2Fhomepage%2Fview%2Fhomepage.html'
    }
}