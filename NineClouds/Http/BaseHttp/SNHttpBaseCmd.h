//
//  SNHttpBaseCmd.h
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/20.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "HttpCommand.h"
#import "SMHttp.h"
#import "PVHttpVersion.h"
@interface SNHttpBaseCmd : HttpCommand

-(instancetype)initWithVersion:(NSString *)version;
//-(BOOL)checkLoginIsValid;
-(HttpConfig *)httpConfig;
-(NSString *)serverAddressKey;
-(void)onRequestFailed:(NSError *)error;


-(NSString*)DataTOjsonString:(id)object;
-(NSString *)getAuthorization;
-(void)showHintView:(NSString*)content;
-(void)hidenHintView;
-(void)judgeTokenExpired:(NSInteger)code;

@end
