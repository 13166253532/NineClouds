function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null)return unescape(r[2]);
    return null;
}
var userid = GetQueryString("userid");
// alert(navigator.userAgent)
$(document).ready(function (){
    if (window.AndroidWebView) {
        $(".iosStyle").hide();
    }
    else if (window.webkit.messageHandlers) {
        $(".iosStyle").show();
        $(".page-group").css("padding-top","20px");
    }
})