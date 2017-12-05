//
//  NSString+Additions.h
//  bpm
//
//  Created by 张 超 on 12/29/13.
//  Copyright 2013 iknowapp studios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

- (NSUInteger)integerValueFromHex;

- (NSString *)MD5String;

- (NSString*) getQueryValueForKey:(NSString*)key;

@end
