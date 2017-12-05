//
//  QRCodeViewController.swift
//  NineClouds
//
//  Created by xiejiangbo on 2017/9/18.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit
import AVFoundation
class QRCodeViewController: BaseViewController ,AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    //AVCaptureMetadataOutputObjectsDelegate
    var device:AVCaptureDevice!//捕获设备，默认后置摄像头
    var input:AVCaptureDeviceInput!//输入设备
    var output:AVCaptureMetadataOutput!//输出设备，需要指定他的输出类型及扫描范围
    var session:AVCaptureSession!//AVFoundation框架捕获类的中心枢纽，协调输入输出设备以获得数据
    var previewLayer:AVCaptureVideoPreviewLayer!//展示捕获图像的图层，是CALayer的子类
    //相机显示视图
    let cameraView = ScannerBackgroundView(frame: UIScreen.main.bounds)
    
    
    let captureSession = AVCaptureSession()
   
    var albumBtn:UIButton!
    var barcodeBtn:UIButton!
    
    class func createViewController(createArgs:AnyObject?) ->AnyObject{
        let storyboard:UIStoryboard=UIStoryboard(name: "QRCodeViewController", bundle: nil)
        let vc:QRCodeViewController=storyboard.instantiateViewController(withIdentifier: "QRCodeViewController") as! QRCodeViewController
        vc.createArgs=createArgs
        return vc
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.scannerStart()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        hideNavigationBar()
        initTitleBar()
        addInitCameraView()
       // addInitButton()
       
        // Do any additional setup after loading the view.
    }
    func getImage() {
        selectPhotoFormPhotoLibrary()
    }
    func addInitCameraView(){
        self.view.addSubview(cameraView)
        //初始化捕捉设备（AVCaptureDevice），类型AVMdeiaTypeVideo
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let input :AVCaptureDeviceInput
        //创建媒体数据输出流
        let output = AVCaptureMetadataOutput()
        //捕捉异常
        do{
            //创建输入流
            input = try AVCaptureDeviceInput(device: captureDevice)
            //把输入流添加到会话
            captureSession.addInput(input)
            //把输出流添加到会话
            captureSession.addOutput(output)
        }catch {
            print("异常")
        }
        //创建串行队列
        let dispatchQueue = DispatchQueue(label: "queue", attributes: [])
        //设置输出流的代理
        output.setMetadataObjectsDelegate(self as AVCaptureMetadataOutputObjectsDelegate, queue: dispatchQueue)
        //设置输出媒体的数据类型
        output.metadataObjectTypes = NSArray(array: [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]) as [AnyObject]
        //创建预览图层
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        //设置预览图层的填充方式
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        //设置预览图层的frame
        videoPreviewLayer?.frame = cameraView.bounds
        //将预览图层添加到预览视图上
        cameraView.layer.insertSublayer(videoPreviewLayer!, at: 0)
        //设置扫描范围
        output.rectOfInterest = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
    }
    func scannerStart(){
        captureSession.startRunning()
        cameraView.scanning = "start"
    }
    
    func scannerStop() {
        captureSession.stopRunning()
        cameraView.scanning = "stop"
    }
    //扫描代理方法
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        print("_______")
        
        if metadataObjects != nil && metadataObjects.count > 0 {
            let metaData : AVMetadataMachineReadableCodeObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            print(metaData.stringValue)
            captureSession.stopRunning()
        }
    }
    //从相册中选择图片
    func selectPhotoFormPhotoLibrary(){
        let picture = UIImagePickerController()
        picture.sourceType = UIImagePickerControllerSourceType.photoLibrary
        picture.delegate = self
        self.present(picture, animated: true, completion: nil)
    }
    //选择相册中的图片完成，进行获取二维码信息
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage]as! UIImage
        picker.dismiss(animated: true) { [weak self] in
            self?.get(image: image)
        }
    }
    func get(image:UIImage)  {
        let str:String = GetCIQRCodeFeature.getCIQRCodeFeature(image)
        if str == nil || str.characters.count == 0 {
            SMToastView.showMessage("扫描失败！")
        }else{
            SMToastView.showMessage(str)
        }
        
    }
    func addInitButton() {
        self.barcodeBtn = self.getBtn(imageName: "barcode_image")
        self.barcodeBtn.frame = CGRect(x:(SCREEN_WHIDTH()-WHIDTH_RATIO()*50)/3, y:SCREEN_HEIGHT()-100*HEIGHT_RATIO(), width:WHIDTH_RATIO()*35 , height:HEIGHT_RATIO()*35 )
        self.barcodeBtn .addTarget(self, action: #selector(gotoBarcodeVC), for: .touchUpInside)
        
        self.albumBtn = self.getBtn(imageName: "album_image")
        self.albumBtn.frame = CGRect(x:SCREEN_WHIDTH()-(SCREEN_WHIDTH()-WHIDTH_RATIO()*50)/3, y: SCREEN_HEIGHT()-100*HEIGHT_RATIO(), width:WHIDTH_RATIO()*35 , height:HEIGHT_RATIO()*35 )
        self.albumBtn .addTarget(self, action: #selector(getImage), for: .touchUpInside)
        self.view .addSubview(self.barcodeBtn)
        self.view .addSubview(self.albumBtn)
    }
    func gotoBarcodeVC() {
        let vc:BarcodeViewController=BarcodeViewController.createViewController(createArgs: nil) as! BarcodeViewController
        self.pushViewController(viewController: vc, animated: true)
    }
    func getBtn(imageName:String) -> UIButton {
        let btn = UIButton.init(type: .custom)
        btn.setBackgroundImage(UIImage.init(named: imageName), for: .normal)
        btn.contentMode = .scaleAspectFit
        return btn
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


