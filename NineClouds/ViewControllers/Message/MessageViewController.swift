//
//  MessageViewController.swift
//  NineClouds
//
//  Created by xiejiangbo on 2017/9/19.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class MessageViewController: BaseViewController {
    
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "MessageViewController", bundle: nil)
        let vc:MessageViewController=storyboard.instantiateViewController(withIdentifier: "MessageViewController") as! MessageViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "消息"
        
        //hideNavigationBar()
        initTitleBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
