//
//  TestViewController.swift
//  NineClouds
//
//  Created by xiejiangbo on 2017/9/12.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class TestViewController: BaseViewController {
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "TestViewController", bundle: nil)
        let vc:TestViewController=storyboard.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
        vc.createArgs=createArgs
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNavigationBar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.displayNavigationBar()
    }
    override func viewDidDisappear(_ animated: Bool) {
        
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
