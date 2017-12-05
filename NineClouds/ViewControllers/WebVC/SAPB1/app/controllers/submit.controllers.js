/**
 * Created by nongzhizhong on 2017/1/4.
 */
var utils = require('../../config/utils')
var sql = require('../../config/sql')
var submitM = require('../modules/submit.modules')
var async = require('async')
module.exports = {
    submit: function (req, res, next) {
        var DocEntry = req.query.docEntry;//单据号
        var OrderType = req.query.orderType;//单据类型，pur,sal,pay
        var UserID = req.query.userID;//d当前登录人
        var Approval = req.query.approvals;//审批结果，通过/不通过
        var companyId = req.query.companyId;
       // console.log('Approval',Approval)
       /* if('同意'==Approval){
            Approval='Y'
        }else {
            Approval ='N'
        }*/
        var ApprovalMemo = req.query.approvalMemo.toString();//审批意见
        console.log(ApprovalMemo)
        if(utils.isEmpty(DocEntry) || utils.isEmpty(OrderType) || utils.isEmpty(UserID)|| utils.isEmpty(Approval) ||utils.isEmpty(companyId) ){
            return next(  utils.getError(utils.errmsg.ms1)  )
        }
        sql.getConnection(function (err,conn) {
            //console.log("conn",conn)
            if(err){
                return next(err)
            }
            submitM.submit(conn,DocEntry,OrderType,UserID,Approval,ApprovalMemo,companyId ,function () {
                sql.resSuccess(res,[],conn);

            })
        })
        //保存到已办列表
        /*  submitM.submitSave(conn,DocEntry,OrderType,function (err) {
         if(err){
         sql.doRelease(conn)
         return next(err)
         }else{
         sql.resSuccess(res,[],conn)
         }
         })*/
        //保存到已办详情表
       /* submitM.submitSaveDetail(conn,DocEntry,OrderType,function (err) {
            if(err){
                sql.doRelease(conn)
                return next(err)
            }else{
                sql.resSuccess(res,[],conn)
            }
        })*/
    },
}