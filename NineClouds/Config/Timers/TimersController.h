//
//  TimersController.h
//  CarRental
//
//  Created by xiejiangbo on 2017/7/27.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol TimersControllerDelegate <NSObject>

-(void)getIndex;
@end
@interface TimersController : NSObject
@property(nonatomic,weak)id<TimersControllerDelegate>delegate;
+ (TimersController *)ShareTimersController;
-(void)startTime;
-(void)endTimer;
@end
