//
//  NCLoginViewController.swift
//  NineClouds
//
//  Created by xiejiangbo on 2017/9/13.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class NCLoginViewController: BaseViewController,UITextFieldDelegate,UIAlertViewDelegate {
    
    var backgroundImageView:UIImageView!
    var headTitleImage:UIImageView!
    var subHeadTitleImage:UIImageView!
    var headBAGImage:UIImageView!
    var headImage:UIImageView!
    var titleLabel:UILabel!//智慧采购直通车
    
    
    var textViewImage:UIImageView!
    var textViewLineImage:UIImageView!
    var accountViewImage:UIImageView!
    var passViewImage:UIImageView!
    var userTextView:UITextField!
    var passTextView:UITextField!
    var buttonRemeberPassword:UIButton!
    var labelRemeberPassword:UILabel!
    var buttonAutoLogin:UIButton!
    var labelAutoLogin:UILabel!
    var loginButton:UIButton!
    var hud:MBProgressHUD!
    
    
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "NCLoginViewController", bundle: nil)
        let vc:NCLoginViewController=storyboard.instantiateViewController(withIdentifier: "NCLoginViewController") as! NCLoginViewController
        vc.createArgs=createArgs
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hud = MBProgressHUD.init()
        self.view .addSubview(hud)
        hud.mode = MBProgressHUDModeText
        
        self.hideNavigationBar()
        addInitBackgroundImageView()
        addInitHeadTitleView()
        addInitHeadImageView()
        addInitTextView()
        addMemoryView()
        addInitLoginButton()
        // Do any additional setup after loading the view.
    }
    func addInitBackgroundImageView(){
        print(ModelJudgeFunc.deviceModelName())
        backgroundImageView = UIImageView.init(frame: self.view.frame)
        backgroundImageView.image = UIImage.init(named: "backgroundImage")
        backgroundImageView.backgroundColor = viewBagColor
        self.view .addSubview(backgroundImageView)
    }
    func addInitHeadTitleView(){
        headTitleImage = UIImageView.init(frame: CGRect(x:0, y: HEIGHT_RATIO()*60, width:SCREEN_WHIDTH() , height:WHIDTH_RATIO()*100 ))
        headTitleImage.image = UIImage.init(named: "headTitle_image")
        headTitleImage.contentMode = .scaleAspectFit
        headTitleImage.centerX = SCREEN_WHIDTH()/2
        self.view .addSubview(headTitleImage)
        subHeadTitleImage = UIImageView.init(frame: CGRect(x:0, y: headTitleImage.originY+WHIDTH_RATIO()*65, width:SCREEN_WHIDTH() , height:WHIDTH_RATIO()*20 ))
        //subHeadTitleImage.image = UIImage.init(named: "headSubTitle_image")
        subHeadTitleImage.contentMode = .scaleAspectFit
        subHeadTitleImage.centerX = SCREEN_WHIDTH()/2
        self.view .addSubview(subHeadTitleImage)
    }
    func addInitHeadImageView(){
        titleLabel = UILabel.init(frame: CGRect(x:0, y: headTitleImage.originY+headTitleImage.height+HEIGHT_RATIO()*15, width:SCREEN_WHIDTH() , height:WHIDTH_RATIO()*70 ))
        titleLabel.text = "智慧采购直通车"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
//        headBAGImage.contentMode = .scaleAspectFit
//        headBAGImage.image = UIImage.init(named: "headBAG_image")
        titleLabel.centerX = SCREEN_WHIDTH()/2
        titleLabel.textAlignment = .center
        self.view .addSubview(titleLabel)
//        headImage = UIImageView.init(frame: CGRect(x:0, y: headTitleImage.originY+headTitleImage.height+WHIDTH_RATIO()*25, width:WHIDTH_RATIO()*60 , height:WHIDTH_RATIO()*60 ))
//        headImage.layer.masksToBounds = true
//        headImage.layer.cornerRadius = headImage.height/2
//        headImage.image = UIImage.init(named: "head_image")
//        headImage.center = headBAGImage.center
//        self.view .addSubview(headImage)
    }
    func addInitTextView(){
        textViewImage = UIImageView.init(frame: CGRect(x:15*WHIDTH_RATIO(), y: titleLabel.originY+WHIDTH_RATIO()*85, width:SCREEN_WHIDTH()-30*WHIDTH_RATIO() , height:HEIGHT_RATIO()*100 ))
        textViewImage.image = UIImage.init(named: "textView_image")
        textViewImage.centerX = SCREEN_WHIDTH()/2
        self.view .addSubview(textViewImage)
        textViewLineImage = UIImageView.init(frame: CGRect(x:13*WHIDTH_RATIO(), y: textViewImage.originY+textViewImage.height/2, width:SCREEN_WHIDTH()-26*WHIDTH_RATIO() , height:HEIGHT_RATIO()*1 ))
        textViewLineImage.image = UIImage.init(named: "textViewLine_image")
        textViewLineImage.centerX = SCREEN_WHIDTH()/2
        self.view .addSubview(textViewLineImage)
        
        accountViewImage = UIImageView.init(frame: CGRect(x:textViewImage.originX+WHIDTH_RATIO()*15, y: textViewImage.originY+WHIDTH_RATIO()*18, width:WHIDTH_RATIO()*18 , height:WHIDTH_RATIO()*18 ))
        accountViewImage.image = UIImage.init(named: "account_image")
        self.view .addSubview(accountViewImage)
        
        passViewImage = UIImageView.init(frame: CGRect(x:textViewImage.originX+WHIDTH_RATIO()*15, y: textViewLineImage.originY+WHIDTH_RATIO()*13, width:WHIDTH_RATIO()*18 , height:WHIDTH_RATIO()*18 ))
        passViewImage.image = UIImage.init(named: "pass_image")
        self.view .addSubview(passViewImage)
        
        userTextView = self.getTextField(placeholder: "请输入账号", tag: 100)
        userTextView.frame = CGRect(x:accountViewImage.originX+WHIDTH_RATIO()*25, y: textViewImage.originY+WHIDTH_RATIO()*5, width:SCREEN_WHIDTH()/3*2 , height:textViewImage.height/2-5*HEIGHT_RATIO() )
        passTextView = self.getTextField(placeholder: "请输入密码", tag: 101)
        passTextView.frame = CGRect(x:accountViewImage.originX+WHIDTH_RATIO()*25, y: textViewLineImage.originY, width:SCREEN_WHIDTH()/3*2 , height:textViewImage.height/2-5*HEIGHT_RATIO() )
        passTextView.isSecureTextEntry = true
        self.view .addSubview(userTextView)
        self.view .addSubview(passTextView)
    }
    func getTextField(placeholder:String,tag:NSInteger) -> UITextField {
        let text = UITextField.init()
        text.placeholder = placeholder
        text.tag = tag
        text.clearButtonMode = .whileEditing
        text.delegate = self
        //text.backgroundColor = UIColor.red
        return text
    }
    func addMemoryView() {
        buttonRemeberPassword = self.getUIButton()
        buttonRemeberPassword.frame = CGRect(x:textViewImage.originX+WHIDTH_RATIO()*35, y: textViewImage.originY+textViewImage.height+WHIDTH_RATIO()*10, width:WHIDTH_RATIO()*20 , height:WHIDTH_RATIO()*20)
        buttonRemeberPassword.addTarget(self, action: #selector(clileft), for: .touchUpInside)
        self.view .addSubview(buttonRemeberPassword)
        buttonAutoLogin = self.getUIButton()
        buttonAutoLogin.frame = CGRect(x:textViewImage.originX+WHIDTH_RATIO()*185, y: textViewImage.originY+textViewImage.height+WHIDTH_RATIO()*10, width:WHIDTH_RATIO()*20 , height:WHIDTH_RATIO()*20)
        buttonAutoLogin.addTarget(self, action: #selector(cliright), for: .touchUpInside)
        self.view .addSubview(buttonAutoLogin)
        
        labelRemeberPassword = self.getUILabel(str: "保存账号密码")
        labelRemeberPassword.frame = CGRect(x:buttonRemeberPassword.originX+WHIDTH_RATIO()*20, y: textViewImage.originY+textViewImage.height+WHIDTH_RATIO()*10, width:WHIDTH_RATIO()*120 , height:WHIDTH_RATIO()*20)
        self.view .addSubview(labelRemeberPassword)
        
        labelAutoLogin = self.getUILabel(str: "自动登录")
        labelAutoLogin.frame = CGRect(x:buttonAutoLogin.originX+WHIDTH_RATIO()*20, y: textViewImage.originY+textViewImage.height+WHIDTH_RATIO()*10, width:WHIDTH_RATIO()*120 , height:WHIDTH_RATIO()*20)
        self.view .addSubview(labelAutoLogin)
    }
    func getUIButton() -> UIButton{
        let btn = UIButton.init(type: .custom)
        btn.contentMode = .scaleToFill
        btn.setBackgroundImage(UIImage.init(named: "normal_image"), for: .normal)
        btn.setBackgroundImage(UIImage.init(named: "selec_image"), for: .selected)
        btn.setBackgroundImage(UIImage.init(named: "selec_image"), for: .highlighted)
        return btn
    }
    func getUILabel(str:String) -> UILabel {
        let label = UILabel.init()
        label.text = str
        label.centerY = buttonRemeberPassword.centerY
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }
    func clileft(){
        self.buttonRemeberPassword.isSelected = !self.buttonRemeberPassword.isSelected;
        if (!self.buttonRemeberPassword.isSelected) {
            self.buttonAutoLogin.isSelected = false;
        }
    }
    func cliright(){
        self.buttonAutoLogin.isSelected = !self.buttonAutoLogin.isSelected;
        self.buttonRemeberPassword.isSelected = true;
    }
    func addInitLoginButton() {
        loginButton = UIButton.init(type: .custom)
        loginButton.frame = CGRect(x:0, y: buttonRemeberPassword.originY+WHIDTH_RATIO()*80, width:SCREEN_WHIDTH()-30*WHIDTH_RATIO() , height:WHIDTH_RATIO()*35)
        loginButton.centerX = SCREEN_WHIDTH()/2
        loginButton.setBackgroundImage(UIImage.init(named: "loginBtn_image"), for: .normal)
        loginButton.setTitle("登录", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        loginButton.addTarget(self, action: #selector(onLogin), for: .touchUpInside)
        self.view .addSubview(loginButton)
    }
    func onLogin() {
        userTextView.resignFirstResponder()
        passTextView.resignFirstResponder()
//        if userTextView.text == nil || userTextView.text?.characters.count == 0 {
//            getHUDView(str: "账号不能为空")
//            return
//        }
//        if passTextView.text == nil || passTextView.text?.characters.count == 0 {
//            getHUDView(str: "密码不能为空")
//            return
//        }
//        let http = NCLoginHttp.init()
//        let dic = NSMutableDictionary()
//        dic.setValue("a3208", forKey: "userid")
//        dic.setValue("pass", forKey: "password")
//        http.requestLoging(withParams: dic)
       // let vc:WebViewController=WebViewController.createViewController(createArgs: nil) as! WebViewController
        //self.pushViewController(viewController: vc, animated: true)
        

        //getHttpProjectdetailsRequire()
        addSMAlertView()
    }
    func addSMAlertView(){
        //SMAlertView.showAlert("1", cancelTitle: "2", delegate: self)
        SMAlertView.showAlert("1", title: "2", cancleTitle: "3", okTitle: "4", delegate: self, viewTag: 20)
    }
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if alertView.tag == 20 && buttonIndex == 0 {
            print("1")
        }else if alertView.tag == 20 && buttonIndex == 1{
            print("2")
        }
    }
    func getHUDView(str:String) {
        hud.labelText = str
        hud.show(true)
        hud.hide(true, afterDelay: 1.5)
    }
    func getHttpProjectdetailsRequire(){
        let cmd:HttpCommand = DSHttpMessageListCmd.init(version: PHttpVersion_v1)
        let block:httpBlock = {[weak self] (result:RequestResult!,useInfo:AnyObject!)->() in
            if result != nil {
                self?.httpProjectdetailsResponse(result: result)
            }else{
                print("空的")
            }
        }
        let dic:NSMutableDictionary = NSMutableDictionary()
        dic[kHttpParamKey_FollowCountNum_role] = "1"
        cmd.requestInfo = dic as [NSObject:AnyObject]
        let completeDelegate = SMBaseHttpComplete.init(block: block , withUserInfo: nil)
        cmd.requestInfo = dic as! [AnyHashable : Any]
        cmd.completeDelegate=completeDelegate
        print("url==%@",cmd.getUrl())
        cmd.execute()
    }
    func httpProjectdetailsResponse(result:RequestResult){
        let r:DSHttpMessageListResult = result as! DSHttpMessageListResult
        if r.isOk() {
            let array:NSMutableArray = r.getTheAllData()
            for index in 0..<array.count {
                let model:CompanyListInfoMode = array[index] as! CompanyListInfoMode
                print(model.org_name ?? String())
            }
        }else{
            SMToastView.showMessage(r.errMsg)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userTextView.resignFirstResponder()
        passTextView.resignFirstResponder()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
