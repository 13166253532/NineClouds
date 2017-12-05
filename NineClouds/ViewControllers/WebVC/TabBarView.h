//
//  TabBarView.h
//  CarRental
//
//  Created by xiejiangbo on 2017/5/16.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabBarViewDelegate <NSObject>

-(void)getIndex:(int)index;
@end

@interface TabBarView : NSObject
@property(nonatomic,weak)id<TabBarViewDelegate>delegate;
+ (TabBarView *)ShareTabBarView;
-(UIImageView *)addInitView:(UIImageView *)bagImageView;
-(void)initAllView;
-(void)oneAction;
-(void)twoAction;
-(void)thrAction;
-(void)forAction;
-(void)fiveAction;

@end
