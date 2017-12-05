//
//  NCLoginHttp.m
//  NineClouds
//
//  Created by xiejiangbo on 2017/9/15.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "NCLoginHttp.h"

@implementation NCLoginHttp
-(void)requestLogingWithParams:(NSMutableDictionary *)dic{
    [BaseHttpAPI requestLogingWithParams:dic AndCallback:^(id obj) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSLog(@"登陆-------%@",obj[@"result"]);
            if ([obj[@"content"] isEqualToString:@"Y"]) {
               
            }else{
                
            }
        }
    }];
}


@end
