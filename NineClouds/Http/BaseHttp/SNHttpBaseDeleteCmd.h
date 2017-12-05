//
//  SNHttpBaseDeleteCmd.h
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/23.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "SNHttpBaseCmd.h"
#import "SMHttp.h"

@class AFHTTPSessionManager;

@interface SNHttpBaseDeleteCmd : SNHttpBaseCmd
-(AFHTTPSessionManager *)afnetworkOperationManager;
@end
