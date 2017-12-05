/**
 * Created by lenovo on 2017/6/11.
 */
var underscore = require('underscore')
module.exports = {
    /**
     * 判断是否是数组
     * @param v 被判断值
     * return boolean (true:是数组,false:不是数组)
     */
    isArray : function (v) {
        return isArray(v)
    },
    /**
     * 数组去重 (解决对象数组去重问题)
     * @param array 被去重数组
     * return array (被去重后数组)
     */
    arrayQC : function (array) {
        return arrayQC(array)
    }
}

var isArray = function(array) {
    return toString.apply(array) === '[object Array]';
}

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