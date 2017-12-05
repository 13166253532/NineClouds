/**
 * Created by lenovo on 2017/6/11.
 */
var array_utils = require('./utils-array')
var XLSX = require("xlsx");

module.exports = {
    /**
     * 获取excel原始信息
     * @param path  文件路径
     */
    info : function(path){
        return _info(path)
    },
    /**
     * 格式化excel原始信息
     * @param path  文件路径
     */
    formate_info : function (path) {
        return info_formate_info(path).formate
    },
    info_formate_info : function (path) {
        return info_formate_info(path)
    }

}

var _info = function(path) {
    var k = XLSX.readFile(path, {type: 'base64'});
    var result = {}
    k.SheetNames.forEach(function(sheetName) {
        var worksheet = k.Sheets[sheetName];
        result[sheetName] = XLSX.utils.sheet_to_json(worksheet);
    });
    return result
}

var info_formate_info = function(path){
    var info = _info(path)
    var result = {}
    for(var value in info){
        result[value] = {}
    }
    for(var key_info in info ){
        var array = info[key_info]
        if(array_utils.isArray(array) || array.length>0){
            var keys_array = Object.keys(array[0])
            var obj  = {}
            for(var value of keys_array){
                obj[value] = []
            }
            for( var key in obj ){
                var subject_clone = JSON.parse(JSON.stringify(array))
                subject_clone.filter( (v)=>{
                    for(var k in v){
                        if(k!=key){
                            delete v[k]
                        }
                    }
                    return v;
                })
                var subject_key_value = Array.from(array_utils.arrayQC(subject_clone),v => v[key] )
                var obA = []
                for(var v of subject_key_value){
                    var obk = {
                        id : null,
                        v : v
                    }
                    for(var ke in keys_array){
                        var thisIndex = keys_array.findIndex(x=>x==keys_array[ke])
                        var currentIndex = keys_array.findIndex(x=>x==key)
                        if( thisIndex < currentIndex){
                            try {
                                var thisObj = array.find(x=>x[ key ] == v )
                                obk[keys_array[ke]] = thisObj[ keys_array[ke] ]
                            }catch (e){
                                console.error(e)
                            }
                        }
                    }

                    obA.push(obk)
                }
                obj[key] = obA
            }
            result[key_info]= obj
        }
    }
    return {
        info : info,
        formate : result
    }
}