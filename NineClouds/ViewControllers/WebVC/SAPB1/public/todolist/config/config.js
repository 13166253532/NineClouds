/**
 * Created by air on 2016/9/28.
 */
var config = angular.module('config',['env'])



var hostname = "http://222.66.127.245"
var port = ""
var servername = "/sapb1"

// var hostname = "http://10.1.225.49"
// var port = ":7001";
// var servername = "/sapb1"

    // +servername
config.host = hostname+port+servername;

