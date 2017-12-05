//
//  BaseViewController.swift
//  CarRental
//
//  Created by xiejiangbo on 2017/4/25.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var createArgs:AnyObject!
    //var boxView:PopUpBoxView!
    deinit{
        
        print("------------------------------")
        print(NSStringFromClass(self.classForCoder)+"释放")
        print("------------------------------")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white;
        //self.navigationController!.navigationBar.barStyle = UIBarStyle.black
        //UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        //UIApplication.shared.statusBarOrientation = UIInterfaceOrientation.portrait
        let ver:Float=(UIDevice.current.systemVersion as NSString).floatValue
        if(ver>=7.0){
            self.automaticallyAdjustsScrollViewInsets=false
            UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: false)
        }
        // Do any additional setup after loading the view.
    }
    // 设置状态栏颜色
    func initSetStatusBarColor(){
        // 无需设置 plist
        //self.navigationController!.navigationBar.barStyle = UIBarStyle.black
        //需要设置 plist
        //View controller-based status bar appearance 设置为 NO
        //UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func pushViewController(viewController:UIViewController,animated:Bool){
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func arrowResponse(){
        self.navigationController?.popViewController(animated: true)
    }
    // 设置导航栏
    func initTitleBar(){
        self.view.backgroundColor = viewBagColor
        self.defaultBackButtonItem()
        self.initTitleBarColor()
        self.initReturnBtn()
    }
    //左侧返回按钮
    func initReturnBtn(){
        let leftN:UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "return_image"), style: .plain, target: self, action: #selector(arrowResponse))
        self.navigationItem.leftBarButtonItem = leftN
    }
    private func defaultBackButtonItem(){
        let barButtonItem :UIBarButtonItem=UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem=barButtonItem
        self.navigationController!.navigationBar.tintColor=UIColor.white
        //self.navigationController?.navigationBar.barTintColor=greenNavigationColor
        //self.navigationController?.navigationBar.subviews[0].backgroundColor=greenNavigationColor
    }
    private func initTitleBarColor(){
        let dict:[String:AnyObject]=[NSForegroundColorAttributeName:UIColor.white, NSFontAttributeName:UIFont.systemFont(ofSize: 17.0)]
        self.navigationController!.navigationBar.titleTextAttributes = dict
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //隐藏导航栏
    func hideNavigationBar(){
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor.clear)
    }
    func displayNavigationBar(){
        self.navigationController?.navigationBar.lt_reset()
    }
    func isTelNumber(num:String)->Bool
    {
        let mobile = "^1(7[0-9]|3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: num) == true)
            || (regextestcm.evaluate(with: num)  == true)
            || (regextestct.evaluate(with: num) == true)
            || (regextestcu.evaluate(with: num) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
    func isExpired(time:String) -> Bool {
        let dformatters = DateFormatter.init()
        dformatters.dateFormat = "yyyy-MM-dd HH:mm"
        let now = NSDate()
        //let dateString1 = "2017-07-06 13:40"
        let date1 = dformatters.date(from: time)
        //let dateString2 = "2017-07-06 13:41"
        //let date2 = dformatters.date(from: dateString2)
        
        if date1?.compare(now as Date) == ComparisonResult.orderedAscending {
            //print("date1 is earlier")
            return false
        } else if date1?.compare(now as Date) == ComparisonResult.orderedDescending {
            //print("date2 is earlier")
            return true
        } else if date1?.compare(now as Date) == ComparisonResult.orderedSame {
            //print("Same date!!!")
        }
        return true
    }
    func isStartTime(time:String) -> Bool {
        let dformatters = DateFormatter.init()
        dformatters.dateFormat = "yyyy-MM-dd HH:mm"
        let now = NSDate()
        let date1 = dformatters.date(from: time)
        if date1?.compare(now as Date) == ComparisonResult.orderedAscending {
            //print("date1 is earlier")
            return true
        } else if date1?.compare(now as Date) == ComparisonResult.orderedDescending {
            //print("date2 is earlier")
            return false
        } else if date1?.compare(now as Date) == ComparisonResult.orderedSame {
            //print("Same date!!!")
        }
        return false
    }
   

}
