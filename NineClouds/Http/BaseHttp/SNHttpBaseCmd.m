//
//  SNHttpBaseCmd.m
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/20.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "SNHttpBaseCmd.h"
#import "SMHttp.h"
#import "MBProgressHUD.h"
#import "CommonFunc.h"
#import "NineClouds-Swift.h"
#import "HTHttpConfig.h"
const NSString *kResult = @"result";

@interface SNHttpBaseCmd ()
@property MBProgressHUD * mHUD ;
@end

@implementation SNHttpBaseCmd
-(instancetype)initWithVersion:(NSString *)version
{
    self = [super initWithVersion:version];
    
    return self;
}
-(NSString *)getUrl
{
    
    NSString *baseUrl = (NSString *)[self getBaseUrl];
    
    NSString *url = [baseUrl stringByAppendingString:[self getActionUrl]];
    
    NSString *paramUrl = [self getParamUrl];
    if(nil != paramUrl){
        url =  [NSString stringWithFormat:@"%@?%@",url,paramUrl];
    }
    NSString * otherParamUrl = [self getOtherParamUrl];
    if (nil != otherParamUrl && nil == paramUrl) {
        url = [NSString stringWithFormat:@"%@?%@",url,otherParamUrl];
    }else if(nil != otherParamUrl && nil != paramUrl)
        url = [NSString stringWithFormat:@"%@&%@",url,otherParamUrl];
    NSLog(@"%@",url);
    
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
-(NSString const *)getBaseUrl
{
    
    HttpConfig *config = [self httpConfig];
    //NSAssert(nil != config,@"Must init http config");
    NSString const *string = [config getServerAddress:self.serverAddressKey];
    return string;
}
-(NSString *)getActionUrl
{
    NSAssert(NO,@"Must implement in subclass");
    
    return nil;
}
-(NSString *)getParamUrl
{
    return nil;
}
-(NSString*)getOtherParamUrl
{
    return nil;
}
-(NSDictionary *)getRequestParam{
    return self.requestInfo;
}
-(HttpConfig *)httpConfig
{
    
    return [[HttpConfigGroup sharedInstance] getHttpConfig:[HTHttpConfig registerKey]];
}
-(NSString *)serverAddressKey{
    return nil;
}
#pragma mark - Response
-(void)onRequestFailed:(NSError *)error{
    NSLog(@"Error :%@",error);
    [self.result setErrMsg:[error localizedDescription]];
    [self.result setResultState:kRequestResultFail];
}


#pragma --nsdictory to json

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

//-(BOOL)checkLoginIsValid{
//    if (self.needVerify) {
//        if (![[HTAccountInfo sharedInstance] isLogin]) {
////            NSMutableDictionary * dic = [NSMutableDictionary new];
////            dic[kLogin_complete_block]  = self.loginCompleteBlock;
////            dic[kLogin_cancle_block] = self.loginCancleBlock;
////            [[NSNotificationCenter defaultCenter] postNotificationName:NAME_NTF_SHOULD_LOGIN object:dic];
//            return NO;
//        }
//    }
//    return YES;
//}

-(void)showHintView:(NSString*)content
{
    AppDelegate * app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (!self.mHUD) {
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:app.window];
        self.mHUD = HUD;
    }
    self.mHUD.labelText = content;
    [app.window addSubview:self.mHUD];
    [self.mHUD show:YES];
}

-(void)hidenHintView
{
    [self.mHUD hide:YES];
}

-(NSString *)getAuthorization{
    if(self.authorState==AuthorizationNull){
        return @"";
    }else if (self.authorState==AuthorizationToken){
        //NSString *str=[NSString stringWithFormat:@"bearer %@",[DSAccountInfo sharedInstance].access_token];
        NSString *str=[NSString string];
        return str;
    }else if (self.authorState==AuthorizationClientSecret){
        
        NSString *value=@"aceme:acemesecret";
        NSString *str=[CommonFunc base64StringFromText:value];
        NSString *base=[NSString stringWithFormat:@"Basic %@",str];
        return base;
    }else{
        return @"";
    }
}
-(void)judgeTokenExpired:(NSInteger)code{
    if (code==401){
        [[NSNotificationCenter defaultCenter] postNotificationName: @"AccessTokenExpired" object:nil];
    }
}
@end
