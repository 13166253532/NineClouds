//
//  RequestResult.m
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/20.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "RequestResult.h"

NSString const *kRequestResultKey_State=@"status";
@interface RequestResult()

@property BOOL tokenValid;
@end



@implementation RequestResult
-(id)init{
    self = [super init];
    if (nil != self) {
        _tokenValid = YES;
    }
    return self;
}
-(bool)isOk{
    return (kRequestResultSuccess == [self resultState]);
}
-(BOOL)accessTokenValid{
    return self.tokenValid;
}
-(void) setAccessTokenValid:(BOOL)accessTokenValid{
    self.tokenValid = accessTokenValid;
}
@end
