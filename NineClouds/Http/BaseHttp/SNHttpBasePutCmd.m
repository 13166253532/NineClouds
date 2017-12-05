//
//  SNHttpBasePutCmd.m
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/23.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "SNHttpBasePutCmd.h"
#import "AFNetworking.h"
#import "SMHttp.h"
static NSString *const kHttpParamKey_sessionId = @"token";

@implementation SNHttpBasePutCmd
- (id)execute{
    
    return [self executeByOperationManager];
    
}
-(id)executeByOperationManager{
    AFHTTPSessionManager *manager = [self afnetworkOperationManager];
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    //    requestSerializer.timeoutInterval = 10;
    
    NSString *auth = [self getAuthorization];
    if (auth.length>0){
        [requestSerializer setValue:auth forHTTPHeaderField:@"Authorization"];
    }
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer = requestSerializer;
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.securityPolicy.allowInvalidCertificates=YES;
    manager.securityPolicy.validatesDomainName=NO;
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"text/json",@"application/json",@"text/plain",@"text/html", nil];
    
    NSLog(@"getBodyParam:%@",[self DataTOjsonString:[self getBodyParam]]);
    NSURLSessionDataTask * dataTask = [manager PUT:(NSString *)[self getUrl] parameters:[self getBodyParam] success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
-(NSDictionary *)getRequestParam{
    NSMutableDictionary *dict = (NSMutableDictionary *)[super getRequestParam];
    if (nil == dict) {
        dict = [NSMutableDictionary dictionary];
    }
    return dict;
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
