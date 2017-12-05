//
//  BaseHttpAPI.h
//  NineClouds
//
//  Created by xiejiangbo on 2017/9/15.
//  Copyright © 2017年 yin chen. All rights reserved.
//
typedef void (^MyCallback)(id obj);


#import <Foundation/Foundation.h>

@interface BaseHttpAPI : NSObject


+(void)requestLogingWithParams:(NSMutableDictionary *)params AndCallback:(MyCallback)callback;


@end
