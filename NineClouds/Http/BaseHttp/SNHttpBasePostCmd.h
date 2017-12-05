//
//  SNHttpBasePostCmd.h
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/21.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "SNHttpBaseCmd.h"

#import "SMHttp.h"
#import "SNHttpBaseCmd.h"

@class AFHTTPRequestOperationManager;

@interface SNHttpBasePostCmd : SNHttpBaseCmd
-(NSDictionary *)getBodyParam;
-(NSDictionary *)getRequestUrlParam;
-(AFHTTPRequestOperationManager *) afnetworkOperationManager;
@end
