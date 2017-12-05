//
//  UIImage+Additions.m
//  bpm
//
//  Created by 张 超 on 12/29/13.
//  Copyright 2013 iknowapp studios. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage (Additions)

- (UIImage *)resizableImageWithOffsetTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right
{
   
        return [self resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right)];
   
}

- (UIImage *)getScaledImage:(CGFloat) fscale{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width*fscale, self.size.height*fscale));
    [self drawInRect:CGRectMake(0.0f, 0.0f, self.size.width*fscale, self.size.height*fscale)];
    UIImage *imgScale = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imgScale;
}

+ (UIImage *)imageWithUIView:(UIView *)view
{
    CGSize screenShotSize = view.bounds.size;
    UIImage *img;
    UIGraphicsBeginImageContext(screenShotSize);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [view drawLayer:view.layer inContext:ctx];
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
