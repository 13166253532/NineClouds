/**
 * Created by air on 2016/5/21.
 */
var request = require('request')
var async = require('async')
var config = require('./config')
//var sql = require('./sql')
var moment = require('moment');
var underscore = require('underscore')
var objectAssign = require('object-assign');
var fs = require('fs')
var path = require('path')
var excel = require('./utils/utils-excel')
module.exports = {
    //sql : sql,
    excel : excel,
    underscore :underscore,
    contains : function(array,obj){
        var result = false
        for(var i in array){
            if(underscore.isEqual(obj,array[i])){
                return true
            }
        }
        return result
    },
    containsArr : function(array,str){
        var result = false
        for(var i in array){
            if(str.indexOf(array[i])>-1){
                return true
            }
        }
        return result
    },
    cloneArray : function(array){
        if(!isArray(array)){
            return array
        }else{
            var r = []
            for(var i in array){
                r.push(underscore.clone(array[i]))
            }
            return r
        }
    },
    formateId : function(ids){
        var idarr = ''
        for(var i = 0 ;i< ids.length; i++){
            idarr=idarr+ids[i]+","
        }
        idarr=idarr.substring(0,idarr.length-1)
        idarr="("+idarr+")"
        return idarr
    },
    arrayIndex : function(array,value){
        var r = -1
        for(var i in array){
            if(underscore.isEqual(value,array[i])){
                r = i
                break
            }
        }
        return r
    },
    formatePid_Id : function(a){
        //var b = []
        //var i = 0
        //var index= []
        //for(var k=0;k< a.length;k++ ){
        //    var z = 0
        //    for( ;z< a.length;z++){
        //        if(isEmpty(a[k].pid)  || a[k].pid == a[z].id){
        //            break
        //        }
        //    }
        //    if(z == a.length){
        //        index.push(k)
        //    }
        //}
        //a = D(a,index)
        //while (true){
        //    if(i == a.length){
        //        i=0
        //    }
        //    var aa = a[i]
        //    if( isEmpty(a[i].pid)  && !contains(b,a[i])){
        //        b.push(a[i])
        //    }
        //    for(var j = 0 ; j < b.length;j++){
        //        var bb = b[j]
        //        if(aa.pid == bb.id && !contains(b,aa)){
        //            var yy = parseInt(arrayIndex(b,bb))+1
        //            b.splice(yy,0,aa)
        //            break
        //        }
        //    }
        //    if(b.length == a.length){
        //        break
        //    }
        //    i++
        //}
        return a
    },

    //批量按下标删除数组元素,A原数组,B要删除元素的下标数组
    D : function (A,B){
        var T = []
        for(var i in A){
            var k = false
            for(var j in B){
                if(B[j]==i){
                    k = true
                }
            }
            if(!k && typeof A[i] != 'function'){
                T.push(A[i])
            }
        }
        return T
    },
    DArray : function(A,B){
        var T = []
        for(var i in A){
            var k = false
            for(var j in B){
                if(B[j]==A[i]){
                    k = true
                }
            }
            if(!k && typeof A[i] != 'function'){
                T.push(A[i])
            }
        }
        return T
    }
    ,
    //合并对象
    addObj:function(a,b){
        objectAssign(a,b);
        return a
    },
    arrayAdd : function(mergeTo,mergeFrom){
        Array.prototype.push.apply(mergeTo, mergeFrom);
        return mergeTo
    }
    ,
    moment : moment,
    compare :function compare(propertyName) {
        return function (object1, object2) {
            var value1 = object1[propertyName];
            var value2 = object2[propertyName];
            if (value2 < value1) {
                return 1;
            }
            else if (value2 > value1) {
                return -1;
            }
            else {
                return 0;
            }
        }
    },
    formatePrice : function(str) {
        var result = '0.00'
        if(str){
            str = str + ''
            if( str.indexOf('.') == -1 ){
                str = str+'.00'
            }
            result = str
        }
        return result
    },
    formate : function(data){
        if(data){
            var rdata = data
            try {
                var str =  typeof(rdata)
                if(str=='object'){
                    var date = new moment(rdata.getTime()).format('YYYY-MM-DD HH:mm:ss')
                    return date
                }else{
                    return data
                }
            }catch(e) {
                return data
            }

        }else{
            return ""
        }
    },
    log : function(tag,msg){
        if(config.openlogs){
            if(msg || msg == 0 ){
                console.log(tag+"-->",msg);
            }else{
                console.log(tag);
            }
        }
    },
    info:function(msg){
        if(config.openlogs){
            console.log(msg);
        }
    },
    error :function(error){
        if(config.openlogs){
            console.error(error.stack);
        }
    },
    getError : function(msg){
        var error = new Error(msg);
        if(config.openlogs){
            console.error(error.stack);
        }
        return error
    },

    isEmpty:function(data){
        if(data && !data == ''){
            return false
        }else{
            return true
        }

    },
    isNotEmpty:function(data){
        if(data && !data == ''){
            return true
        }else{
            return false
        }

    },
    delete_n_r : function(str){

        console.log("str",str);
        var st =  str.replace(/[\n\r]/g, "");
        var sst = st.replace('%0A','');
        console.log("%0A",sst);
        return sst;
    },
    isDateStr : function(str){
        if(!str || str == ''){
            return false
        }
        return str.match(/^(\d{1,4})(-|\/)(\d{1,2})\2(\d{1,2}) (\d{1,2}):(\d{1,2}):(\d{1,2})$/) != null;
    },
    md5_key :'NSYAWLLAWOIAH'
    ,
    sort : function (obj){
        var array  = new Array();
        for(var name in obj ){
            array.push(name);
        }
        array.sort();
        var str = "";
        for(var name in array){
            var key = array[name];
            str= str+key+"="+obj[key]+"&";
        }
        var st = str.length>0?str.substring(0,str.length-1):str
        return st;
    },
    resSuccess : function(res,content){
        res.json({
            code : 0 ,
            message : 'success',
            content : content
        });
    },
    resSuccessWithMSG : function(res,content,message){
        res.json({
            code : 0 ,
            message :message,
            content : content
        });
    },
    mkdirsSync : function(dirname) {
        if (fs.existsSync(dirname)) {
            return true;
        } else {
            if (mkdirsSync(path.dirname(dirname))) {
                fs.mkdirSync(dirname);
                return true;
            }else{
                return false
            }
        }
    },
    deleteFolder : function(path) {

        deleteFolder(path);

    },
    deleteFile: function(path){
        fs.unlinkSync(path);
    }
    ,
    doGetBase : function(url,cb){
        request(url, function (err, response, body) {
            cb(err,response,body)
        })
    },
    doGet : function(url,cb){
        console.log('url',url)
        request(url, function (err, response, body) {
            if (err){
                cb(err,null);
            }
            if(response && response.statusCode != 200){
                cb(new Error('http Error With Url='+url),null)
            }
            try {
                var obj = eval('('+body+')');
                if(!obj){
                    cb(new Error('http Error With Url='+url),null)
                }
                cb(null,obj)
            }catch (e){
                cb(e,null);
            }
        })
    },
    doPost : function(url,body,cb){
        console.log( JSON.stringify(body))
        var req = request({
            url: url,
            method: 'post',
            body: JSON.stringify(body),
            headers:{
                'Content-Type':'application/json'
            }
        }, function(err, response, body){
            if (err){
                cb(err,null);
            }
            if(response.statusCode != 200){
                cb(new Error('http Error With Url='+url),null)
            }
            try {
                var obj = eval('('+body+')');
                if(!obj){
                    cb(new Error('http Error With Url='+url),null)
                }
                cb(null,obj)
            }catch (e){
                cb(e,null);
            }
        });
    },
    sendMes : function(url,body,cb){
        console.log( JSON.stringify(body))
        var req = request({
            url: url,
            method: 'post',
            body: body.toString(),
            headers:{
                'Content-Type':'application/x-www-form-urlencoded'
            }
        }, function(err, response, body){
            if (err){
                cb(err,null);
            }
            if(response.statusCode != 200){
                cb(new Error('http Error With Url='+url),null)
            }
            try {
                var obj = eval('('+body+')');
                if(!obj){
                    cb(new Error('http Error With Url='+url),null)
                }
                cb(null,obj)
            }catch (e){
                cb(e,null);
            }
        });
    },
    doPostOpenfire : function(url,body,cb){
        console.log( JSON.stringify(body))
        var req = request({
            url: url,
            method: 'post',
            body: JSON.stringify(body),
            headers:{
                'Content-Type' :'application/json',
                'Authorization': config.openfire.secretkey
            }
        }, function(err, response, body){
            if (err){
                cb(err,null);
            }
            if(response.statusCode > 201 ){
                cb(new Error('http Error With Url='+url),null)
            }else{
                cb(null,{})
            }
        });
    },
    doGetOpenfire : function(url,cb){
        var req = request({
            url: url,
            method: 'get',
            headers:{
                'Authorization': config.openfire.secretkey,
                'Accept': 'application/json'
            }
        }, function(err, response,body){
            if (err){
                cb(err,null);
            }
            if(response.statusCode > 201 ){
                cb(new Error('http Error With Url='+url),null)
            }else{
                cb(null,body)
            }
        });
    }
    ,
    base64_decode : function (base64str,file,callback){
        var bitmap = new Buffer(base64str,'base64')
        fs.writeFile(file,bitmap,null,function(err){
            if(err){
                callback(err)
            }else{
                callback(null)
            }
        })
    }

    ,
    DDUploadImage : function(requrl,imageurl,cb){
        var formData = {
            media: {
                value: request(imageurl),
                options: {
                    filename: 'sunsapce.png',
                    contentType: 'image/png'
                }
            }
        };
        request.post({url:requrl, formData: formData}, function optionalCallback(err, httpResponse, body) {
            if (err) {
                console.error('upload failed:', err);
                cb(err,'')
            }
            cb(null,body)
            console.log('Upload successful!  Server responded with:', body);
        });
    },
    toUpper  : function(obj){
        var newobj = {}
        for(var key in obj){
            var value = obj[key];
            newobj[key.toUpperCase()] = obj[key];
        }
        return newobj
    },
    toLower : function(obj){
        var newobj = {}
        for(var key in obj ){
            var value = obj[key];
            newobj[key.toLowerCase()] = obj[key];
        }
        return newobj
    },
    toLowerArray : function(result){
        var ar = []
        if(result){
            try{
                for(var i =0;i<result.length; i++){
                    ar.push(toLower(result[i]))
                }
            }catch (e){
                console.error(e.stack)
            }
        }
        return ar
    },
    toLowerArrayNULL : function(result){
        var ar = []
        if(result){
            try{
                for(var i =0;i<result.length; i++){
                    ar.push(toLowerNUll(result[i]))
                }
            }catch (e){
                console.error(e.stack)
            }
        }
        return ar
    },
    toUpperArray : function(result){
        var ar = []
        if(result){
            try{
                for(var i=0;i<result.length; i++){
                    ar.push(toUpper(result[i]))
                }

            }catch (e){
                console.error(e.stack)
            }
        }
        return result
    },
    isArray  : function(v){
        return toString.apply(v) === '[object Array]';
    },
    errmsg : {
        ms1: "客户端请求参数有误!",
        mssql: "数据库操作有误!",
        msdatasave: "数据保存有误!",
        msdataupdate: "数据更新有误!",
        msdatadelete: "数据删除有误!",
        msdataquery: "数据查询有误!",
        msseq: "获取序列失败!",
        msdataempty: "未查询到数据!",

        buy : {
            mserror : ''
        }
    },
    getArrayMax : function(array){
        return getArrayMax(array)
    },
    getArrayMin : function(array){
        return getArrayMin(array)
    },
    filterTree : function(a){
        var T = []
        for(var i=0 ;i< a.length; i++){
            a[i].children = []
            var flag = true
            for(var j = 0 ;j< a.length ; j++ ){
                if(a[i].pid == a[j].id){
                    flag = false
                    break
                }
            }
            if(flag){
                T.push(a[i])
            }
        }
        a = DArray(a,T)
        nextFilter(a,T)
        return T
    },
    filerArrayByid:function(array,id){
        return filerArrayByid(array,id)
    },
    arrayQC : function(arr){
        return arrayQC(arr)
    },
    arrayQCByUserid : function(arr){
        return arrayQCByUserid(arr)
    },
    arrayQCById : function(arr){
        return arrayQCById(arr)
    },
    arrayQCByGoodsid : function(arr){
        return arrayQCByGoodsid(arr)
    },
    socket : {
        getUserId : function(socketid){
            var userid = '-1'
            for(var i in socketUser){
                if(socketUser[i].socket.id == socketid){
                    userid = socketUser[i].userid
                }

            }
            return  userid
        },
        getUserPostFixBySocketid : function(socketid){
            var postfix = '-1'
            for(var i in socketUser){
                if(socketUser[i].socket.id == socketid){
                    postfix = socketUser[i].postfix
                }

            }
            return  postfix
        },
        getUserNextfix : function(userid){
            var p = 0
            var  arr = []
            for(var i in socketUser){
                if(socketUser[i].userid == userid){
                    arr.push(socketUser[i].postfix)
                }
            }
            if(arr.length>0){
                p = getArrayMax(arr) + 1
            }
            return p
        },
        getSocketsByuserid : function(userid){
            var sockets = []
            for(var i in socketUser){
                if(socketUser[i].userid == userid){
                    sockets.push(socketUser[i].socket)
                }
            }
            return  sockets
        }
    },
    filterInsert : function (array) {
        return filterInsert(array)
    }
}


