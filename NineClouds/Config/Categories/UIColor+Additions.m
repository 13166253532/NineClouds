//
//  UIColor+Additions.m
//  bpm
//
//  Created by 张 超 on 12/29/13.
//  Copyright 2013 iknowapp studios. All rights reserved.
//

#import "UIColor+Additions.h"
#import "NSString+Additions.h"

@implementation UIColor (Additions)

+ (UIColor*)colorWithIntegerABGR:(NSInteger)ABGR
{
    UIColor* color = [UIColor colorWithIntRed:ABGR & 0xff
                                     intGreen:ABGR >> 8 & 0xff
                                      intBlue:ABGR >> 16 & 0xff
                                  andIntAlpha:ABGR >> 24 & 0xff];
    return color;
}

+ (UIColor*)colorWithStringRGB:(NSString*)RGB
{
    UIColor* color = nil;
    if (7 == [RGB length]) {
        // TODO-Alen Regular Expression
        if ('#' == [RGB characterAtIndex:0]) {
            NSUInteger red = [[RGB substringWithRange:NSMakeRange(1, 2)] integerValueFromHex];
            NSUInteger green = [[RGB substringWithRange:NSMakeRange(3, 2)] integerValueFromHex];
            NSUInteger blue = [[RGB substringWithRange:NSMakeRange(5, 2)] integerValueFromHex];
            color = [UIColor colorWithIntRed:red intGreen:green intBlue:blue];
        }
    }
    return color;
}

+ (UIColor*)colorWithIntRed:(NSUInteger)red intGreen:(NSUInteger)green intBlue:(NSUInteger)blue andIntAlpha:(NSUInteger)alpha {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha/255.0];
}

+ (UIColor*)colorWithIntRed:(NSUInteger)red intGreen:(NSUInteger)green intBlue:(NSUInteger)blue {
    return [UIColor colorWithIntRed:red intGreen:green intBlue:blue andIntAlpha:255];
}

- (NSInteger)abgr
{
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    red = components[0];
    green = components[1];
    blue = components[2];
    alpha = CGColorGetAlpha(self.CGColor);
    
    uint32_t abgr = 0x0;
    abgr |= ((int)(alpha * 255)) << 24;
    abgr |= ((int)(blue * 255)) << 16;
    abgr |= ((int)(green * 255)) << 8;
    abgr |= ((int)(red * 255));
    return abgr;
}

@end
