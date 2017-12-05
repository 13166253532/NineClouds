//
//  SNHttpBaseGetCmd.m
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/20.
//  Copyright © 2017年 yin chen. All rights reserved.
//
#import <Foundation/NSObject.h>
#import <Foundation/NSException.h>
#import "SNHttpBaseGetCmd.h"
#import "AFNetworking.h"
//#import "AppDelegate.h"
#import "NineClouds-Swift.h"
static NSString *const kHttpParamKey_sessionId = @"token";
NSString *const kHttpParamKey_pageNum = @"page";
NSString *const kHttpParamKey_pageSize = @"size";
NSString *const kHttpParamKey_address = @"address";

@implementation SNHttpBaseGetCmd
- (id)execute{
    return [self executeByOperationManager];
}
-(id)executeByOperationManager{
     [self showHintView:@"加载中..."];
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
    //NSLog(@"requestJson:%@",[self DataTOjsonString:[self getBodyParam]]);
    NSString *url = (NSString *)[self getUrl];
    NSURLSessionDataTask * dataTask = [manager GET:url parameters:[self getBodyParam] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject != nil) {
            NSLog(@"resultJson:%@",[self DataTOjsonString:responseObject]);
            [self onRequestSuccess:responseObject code:[self showResponseCode:task.response]];
            [self invokeComplete];
            [self hidenHintView];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
//        if (operation.responseObject!=nil){
//            NSLog(@"resultJson:%@",[self DataTOjsonString:operation.responseObject]);
//            [self onRequestSuccess:operation.responseObject code:operation.response.statusCode];
//        } else {
//            [self onRequestFailed:error];
//            NSLog ( @"operation: %@" , operation. responseString );
//        }
//        [self invokeComplete];
//        //[self hidenHintView];
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

-(AFHTTPSessionManager *)afnetworkOperationManager{
    return [AFHTTPSessionManager manager];
}
-(NSDictionary *)getBodyParam{
    return [self getRequestParam];
}
-(NSDictionary *)getRequestUrlParam{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (YES == self.needVerify) {
        HttpConfig *httpConfig = [self httpConfig];
        NSAssert(nil != httpConfig.accessToken , @"accessToken must not nil");
        dict[kHttpParamKey_sessionId] = httpConfig.accessToken;
    }
    return dict;
}
-(NSString *)getParamUrl
{
    NSString * paramUrl = [[NSString alloc]init];
    NSDictionary *dict = [self getRequestUrlParam];
    if(nil != dict){
        for(NSString *key in dict.allKeys){
            paramUrl = [paramUrl stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,[dict valueForKey:key]]];
        }
    }
    if (paramUrl.length>0) {
        return [paramUrl substringToIndex:paramUrl.length-1];
    }else
    {
        return nil;
    }
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
