//
//  SMBaseHttpComplete.m
//  SQlDemo
//
//  Created by xiejiangbo on 2017/11/20.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "SMBaseHttpComplete.h"

@interface SMBaseHttpComplete()
@property id userInfo;
@end
@implementation SMBaseHttpComplete

-(SMBaseHttpComplete *)initWithBlock:(void(^)(RequestResult *,id))completeBlock withUserInfo:(id)userInfo{
    self = [super init];
    
    if(self){
        _completeBlock = completeBlock;
        _userInfo = userInfo;
    }
    return self;
}

#pragma mark - Overrided

-(void)complete:(id)resultObj{
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:resultObj waitUntilDone:YES];
}
-(void)updateUI:(RequestResult *)result
{
    [self completeBlock]((RequestResult *)result,_userInfo);
}
@end
