/**
 * Created by xudp on 2017/1/13.
 */


var passport = require('passport')
var config = require('../../config/config')
var fs = require('fs')
passport.use(new (require('passport-cas').Strategy)({
    version: 'CAS3.0',
    ssoBaseURL: config.cas.ssoBaseURL,
    serverBaseURL: config.cas.serverBaseURL
}, function(profile, done) {
    var login = profile.user;
    utils.log('loginuuuuuser',login)
    return done(null, login);
}));
module.exports = {
    authenticate : function(req,res,next,callback){

        passport.authenticate('cas', function (err, user, info) {
            if (err) {
                return next(err);
            }
            if (!user) {
                callback()
                //req.session.messages = info.message;
                //return res.redirect('/ip/homepage.html');
            }else{
                callback({
                    userid : user
                })
            }

        })(req,res,next);
    }
}