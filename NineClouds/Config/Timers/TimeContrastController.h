//
//  TimeContrastController.h
//  CarRental
//
//  Created by xiejiangbo on 2017/8/4.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeContrastController : NSObject
+ (TimeContrastController *)ShareTimeContrastController;
-(NSString *)getTimeContrast:(NSString *)time;
@end
