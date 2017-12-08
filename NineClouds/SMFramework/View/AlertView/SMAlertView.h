//
//  SMAlertView.h
//  BleMall
//
//  Created by K.E. on 14-11-28.
//  Copyright (c) 2014年 blemall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMAlertView : NSObject

+(void)sshowAlert:(NSString *)content;
//温馨提示
//content
//确定
+(void)showAlert:(NSString *)content;
//content
//title
+(void)showAlert:(NSString*)content cancelTitle:(NSString*)title;
//content
//title
+(void)showAlert:(NSString*)content cancelTitle:(NSString*)title delegate:(id)delegate;
+(void)showAlert:(NSString*)content title:(NSString*)title cancleTitle:(NSString*)cancleTitle okTitle:(NSString*)okTitle delegate:(id)delegate;
//         title
//        content
//cancleTitle  okTitle
+(void)showAlert:(NSString*)content title:(NSString*)title cancleTitle:(NSString*)cancleTitle okTitle:(NSString*)okTitle delegate:(id)delegate viewTag:(NSInteger)viewTag;
+(void)showAlertWithInputNumView:(NSString*)content title:(NSString*)title cancleTitle:(NSString*)cancleTitle okTitle:(NSString*)okTitle delegate:(id)delegate;

+(void)showOnlyButtonAlert:(NSString*)content title:(NSString *)title;

//+(void)showAlert:(NSString*)content title:(NSString*)title cancleTitle:(NSString*)cancleTitle okTitle:(NSString*)okTitle delegate:(id)delegate;
@end
