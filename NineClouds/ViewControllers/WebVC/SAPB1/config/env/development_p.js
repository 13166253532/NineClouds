/**
 * Created by air on 2016/4/27.
 */

var path = require('path');

var p = require('../../properties')
var port = p.port
var host = p.host


module.exports = {
    port: port,//
    currentC : p.currentC,//
    host:"http://"+host+":"+port, // "http://222.187.245.149:8691",//
    basepath : p.basepath,//
    currentEnv : p.currentEnv,//
    openlogs : true,//
    openudid : false,
    domain : p.domain,
    urlpre : p.urlpre,
    apiversion : {//
      v1 : p.apiversion.v1
    },
    jd :{//
        appkey:p.jd.appkey,//
        appsecret:p.jd.appsecret,//
        imgbase:p.jd.imgbase,//
        baseurl:p.jd.baseurl,//
        id : 1
    },
    redis : {//
        host : p.redis.host,
        port : p.redis.port
    },
    cas : {//
        test : false,
        ssoBaseURL: p.cas.ssoBaseURL,
        serverBaseURL :p.cas.serverBaseURL,
        casLoginUrl : p.cas.casLoginUrl,
        wihteList : [//CAS拦截白名单
            //'/',

            '/ip/ip/accessrestriction/view/access.html',
            '/ip/homepage.html',
            '/ip/ip/navigation/view/navigation.html',
            '/ip/saas/navigation/view/navigation.html',
            '/ip/saas/doSth/view/doSth.html',
            '/ip/su/navigation/view/navigation.html',
            '/ip/ip/shoppingControl/view/shoppingGoodsQuery.html',
            '/ip/ip/shoppingControl/view/shoppingControl.html',
            '/ip/su/homepage/view/homepage.html',
            '/ip/saas/homepage/view/homepage.html',

            '/ip/su/buyList/view/buyList.html',
            '/ip/su/shoppingControl/view/shoppingControl.html',
            '/ip/su/shoppingEntry/view/shoppingEntry.html',
            '/ip/su/shoppingQuery/view/shoppingQuery.html',
            '/ip/su/supplierput/view/supplierput.html',
            '/ip/su/supplierdetail/view/supplierdetail.html',
            '/ip/su/suppllierlist/view/suppllierlist.html',
            '/ip/su/supplier/view/supplierput.html',
            '/ip/su/shoppingEntry/view/shoppingEntry.html',
            '/ip/su/shoppingQuery/view/shoppingQuery.html',
            '/ip/su/evolves/view/evolves.html',
            '/ip/su/order/view/order.html',

            '/ip/saas/putaway/view/putaway.html',
            '/ip/saas/diagram/view/diagram.html',
            '/ip/saas/organization/view/organization.html',

           '/ip/register/homepage/view/homepage.html',
           '/ip/register/navigation/view/navigation.html',
           '/ip/su/enquiry/view/enquiry.html',
           '/ip/su/usercenter/view/usercenter.html',
           '/ip/register/reset/view/homepage.html',
           '/ip/register/reset/view/message.html',
           '/ip/su/enTails/view/enquiry.html',

           '/ip/test.html',
           '/ip/test/temletupload.html',
           '/ip/test/organ/example.html',
            '/ip/register/findpass/view/findpass.html',
           '/ip/su/user_center/view/user_center.html',
            '/ip/homepage_first/view/homepage_first.html',
            '/ip/ip/personCenter/view/personCenter.html'

        ]
    },
    user          : process.env.NODE_ORACLEDB_USER || "bas5"
    ,
    password      : process.env.NODE_ORACLEDB_PASSWORD || "bas5"
    ,
    connectString : process.env.NODE_ORACLEDB_CONNECTIONSTRING || "192.168.0.28:1521/orcl"
    ,
    mysqlobj :
    p.db.tenant
    ,
    mysqlsaas :
    p.db.saas
    ,
    myssqlobj_caiyang : {
        host : 'localhost',
        port : '3306',
        user : 'root',
        password : '111111',
        database : 'bas5_ip_caiyang',
    }
    ,
    targetDir: p.targetDir,//文件存储根路径
    headDir :p.targetDir+ 'head/',
    enterpriseDir : 'enterprise/',
    ipDir : {//
        //tmp : p.targetDir+'ip/tmp',
        //base : p.targetDir+'ip',
        //certification : p.targetDir+'ip/certification',
        //goods : p.targetDir+'ip/goods'
        tmp : p.targetDir+'file/tmp',
        base : p.targetDir+'file',
        certification : p.targetDir+'file/certification',
        goods : p.targetDir+'goods',
        templet : {
            subject : p.targetDir+'templet/subject'
        }
    },
    read: {//默认读取图片
        'default': 'default.png',
    },
    openfire : {
        secretkey : 'UniISgPmgwaH3amL',
        host : 'http://support.ekingwin.com:9090'
    }

}