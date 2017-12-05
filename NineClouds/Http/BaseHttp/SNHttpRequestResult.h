//
//  SNHttpRequestResult.h
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/21.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "RequestResult.h"

@interface SNHttpRequestResult : RequestResult
-(BOOL)parseBasicInfo:(NSDictionary *)response code:(NSInteger)code;
@end