var findLastKey = function (obj) {
    var la = ""
    for(var i in obj){
        la = i
    }
    return la
}

var filterInsert = function (array) {
    var re = ""
    for( var i = 0 ; i < array.length;  i ++) {
        var result = "("
        var obj = array[i]
        for(var k in obj){
            result+="'"+obj[k]+"'"
            if( k!=findLastKey(obj)){
                result+=','
            }
        }
        result += ")"
        re += result
        if(i!=array.length - 1){
            re += ','
        }
    }
    return re
}


//数组去重
var arrayQC = function(arr){
    var narr = []
    for(var i = 0 ; i<arr.length ; i++){
        var notIn = true
        for(var j = 0 ; j<narr.length ; j++){
            var n1 = arr[i]
            var n2 = narr[j]
            if( underscore.isEqual(n1,n2)){
                notIn = false
                break
            }
        }
        if(notIn){
            narr.push(arr[i])
        }
    }
    return narr
}
//数组去重
var arrayQCByUserid = function(arr){
    var narr = []
    for(var i = 0 ; i<arr.length ; i++){
        var notIn = true
        for(var j = 0 ; j<narr.length ; j++){
            var n1 = arr[i]
            var n2 = narr[j]
            if( n1.userid == n2.userid){
                notIn = false
                break
            }
        }
        if(notIn){
            narr.push(arr[i])
        }
    }
    return narr
}
//数组去重
var arrayQCByGoodsid = function(arr){
    var narr = []
    for(var i = 0 ; i<arr.length ; i++){
        var notIn = true
        for(var j = 0 ; j<narr.length ; j++){
            var n1 = arr[i]
            var n2 = narr[j]
            if( n1.goodsid == n2.goodsid){
                notIn = false
                break
            }
        }
        if(notIn){
            narr.push(arr[i])
        }
    }
    return narr
}
//数组去重
var arrayQCById = function(arr){
    var narr = []
    for(var i = 0 ; i<arr.length ; i++){
        var notIn = true
        for(var j = 0 ; j<narr.length ; j++){
            var n1 = arr[i]
            var n2 = narr[j]
            if( n1.id == n2.id){
                notIn = false
                break
            }
        }
        if(notIn){
            narr.push(arr[i])
        }
    }
    return narr
}

