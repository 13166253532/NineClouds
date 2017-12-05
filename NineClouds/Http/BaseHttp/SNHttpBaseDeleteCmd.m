//
//  SNHttpBaseDeleteCmd.m
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/23.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "SNHttpBaseDeleteCmd.h"
#import "AFNetworking.h"

@implementation SNHttpBaseDeleteCmd
- (id)execute{
    return [self executeByOperationManager];
}

-(id)executeByOperationManager{
    AFHTTPSessionManager *manager = [self afnetworkOperationManager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain", nil];
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *auth = [self getAuthorization];
    if (auth.length>0) {
        [requestSerializer setValue:auth forHTTPHeaderField:@"Authorization"];
    }
    manager.requestSerializer = requestSerializer;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    NSLog(@"requestJson:%@",[self DataTOjsonString:[self getBodyParam]]);
    NSURLSessionDataTask * dataTask = [manager DELETE:(NSString *)[self getUrl] parameters:[self getBodyParam] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (requestSerializer != nil) {
            NSLog(@"resultJson:%@",[self DataTOjsonString:responseObject]);
        }
        [self onRequestSuccess:responseObject code:[self showResponseCode:task.response]];
        [self invokeComplete];
        [self hidenHintView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self judgeTokenExpired:[self showResponseCode:task.response]];
        [self onRequestFailed:error];
        [self hidenHintView];
    }];
    [dataTask resume];
    return dataTask;
}
- (NSInteger )showResponseCode:(NSURLResponse *)response {
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger responseStatusCode = [httpResponse statusCode];
    //NSLog(@"responseStatusCode=%ld response=%@ httpResponse=%@",(long)responseStatusCode,response,httpResponse);
    NSLog(@"responseStatusCode=%ld",(long)responseStatusCode);
    return responseStatusCode;
}
-(AFHTTPSessionManager *)afnetworkOperationManager
{
    return [AFHTTPSessionManager manager];
}
-(NSDictionary *)getBodyParam{
    return [self getRequestParam];
}
-(NSDictionary *)getRequestParam{
    NSMutableDictionary *dict = (NSMutableDictionary *)[super getRequestParam];
    if (nil == dict) {
        dict = [NSMutableDictionary dictionary];
    }
    return dict;
}

-(NSMutableDictionary *)getRequestUrlOtherParam{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (YES == self.needOtherParams) {
        dict = [[self getRequestParam] mutableCopy];
    }
    return dict;
}

-(NSString*)getOtherParamUrl
{
    NSString * paramUrl = [[NSString alloc]init];
    NSMutableDictionary *dict = [self getRequestUrlOtherParam];
    if(nil != dict){
        for(NSString *key in dict.allKeys){
            paramUrl = [paramUrl stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[dict valueForKey:key]]];
        }
    }
    //    [dict removeAllObjects];
    if (paramUrl.length>0) {
        return [paramUrl substringToIndex:paramUrl.length-1];
    }else
    {
        return nil;
    }
}

@end
