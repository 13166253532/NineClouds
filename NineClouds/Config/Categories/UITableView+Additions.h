//
//  UITableView+Additions.h
//  bpm
//
//  Created by 张 超 on 12/29/13.
//  Copyright 2013 iknowapp studios. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    ZGScrollViewStyleDefault = 0,
    ZGScrollViewStyleCutOffAtMax,
    ZGScrollViewStyleStickToTheTop = 10
};

typedef NSUInteger ZGScrollViewStyle;

@interface UITableView (ZGParallelView)

- (void)addParallelViewWithUIView:(UIView *)aViewToAdd;
- (void)addParallelViewWithUIView:(UIView *)aViewToAdd withDisplayRadio:(CGFloat )displayRadio;
- (void)addParallelViewWithUIView:(UIView *)aViewToAdd withDisplayRadio:(CGFloat )displayRadio cutOffAtMax:(BOOL)cutOffAtMax DEPRECATED_ATTRIBUTE;
- (void)addParallelViewWithUIView:(UIView *)aViewToAdd withDisplayRadio:(CGFloat )displayRadio headerViewStyle:(ZGScrollViewStyle )style;

- (void)updateParallelViewWithOffset:(CGPoint)contentOffset;

@end
