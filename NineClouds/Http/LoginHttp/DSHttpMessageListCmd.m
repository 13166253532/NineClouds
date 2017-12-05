//
//  DSHttpMessageListCmd.m
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/21.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "DSHttpMessageListCmd.h"
#import "DSHttpMessageListResult.h"

static NSString *kActionUrl = @"/selectCompany";
@implementation DSHttpMessageListCmd

+(HttpCommand *)httpCommandWithVersion:(NSString *)version{
    
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpMessageListCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}
-(instancetype)initWithVersion:(NSString *)version{
    if ([version isEqualToString:PHttpVersion_v1]) {
        return [[DSHttpMessageListCmd alloc]initWithAuthorizationState:AuthorizationNull];
    }else{
        NSAssert(NO, @"Invalid version");
    }
    return nil;
}

- (instancetype)initWithAuthorizationState:(AuthorizationState)state{
    self = [super initWithAuthorizationState:state];
    if (self != nil) {
        self.result = [[DSHttpMessageListResult alloc]init];
    }
    return self;
}

- (NSString *)getActionUrl{
    return kActionUrl;
}
@end

NSString * const kHttpParamKey_FollowCountNum_role = @"role";
NSString * const kHttpParamKey_FollowCountNum_id = @"id";
