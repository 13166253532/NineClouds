//
//  Accountinfo.swift
//  CarRental
//
//  Created by xiejiangbo on 2017/4/26.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit
private let AccountInfo_monitoringTime:String="AccountInfo_monitoringTime"
private let AccountInfo_UserId:String="AccountInfo_UserId"


class AccountInfo: NSObject {
    var userId:String?{
        set{
            let userData:UserDefaults=UserDefaults.standard
            userData.set(newValue, forKey: AccountInfo_UserId)
        }
        get{
            let userData:UserDefaults=UserDefaults.standard
            return userData.object(forKey: AccountInfo_UserId) as? String
        }
    }
    
    var monitoringTime:String?{
        set{
            let userData:UserDefaults=UserDefaults.standard
            userData.set(newValue, forKey: AccountInfo_monitoringTime)
        }
        get{
            let userData:UserDefaults=UserDefaults.standard
            return userData.object(forKey: AccountInfo_monitoringTime) as? String
        }
    }
    class func sharedInstance()->AccountInfo {
        struct SharedStatic {
            static var instance: AccountInfo = AccountInfo()
        }
        return SharedStatic.instance
    }
    //退出登录，调用此方法，清楚所有数据
    func clearAccount(){
        AccountInfo.sharedInstance().monitoringTime = nil
        AccountInfo.sharedInstance().userId = nil
    }
    func isLogin()->Bool{
        return true
    }
    func hasNewMessage()->Bool{
        return true
    }
}
