//
//  RequestResult.h
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/20.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger,RequestResultState){
    kRequestResultNetworkError,
    kRequestResultSuccess,
    kRequestResultFail,
    kRequestResultCanceled
};
FOUNDATION_EXPORT NSString const *kRequestResultKey_State;

@interface RequestResult : NSObject
@property (copy) void(^loginCompleteBlock)(RequestResult*,id);
-(bool) isOk;
@property(retain, nonatomic)NSString *errMsg;
@property NSString * errCode;
@property RequestResultState resultState;
@property BOOL accessTokenValid;
@end
