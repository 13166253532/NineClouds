//
//  HttpConfigGroup.h
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/20.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HttpConfig;

@interface HttpConfigGroup : NSObject
+(HttpConfigGroup *)sharedInstance;
-(HttpConfig *)getHttpConfig:(NSString *)key;
-(void)registerHttpConfig:(NSString *)key httpConfig:(HttpConfig *)httpConfig;
+(HttpConfig *)getCurrentConfig;
+(void)setCurrentConfig:(NSString *)key;
@end
