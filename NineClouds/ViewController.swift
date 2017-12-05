//
//  ViewController.swift
//  NineClouds
//
//  Created by xiejiangbo on 2017/9/11.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let label = UILabel.init(frame: CGRect(x:10, y: 300, width:400 , height:30 ))
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        self.view .addSubview(label)
        let sub = "如果您是VIP成员，请联系客服重置密码"
        label.attributedText = self.getNSAttributedString(str: sub)
    }
    //指定字符 指定颜色并加上下划线
    func getNSAttributedString(str:String) -> NSAttributedString {
        let myMutableString = NSMutableAttributedString(string: str)
        let range2 = NSMakeRange(12, 4)
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.green, range: range2)
        myMutableString.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleNone.rawValue, range: NSMakeRange(0, 12))
        myMutableString.addAttribute(NSUnderlineStyleAttributeName , value: NSUnderlineStyle.styleSingle.rawValue, range: range2)
        return myMutableString
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc:TestViewController=TestViewController.createViewController(createArgs: nil) as! TestViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

