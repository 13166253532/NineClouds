//
//  DSHttpMessageListCmd.h
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/21.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "SNHttpBaseGetCmd.h"

@interface DSHttpMessageListCmd : SNHttpBaseGetCmd
+(HttpCommand *)httpCommandWithVersion:(NSString *)version;
-(instancetype)initWithVersion:(NSString *)version;

@end
extern NSString * const kHttpParamKey_FollowCountNum_role;
extern NSString * const kHttpParamKey_FollowCountNum_id;
