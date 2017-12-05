//
//  HttpConfig.h
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/20.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpConfig : NSObject
-(NSString const *)getServerAddress:(NSString *)addressKey;
@property NSString *accessToken;
@end
