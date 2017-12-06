//
//  AppDelegate.swift
//  NineClouds
//
//  Created by xiejiangbo on 2017/9/11.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var uploader = IFlyDataUploader()
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //UIApplication.shared.statusBarStyle = .lightContent
        addIFly()
        HTHttpConfig.sharedInstance().isout = false
        ProjectConfigGroup.initHttpConfig()
        gotuMDFGuideViewController()
        return true
    }
    func addIFly(){
        IFlySetting.setLogFile(.LVL_ALL)
        IFlySetting.showLogcat(true)
        let paths:NSArray = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as NSArray
        let cachePath:String = paths.object(at: 0) as! String
        IFlySetting.setLogFilePath(cachePath)
        let initString:NSString = NSString.init(format: "appid=%@", "5a25fb32")
        IFlySpeechUtility.createUtility(initString as String!)
        let iFlyUserWords:IFlyUserWords = IFlyUserWords.init(json: "{\"userword\":[{\"name\":\"iflytek\",\"words\":[\"目标\",\"预测\",\"纯销\",\"\",\"预策\",\"切换与目标比进度\",\"切换与预测比进度\",\"切换考核\"，,\"切换纯销\",\"商业\",\"纯销预测\",\"考核预测\",\"日程\",\"打开\",\"上海\",\"控股\",\"药品部\",\"新药部\",\"上药\",\"打开考核一侧\"]}]}")
        uploader.setParameter("iat", forKey: "sub")
        uploader.setParameter("userword", forKey: "dtt")
        uploader.uploadData(completionHandler: nil ,name: "userwords", data: iFlyUserWords.toString())
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        IFlySpeechUtility.getUtility().handleOpen(url)
        return true
    }
    func onUploadFinished(error:IFlySpeechError) {
        print("erry.errorCode"+String(error.errorCode))
        if error.errorCode == 0 {
            print("____________****上传成功")
        }else{
            print("____________****上传shinai:"+String(error.errorCode))
        }
        
    }
    
    func gotuMDFGuideViewController(){
        if (!(UserDefaults.standard.bool(forKey: "everLaunched"))) {
            UserDefaults.standard.set(true, forKey:"everLaunched")
            let guideViewController = MDFGuideViewController()
            self.window!.rootViewController=guideViewController;
            print("guideview launched!")
        }else{
            gotoTabBar()
        }
    }
    func gotoTabBar() {
        let vc:NCLoginViewController=NCLoginViewController.createViewController(createArgs: nil) as! NCLoginViewController
        let nav = UINavigationController.init(rootViewController: vc)
        self.window?.rootViewController = nav
    }
    func gotoWebVC() {
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

