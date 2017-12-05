/**
 * Created by air on 2016/8/9.
 */
var utils = require('./utils')
var async = require('async')
var moment = require('moment')
module.exports = {
    getDocPath : function(type,name){
        return './test/'+type+'/'+name+'.json'
    },
    getUserPath : function(name){
        return '/home/admin/node/test/docs/'+name+'.json'
    },
    parseCalendar : function(start,end,callback){
        var list = []
        var startD = new utils.moment( new Date(start)).format('YYYY-MM-DD');
        var endD = new utils.moment( new Date(end)).format('YYYY-MM-DD');
        var flag = new utils.moment(new Date(startD)).add(1,'day').format('YYYY-MM-DD');
        utils.log('startD',startD)
        utils.log('endD',endD)
        list.push(new Date(startD).getTime())
        async.whilst(function(){
            return  moment(new Date(flag)).isBetween(new Date(startD), new Date(endD));
        },function(cb){
            list.push(new Date(flag).getTime())
            flag =  moment(new Date(flag)).add(1,'day').format('YYYY-MM-DD');
            cb(null)
        },function(err){
            utils.log('list',list)
            callback(list)
        })
    }
}