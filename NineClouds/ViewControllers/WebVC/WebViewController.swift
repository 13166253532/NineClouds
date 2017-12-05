//
//  WebViewController.swift
//  NineClouds
//
//  Created by xiejiangbo on 2017/9/15.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: BaseViewController ,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler,UIGestureRecognizerDelegate,TabBarViewDelegate{
    @available(iOS 8.0, *)
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "" {
            
        }
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print(webView.url?.absoluteString ?? String())
        
    }
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
    }
    
    var webView:WKWebView!
    
    var bagImageView: UIImageView!
    var scrollView:UIScrollView!
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "WebViewController", bundle: nil)
        let vc:WebViewController=storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.createArgs=createArgs
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //addInitWebView()
        //initTitleBar()
        
        hideNavigationBar()
        initReturnBtn()
        addInitUIScrollView()
        addInitTabBar()
        
        // Do any additional setup after loading the view.
    }
    override func initReturnBtn(){
        self.navigationItem.leftBarButtonItem = self.getBtn(str:"saomiao_image" )
        self.navigationItem.rightBarButtonItems = [self.getBtn(str:"message_image" ),self.getBtn(str:"set_image" )]
        
    }
    func getBtn(str:String) -> UIBarButtonItem {
        let leftBtn = UIButton.init(type: .custom)
        leftBtn.frame = CGRect(x:0, y: 0, width:WHIDTH_RATIO()*20 , height:WHIDTH_RATIO()*20 )
        leftBtn.contentMode = .scaleAspectFill
        leftBtn.setBackgroundImage(UIImage.init(named: str), for: .normal)
        if str == "saomiao_image" {
            leftBtn .addTarget(self, action: #selector(gotoQRCodeVC), for: .touchUpInside)
        }else if str == "message_image" {
            leftBtn .addTarget(self, action: #selector(gotoMessageVC), for: .touchUpInside)
        }else if str == "set_image" {
            leftBtn .addTarget(self, action: #selector(gotoSetUp), for: .touchUpInside)
        }
        let messageItem:UIBarButtonItem = UIBarButtonItem.init(customView: leftBtn)
        messageItem.customView?.center = leftBtn.center
        return messageItem
    }
    func addInitUIScrollView() {
        self.scrollView = UIScrollView.init(frame: CGRect(x:0, y: 0, width:SCREEN_WHIDTH() , height:SCREEN_HEIGHT() ))
        self.scrollView.backgroundColor = UIColor.clear
        self.bagImageView = UIImageView.init(frame: CGRect(x:0, y: 0, width:SCREEN_WHIDTH() , height:SCREEN_HEIGHT() ))
        self.bagImageView.image = UIImage.init(named: "Home1_image")
        self.scrollView.addSubview(self.bagImageView)
        if #available(iOS 11.0, *) {
            self.scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        };
        self.view .addSubview(self.scrollView)
        
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.contentSize = CGSize(width:self.view.width,height:self.view.height+49*HEIGHT_RATIO())
        
    }
    func gotoMessageVC(){
        let vc:MessageViewController=MessageViewController.createViewController(createArgs: nil) as! MessageViewController
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoQRCodeVC(){
        let vc:QRCodeViewController=QRCodeViewController.createViewController(createArgs: nil) as! QRCodeViewController
        self.pushViewController(viewController: vc, animated: true)
    }
    func gotoSetUp() {
        let vc:SetUpViewController=SetUpViewController.createViewController(createArgs: nil) as! SetUpViewController
        self.pushViewController(viewController: vc, animated: true)
    }
    func addInitWebView(){
        let url:NSURL = Bundle.main.url(forResource: "Todo", withExtension: "html", subdirectory: "/SAPB1/public/todolist/Todo/view/")! as NSURL
        let urlStr:String = String(describing: url) + "?userid=a3208&companyId=1002"
        let url2:NSURL = NSURL.init(string: urlStr)!
        let urlRequest:NSURLRequest = NSURLRequest.init(url: url2 as URL)
        let config = WKWebViewConfiguration.init()
        config.preferences = WKPreferences.init()
        config.preferences.minimumFontSize = 10;
        config.preferences.javaScriptEnabled = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = true
        config.processPool = WKProcessPool.init()
        config.userContentController = WKUserContentController.init()
        let userContent = WKUserContentController.init()
        userContent.add(self as WKScriptMessageHandler, name: "wert")
        
        config.userContentController = userContent
        self.webView = WKWebView.init(frame: self.view.bounds, configuration: config)
        self.webView.uiDelegate = self as? WKUIDelegate
        self.webView.navigationDelegate = self as? WKNavigationDelegate
        self.webView.scrollView.isScrollEnabled = false
        self.webView.load(urlRequest as URLRequest)
        self.webView.isMultipleTouchEnabled = false
        self.webView.backgroundColor = UIColor.clear
        self.view .addSubview(self.webView)
    }
    
    func addInitTabBar(){
        var tabBar = UIImageView.init(frame: CGRect(x: 0, y: SCREEN_HEIGHT()-49*HEIGHT_RATIO(), width: SCREEN_WHIDTH(), height: 49*HEIGHT_RATIO()))
        tabBar = TabBarView.share().addInitView(tabBar)
        TabBarView.share().delegate = self
        self.view .addSubview(tabBar)
    }
    func getIndex(_ index: Int32) {
        if index == 0 {
            self.bagImageView.image = UIImage.init(named: "Home1_image")
        }else if index == 1{
            self.bagImageView.image = UIImage.init(named: "Class1_image")
        }else if index == 2{
            self.bagImageView.image = UIImage.init(named: "Car1_image")
        }else if index == 3{
            self.bagImageView.image = UIImage.init(named: "Main1_image")
        }
    }
    func getButton(){
        
        
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