var deleteFolder =function(path) {

    var files = [];

    if( fs.existsSync(path) ) {

        files = fs.readdirSync(path);

        files.forEach(function(file,index){

            var curPath = path + "/" + file;

            if(fs.statSync(curPath).isDirectory()) { // recurse

                deleteFolder(curPath);

            } else { // delete file

                fs.unlinkSync(curPath);

            }

        });

        fs.rmdirSync(path);

    }
}
var toLower = function(obj){
    var newobj = {}
    for(var key in obj ){
        var value = obj[key];
        newobj[key.toLowerCase()] = formate(obj[key]);
    }
    return newobj
}
var toLowerNUll = function(obj){
    var newobj = {}
    for(var key in obj ){
        var value = obj[key];
        newobj[key.toLowerCase()] = formateNULL(obj[key]);
    }
    return newobj
}
var toUpper = function(obj){
    var newobj = {}
    for(var key in obj ){
        var value = obj[key];
        newobj[key.toUpperCase()] = formate(obj[key]);
    }
    return newobj
}


var formate = function(data){
    if(data || data == 0){
        var rdata = data
        try {
            var str =  typeof(rdata)
            if(str=='object'){
                var date = new moment(rdata.getTime()).format('YYYY-MM-DD HH:mm:ss')
                return date
            }else{
                return data
            }
        }catch(e) {
            return data
        }

    }else{
        return ""
    }
}
var formateNULL = function(data){
    if(data || data == 0){
        var rdata = data
        try {
            var str =  typeof(rdata)
            if(str=='object'){
                var date = new moment(rdata.getTime()).format('YYYY-MM-DD HH:mm:ss')
                return date
            }else{
                return data
            }
        }catch(e) {
            return data
        }

    }else{
        return null
    }
}


