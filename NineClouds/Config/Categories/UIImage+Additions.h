//
//  UIImage+Additions.h
//  bpm
//
//  Created by 张 超 on 12/29/13.
//  Copyright 2013 iknowapp studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIImage (Additions)

- (UIImage *)resizableImageWithOffsetTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;

- (UIImage *)getScaledImage:(CGFloat) fscale;

+ (UIImage *)imageWithUIView:(UIView *)view;

@end
