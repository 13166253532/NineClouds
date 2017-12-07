//
//  VolumeView.h
//  NineClouds
//
//  Created by xiejiangbo on 2017/12/6.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VolumeView : NSObject
@property (nonatomic, strong) NSString * textView;

+ (VolumeView *)ShareVolumeView;
-(void)addInitSoundView;
-(void)setIFlySpeechVolume:(int)volume;
-(void)isSoundImageViewHidden;
-(void)actionButton;
@end
