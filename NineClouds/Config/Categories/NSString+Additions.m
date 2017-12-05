//
//  NSString+Additions.m
//  bpm
//
//  Created by 张 超 on 12/29/13.
//  Copyright 2013 iknowapp studios. All rights reserved.
//

#import "NSString+Additions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MD5)

- (NSUInteger)integerValueFromHex
{
    unsigned result = 0;
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner scanHexInt:&result];
    return result;
}

/*
 
 Return the hexadecimal string representation of the MD5 digest of the target
 NSString. In this example, this is used to generate a statistically unique
 ID for each fortune file.
 
 */
- (NSString *)MD5String;
{
    NSString *strMD5 = nil;
    if ( [self length] > 0 ) {
        const char *str = [self UTF8String];
        unsigned char r[CC_MD5_DIGEST_LENGTH];
        CC_MD5(str, (CC_LONG)strlen(str), r);
        strMD5 = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                    r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    }
    
    return strMD5;
}

- (NSString*) getQueryValueForKey:(NSString*)key
{
    NSRange range = [self rangeOfString:[NSString stringWithFormat:@"(\\?|&)%@=([^&]*)", key] options:NSRegularExpressionSearch];
    if (range.length > 0) {
        range.location++;
        range.length--;
        NSString* keyAndEqual = [NSString stringWithFormat:@"%@=", key];
        return [[self substringWithRange:range] stringByReplacingOccurrencesOfString:keyAndEqual withString:@""];
    } else {
        return nil;
    }
}


@end
