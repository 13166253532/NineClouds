//
//  BaseConfigFounction.swift
//  BaseDemo
//
//  Created by xjb on 2017/1/22.
//  Copyright © 2017年 xjb. All rights reserved.
//

import UIKit

/**
 从tableView缓存中取出对应类型的Cell
 如果缓存中没有，则重新创建一个
 
 - parameter tableView: tableView
 - parameter cell:      要返回的Cell类型
 - parameter indexPath: 位置
 
 - returns: 传入Cell类型的 实例对象
 */
func getCell<T: UITableViewCell>(_ tableView:UITableView ,cell: T.Type ,indexPath:IndexPath) -> T {
    return tableView.dequeueReusableCell(withIdentifier: "\(cell)", for: indexPath) as! T ;
}

func getCollectionViewCell<T: UICollectionViewCell>(_ collectionView:UICollectionView ,cell: T.Type ,indexPath:IndexPath) -> T {
    
    return collectionView.dequeueReusableCell(withReuseIdentifier: "\(cell)", for: indexPath) as! T ;
}

func registerCollectinViewCell<T: UICollectionViewCell>(_ collectionView:UICollectionView,cell:T.Type){
    collectionView .register(UINib.init(nibName: "\(cell)", bundle: nil), forCellWithReuseIdentifier: "\(cell)")
}

func registerCell<T: UITableViewCell>(_ tableView:UITableView,cell:T.Type){
    tableView .register(UINib.init(nibName: "\(cell)", bundle: nil), forCellReuseIdentifier: "\(cell)")
}

func swiftClassFromString(_ className: String) -> AnyClass! {
    //method1
    //方法 NSClassFromString 在Swift中已经不起作用了no effect，需要适当更改
    //let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName")
    if  let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") {
        let  aaa:String = appName as! String
        let classStringName = "_TtC\(aaa.utf16.count)\(aaa)\(className.characters.count)\(className)"
        
        
        //let classStringName = "_TtC\(appName?.characters.count))\(appName!)\(className.characters.count))\(className)"
        let  cls: AnyClass? = NSClassFromString(classStringName)
        assert(cls != nil, "class not found,please check className")
        return cls
        
    }
    return nil;
}
//隐藏多余线
func setExtraCellLineHidden(tableView:UITableView){
    let view:UIView=UIView.init()
    view.backgroundColor=UIColor.clear
    tableView.tableFooterView=view
    tableView.tableHeaderView=view
}
//MARK: - 获取字符长度
func getTextRectSize(text:NSString,font:UIFont,size:CGSize) -> CGRect {
    let attributes = [NSFontAttributeName: font]
    let option = NSStringDrawingOptions.usesLineFragmentOrigin
    let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
    
    //        println("rect:\(rect)");
    
    return rect;
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


func showAlertRefresh(title:String,message:String,titleCancelBtn:String,titleSecondBtn:String, blockCancelBtn:@escaping selectBlock,blockSureBtn:@escaping selectBlock){
    let alertController = UIAlertController(title: title,
                                            message: message, preferredStyle: .alert)
    
    let cancelAction = UIAlertAction(title: titleCancelBtn, style: .cancel, handler: {
        action in
        blockCancelBtn()
    })
    let okAction = UIAlertAction(title: titleSecondBtn, style: .default,
                                 handler: {
                                    action in
                                    blockSureBtn()
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




