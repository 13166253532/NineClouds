//
//  BarcodeViewController.swift
//  NineClouds
//
//  Created by xiejiangbo on 2017/9/19.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class BarcodeViewController: BaseViewController,UITextFieldDelegate {
    var textFillBagImageView:UIImageView!
    var barcodeTextField:UITextField!
    var gotoQRCodeBtn:UIButton!
    var determineBtn:UIButton!
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "BarcodeViewController", bundle: nil)
        let vc:BarcodeViewController=storyboard.instantiateViewController(withIdentifier: "BarcodeViewController") as! BarcodeViewController
        vc.createArgs=createArgs
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "条码"
        //hideNavigationBar()
        initTitleBar()
        addInitTextFillBagImageView()
        addInitBarcodeTextField()
        addInitBtn()
        // Do any additional setup after loading the view.
    }
    func addInitTextFillBagImageView(){
        textFillBagImageView = UIImageView.init(frame: CGRect(x:50*WHIDTH_RATIO(), y: 120*HEIGHT_RATIO(), width: SCREEN_WHIDTH()-100*WHIDTH_RATIO(), height:50*HEIGHT_RATIO() ))
        textFillBagImageView.image = UIImage.init(named: "textFillBag_image")
        self.view .addSubview(textFillBagImageView)
    }
    func addInitBarcodeTextField() {
        barcodeTextField = UITextField.init(frame: CGRect(x:53*WHIDTH_RATIO(), y: 120*HEIGHT_RATIO(), width: SCREEN_WHIDTH()-106*WHIDTH_RATIO(), height:50*HEIGHT_RATIO() ))
        barcodeTextField.clearButtonMode = .whileEditing
        barcodeTextField.delegate = self
        self.view .addSubview(barcodeTextField)
    }
    func addInitBtn() {
        let btnWidth:CGFloat = (SCREEN_WHIDTH()-90*WHIDTH_RATIO())/2
        let btnHeight:CGFloat = 40*WHIDTH_RATIO()
        self.gotoQRCodeBtn = self.getBtn(imageName: "gotoQRCodeBtn_image", title: "切换扫描")
        self.gotoQRCodeBtn.frame = CGRect(x:30*WHIDTH_RATIO(), y: barcodeTextField.originY+barcodeTextField.height+50*HEIGHT_RATIO(), width: btnWidth, height:btnHeight)
        self.gotoQRCodeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -25*WHIDTH_RATIO())
        self.gotoQRCodeBtn.addTarget(self, action:#selector(gotoQRCodeVC) , for: .touchUpInside)
        
        
        let saosaoImageView = UIImageView.init(frame: CGRect(x:30*WHIDTH_RATIO(), y: barcodeTextField.originY+barcodeTextField.height+50*HEIGHT_RATIO(), width: btnWidth/3, height:btnHeight/2))
        saosaoImageView.image = UIImage.init(named: "saosao_image")
        saosaoImageView.contentMode = .scaleAspectFit
        saosaoImageView.centerY = gotoQRCodeBtn.centerY
        
        self.determineBtn = self.getBtn(imageName: "determineBtn_image", title: "确定")
        self.determineBtn.frame = CGRect(x:SCREEN_WHIDTH()-btnWidth-30*WHIDTH_RATIO(), y: barcodeTextField.originY+barcodeTextField.height+50*HEIGHT_RATIO(), width: btnWidth, height:btnHeight)
        self.determineBtn.addTarget(self, action:#selector(goto) , for: .touchUpInside)
        self.view .addSubview(gotoQRCodeBtn)
        self.view .addSubview(determineBtn)
        self.view .addSubview(saosaoImageView)
    }
    func getBtn(imageName:String,title:String) -> UIButton {
        let btn = UIButton.init(type: .custom)
        btn.setTitle(title, for: .normal)
        btn.setBackgroundImage(UIImage.init(named: imageName), for: .normal)
        btn.contentMode = .scaleAspectFit
        return btn
    }
    func gotoQRCodeVC() {
        self.navigationController?.popViewController(animated: true)
    }
    func goto() {
        
    }
    //UITextFieldDelegate
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        barcodeTextField.resignFirstResponder()
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
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
