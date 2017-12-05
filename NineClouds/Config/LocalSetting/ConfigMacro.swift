//
//  ConfigMacro.swift
//  CarRental
//
//  Created by xiejiangbo on 2017/4/25.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

// RGBA的颜色设置
func kRGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func UIColorFromRGB(rgbValue:UInt)->UIColor {
    return UIColor(red: ((CGFloat)((rgbValue&0xFF0000)>>16))/255.0, green: ((CGFloat)((rgbValue&0xFF00)>>8))/255.0, blue: ((CGFloat)(rgbValue&0xFF))/255.0, alpha: 1.0)
}

func SCREEN_WHIDTH()->CGFloat{
    return UIScreen.main.bounds.size.width
}

func SCREEN_HEIGHT()->CGFloat{
    
    return UIScreen.main.bounds.size.height
}
func WHIDTH_RATIO()->CGFloat{
    return UIScreen.main.bounds.size.width/375
}
func HEIGHT_RATIO()->CGFloat{
    return UIScreen.main.bounds.size.height/667
}
func showAlert(title:String,message:String,titleCancelBtn:String,titleSecondBtn:String,blockOtherBtn:@escaping selectBlock){
    let alertController = UIAlertController(title: title,
                                            message: message, preferredStyle: .alert)
    
    let cancelAction = UIAlertAction(title: titleCancelBtn, style: .cancel, handler: nil)
    let okAction = UIAlertAction(title: titleSecondBtn, style: .default,
                                 handler: {
                                    action in
                                    blockOtherBtn()
    })
    
    alertController.addAction(cancelAction)
    alertController.addAction(okAction)
    AppRootViewController()!.present(alertController, animated: true, completion: nil)
    
}
func AppRootViewController() -> UIViewController? {
    var topVC = UIApplication.shared.keyWindow?.rootViewController
    while topVC?.presentedViewController != nil {
        topVC = topVC?.presentedViewController
    }
    return topVC
}

