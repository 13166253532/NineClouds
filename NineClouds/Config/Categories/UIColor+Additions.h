//
//  UIColor+Additions.h
//  bpm
//
//  Created by 张 超 on 12/29/13.
//  Copyright 2013 iknowapp studios. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COLOR_BLACK_RGBA [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]

@interface UIColor (Additions)

// Integer ABGR 0xAABBGGRR eg: 0xff000000 is BLACK, 0x00ffffff is WHITE
+ (UIColor*)colorWithIntegerABGR:(NSInteger)ABGR;

// String RGB #RRGGBB eg: #000000 is BLACK, #FFFFFF is WHITE
+ (UIColor*)colorWithStringRGB:(NSString*)RGB;

// Integer RGBA
+ (UIColor*)colorWithIntRed:(NSUInteger)red intGreen:(NSUInteger)green intBlue:(NSUInteger)blue andIntAlpha:(NSUInteger)alpha;

// Integer RGB from 0 to 255
+ (UIColor*)colorWithIntRed:(NSUInteger)red intGreen:(NSUInteger)green intBlue:(NSUInteger)blue;

// String RGB like #123456
+ (UIColor*)colorWithStringRGB:(NSString*)RGB;

// Integer ABGR 0xAABBGGRR eg: 0xff000000 is BLACK, 0x00ffffff is WHITE
@property (nonatomic, readonly) NSInteger abgr;

@end
