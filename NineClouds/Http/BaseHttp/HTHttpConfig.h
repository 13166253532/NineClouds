//
//  HTHttpConfig.h
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/20.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "HttpConfig.h"
static NSString *HIHttpVersion_v1 = @"HIHttpVersion_v1";
@interface HTHttpConfig : HttpConfig
+(HTHttpConfig *)sharedInstance;
+(NSString *)registerKey;
@property BOOL isout;
@end
