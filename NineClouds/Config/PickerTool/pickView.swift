//
//  pickView.swift
//  ImagePickerDemo
//
//  Created by 刘佳斌 on 16/8/25.
//  Copyright © 2016年 xiaosi. All rights reserved.
//

import UIKit

class pickView:NSObject,UIImagePickerControllerDelegate ,UINavigationControllerDelegate{

    var block:passParameterBlock!
    var picker:UIImagePickerController = UIImagePickerController()

    internal override init(){
        super.init()
        self.picker.delegate=self
    }

    func showLocalPhotoWithController(controller:UIViewController,block:@escaping passParameterBlock){
        
        self.block = block
        self.picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        controller.present(self.picker, animated: true, completion: nil)
    }
    
    func showTakePhotoWithController(controller:UIViewController,block:@escaping passParameterBlock){
        
        self.block = block
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            self.picker.sourceType=UIImagePickerControllerSourceType.camera
            controller.present(self.picker, animated: true, completion: nil)
        }else{
            print("不支持")
        }
    }

//    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        
//       
//    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let gotImage=info[UIImagePickerControllerOriginalImage]as! UIImage
        self.block(self.imageWithImageSimple(image: gotImage, scaledToSize: CGSize(width:600, height:600)))
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    //缩放图片
    func imageWithImageSimple(image:UIImage,scaledToSize newSize:CGSize)->UIImage
        
    {
        UIGraphicsBeginImageContext(newSize);
        image.draw(in: CGRect(x:0, y: 0, width:newSize.width , height:newSize.height ))
        let newImage:UIImage=UIGraphicsGetImageFromCurrentImageContext()!;
        UIGraphicsEndImageContext();
        return newImage;
    }

}
