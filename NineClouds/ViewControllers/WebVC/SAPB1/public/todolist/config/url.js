/**
 * Created by air on 2016/9/28.
 */
var murl = angular.module('murl',['config'])

murl.header = {
    get : function($resource,request){
        return $resource(request,{},{
            query: {method:'GET', params:{}, isArray:true ,header: {'Access-Control-Allow-Origin': '*'}}
        })
    },
    post : function($resource,request){
        return $resource(request,{}, {
            save: {method:'POST', params:{},header: {'Access-Control-Allow-Origin': '*'} }
        });
    },
    postQuery : function($resource,request){
        return $resource(request,{}, {
            query: {method:'POST', params:{},header: {'Access-Control-Allow-Origin': '*'} }
        });
    }
}

murl.orignite = {
      //上药移动
    t1 : '../../mock-data/t1.json',


    //
    TodoList:config.host + '/todo/selectlist',
    TodoDetail:config.host+'/selectDetail',
    TodoPostDetail:config.host+'/submit',
    GetOrganization:config.host+'/mobilechooseperson/getOrganizationPersonAsJson',
    PlusSigned:config.host+'/submit',
    TodoAlreadyService:config.host+'/done/todo/selectlist',
    TodoAlreadyDetail:config.host+'/donelist/selectDoneDetail'
}

murl.util={

    parseStr:function(obj){
        if (!obj){
            return '';
        }else {
            return obj;
        }

    },

    deleteArry:function removeByValue(arr, val) {
        for(var i=0; i<arr.length; i++) {
            if(arr[i] == val) {
                arr.splice(i, 1);
                break;
            }
        }
    }

}

Array.prototype.contains = function (element) {

    for (var i = 0; i < this.length; i++) {
        if (this[i] == element) {
            return true;
        }
    }
    return false;
}

Array.prototype.remove=function(obj){
    for(var i =0;i <this.length;i++){
        var temp = this[i];
        if(!isNaN(obj)){
            temp=i;
        }
        if(temp == obj){
            for(var j = i;j <this.length;j++){
                this[j]=this[j+1];
            }
            this.length = this.length-1;
        }
    }
}
