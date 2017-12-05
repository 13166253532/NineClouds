//
//  ModelJudgeFunc.m
//  NineClouds
//
//  Created by xiejiangbo on 2017/11/23.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "ModelJudgeFunc.h"
#import <sys/utsname.h>
@implementation ModelJudgeFunc
+(NSString *)deviceModelName{
    struct utsname systemInfor;
    uname(&systemInfor);
    NSString *platform = [NSString stringWithCString:systemInfor.machine encoding:NSUTF8StringEncoding];
    NSLog(@"%@",platform);
    if ([platform isEqualToString:@"iPhone3,1"]) {return @"iPhone4";}
    if ([platform isEqualToString:@"iPhone3,2"]) {return @"iPhone4";}
    if ([platform isEqualToString:@"iPhone4,1"]) {return @"iPhone4S";}
    if ([platform isEqualToString:@"iPhone5,1"]) {return @"iPhone5";}
    if ([platform isEqualToString:@"iPhone5,2"]) {return @"iPhone5";}
    if ([platform isEqualToString:@"iPhone5,3"]) {return @"iPhone5C";}
    if ([platform isEqualToString:@"iPhone5,4"]) {return @"iPhone5C";}
    if ([platform isEqualToString:@"iPhone6,1"]) {return @"iPhone5S";}
    if ([platform isEqualToString:@"iPhone6,2"]) {return @"iPhone5S";}
    if ([platform isEqualToString:@"iPhone7,1"]) {return @"iPhone6 Plus";}
    if ([platform isEqualToString:@"iPhone7,2"]) {return @"iPhone6";}
    if ([platform isEqualToString:@"iPhone8,1"]) {return @"iPhone6S";}
    if ([platform isEqualToString:@"iPhone8,2"]) {return @"iPhone6S Plus";}
    if ([platform isEqualToString:@"iPhone8,4"]) {return @"iPhoneSE";}
    if ([platform isEqualToString:@"iPhone9,1"]) {return @"iPhone7";}
    if ([platform isEqualToString:@"iPhone9,2"]) {return @"iPhone7";}
    if ([platform isEqualToString:@"iPhone9,3"]) {return @"iPhone7 Plus";}
    if ([platform isEqualToString:@"iPhone9,4"]) {return @"iPhone7 Plus";}
    if ([platform isEqualToString:@"iPhone10,1"]) {return @"iPhone8";}
    if ([platform isEqualToString:@"iPhone10,2"]) {return @"iPhone8";}
    if ([platform isEqualToString:@"iPhone10,4"]) {return @"iPhone8 Plus";}
    if ([platform isEqualToString:@"iPhone10,5"]) {return @"iPhone8 Plus";}
    if ([platform isEqualToString:@"iPhone10,3"]) {return @"iPhoneX";}
    if ([platform isEqualToString:@"iPhone10,3"]) {return @"iPhoneX";}
    return platform;
}
@end