var contains = function(array,obj){
    var result = false
    for(var i in array){
        if(underscore.isEqual(obj,array[i])){
            return true
        }
    }
    return result
}

var arrayIndex = function(array,value){
    var r = -1
    for(var i in array){
        if(underscore.isEqual(value,array[i])){
            r = i
            break
        }
    }
    return r
}


var isEmpty =function(data){
    if(data && !data == ''){
        return false
    }else{
        return true
    }

}
var arrayAdd = function(mergeTo,mergeFrom){
    Array.prototype.push.apply(mergeTo, mergeFrom);
    return mergeTo
}

var DArray = function(A,B){
    var T = []
    for(var i in A){
        var k = false
        for(var j in B){
            if(B[j]==A[i]){
                k = true
            }
        }
        if(!k && typeof A[i] != 'function'){
            T.push(A[i])
        }
    }
    return T
}
var nextFilter = function(a,T){
    for(var i=0 ;i< T.length; i++){
        var b = a.filter(function(t){
            return t.pid == T[i].id
        })
        arrayAdd(T[i].children,b)
        a = DArray(a,b)
        nextFilter(a,T[i].children)
    }
    return T
}


var filerArrayByid = function(array,id){
    Array.prototype.filterx = Array.prototype.filterx || function(func) {
            var arr = this;
            var r = [];
            for (var i = 0; i < arr.length; i++) {
                if (func(arr[i])) {
                    r.push(arr[i]);
                }
            }
            return r;
        }

    var arr = array.filter(function(t) {
        return  id != t.id;
    })
    return (arr)
}


var isArray  = function(v){
    return toString.apply(v) === '[object Array]';
}

//递归创建目录 同步方法
var mkdirsSync = function (dirname) {
    //console.log(dirname);
    if (fs.existsSync(dirname)) {
        return true;
    } else {
        if (mkdirsSync(path.dirname(dirname))) {
            fs.mkdirSync(dirname);
            return true;
        }else{
            return false
        }
    }
}

var getArrayMax = function(array){
    Array.prototype.max = function(){
        return Math.max.apply({},this)
    }
    return array.max()
}

var getArrayMin = function(array){
    Array.prototype.min = function(){
        return Math.min.apply({},this)
    }
    return array.min()
}