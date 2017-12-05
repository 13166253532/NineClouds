//
//  ConfigBlock.swift
//  CarRental
//
//  Created by xiejiangbo on 2017/4/25.
//  Copyright © 2017年 yin chen. All rights reserved.
//

import UIKit

typealias selectBlock = ()->()

typealias passParameterBlock = (AnyObject)->()

typealias returnParameterBlock = ()->(AnyObject)

typealias passTwoParameterBlock = (AnyObject,AnyObject)->()

typealias httpBlock = (RequestResult?,AnyObject?)->()


typealias signUpBlock = ()->(String)

typealias activityBlock = ()->(NSMutableArray)


//textView
typealias passTextViewBlock = (AnyObject?)->()
