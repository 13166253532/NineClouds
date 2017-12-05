//
//  SMBaseHttpComplete.h
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/20.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HttpCommandProtocol.h"

@class RequestResult;


typedef void (^SMHttpUIUpdateBlock)(RequestResult *,NSObject *);

@interface SMBaseHttpComplete : NSObject<HttpCommandCompleteDelegate>
//method
-(SMBaseHttpComplete *)initWithBlock:(void(^)(RequestResult *,NSObject *userInfo))completeBlock withUserInfo:(id)userInfo;
-(void)updateUI:(RequestResult *)result;
//property
@property (copy) void (^completeBlock)(RequestResult *,NSObject *);

@end
