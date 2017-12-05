//
//  TimersController.m
//  CarRental
//
//  Created by xiejiangbo on 2017/7/27.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "TimersController.h"
@interface TimersController ()
@property(nonatomic,strong)NSTimer *timer;
@end
@implementation TimersController
+ (TimersController *)ShareTimersController{
    static TimersController *tabBarView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabBarView = [[TimersController alloc]init];
        [tabBarView initAddTimer];
    });
    return tabBarView;
}
-(void)initAddTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self.delegate getIndex];
    }];
}
-(void)startTime{
    [_timer setFireDate: [NSDate distantPast]];
}
-(void)endTimer{
    [self.timer setFireDate:[NSDate distantFuture]];
}
@end
