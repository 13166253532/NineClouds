//
//  SetUpViewController.swift
//  NineClouds
//
//  Created by xiejiangbo on 2017/9/19.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class SetUpViewController: BaseViewController {
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "SetUpViewController", bundle: nil)
        let vc:SetUpViewController=storyboard.instantiateViewController(withIdentifier: "SetUpViewController") as! SetUpViewController
        vc.createArgs=createArgs
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
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
