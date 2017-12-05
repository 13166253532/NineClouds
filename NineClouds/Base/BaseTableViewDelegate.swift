//
//  BaseTableViewDelegate.swift
//  CarRental
//
//  Created by xiejiangbo on 2017/4/25.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

class BaseTableViewDelegate: NSObject ,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate{
    @available(iOS 2.0, *)
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let arr=self.dataSource[indexPath.section] as! NSMutableArray
        let info:BaseCellModel=arr.object(at: indexPath.row) as! BaseCellModel
        let cellClass=swiftClassFromString(info.className) as! BaseTableViewCell.Type
        let cell=getCell(tableView, cell: cellClass.self, indexPath: indexPath)
        cell.configurateTheCell(info)
        return cell
    }
    var dataSource:NSMutableArray!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let arr=self.dataSource[section] as! NSMutableArray
        return arr.count
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section==0){
            return 15
        }
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { //ios8
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset))
        {
            cell.separatorInset = UIEdgeInsets.zero
            tableView.separatorInset = UIEdgeInsets.zero //cell.separatorInset.left = 5
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)){
            cell.layoutMargins = UIEdgeInsets.zero
            tableView.layoutMargins = UIEdgeInsets.zero //cell.separatorInset.left = 5
        }
    }
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        //view.backgroundColor = UIColor.clear
        //view.backgroundColor = UIColor.clear
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //view.tintColor = UIColor.clear
    }

}
class BaseOneTableViewDelegate: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    var dataSource:NSMutableArray!
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableViewSectionZero(tableView: tableView, cellForRowAtIndexPath: indexPath as NSIndexPath)
    }
    
    func tableViewSectionZero(tableView:UITableView,cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell{
        
        let info:BaseCellModel = self.dataSource.object(at: indexPath.row) as! BaseCellModel
        let cellClass = swiftClassFromString(info.className) as! BaseTableViewCell.Type
        let cell = getCell(tableView, cell: cellClass.self, indexPath: indexPath as IndexPath)
        cell.configurateTheCell(info)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if (section==0){
            return 15
        }
        return 10
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
  
//        func tableView(tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
//            view.backgroundColor = UIColor.clearColor()
//        }
//        func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//            view.tintColor=UIColor.clearColor()
//        }
    
}
