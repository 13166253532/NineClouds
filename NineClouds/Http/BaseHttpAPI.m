//
//  BaseHttpAPI.m
//  NineClouds
//
//  Created by xiejiangbo on 2017/9/15.
//  Copyright © 2017年 yin chen. All rights reserved.
//

//#define kHomeBuyUrl @"10.1.225.49:7001/sapb1"//内网
#define kHomeBuyUrl @"http://222.66.127.245/sapb1"//外网

#import "BaseHttpAPI.h"

@implementation BaseHttpAPI
+(void)requestLogingWithParams:(NSMutableDictionary *)params AndCallback:(MyCallback)callback{
    NSString *path = [NSString stringWithFormat:@"%@/login/selectCompany",kHomeBuyUrl];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    [session GET: path parameters:@"" success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"dic===%@",responseObject);
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        
         NSLog(@"errr====:%@",error);
    }];
    

    
    
}



@end

























