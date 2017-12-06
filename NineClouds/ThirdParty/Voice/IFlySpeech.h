//
//  IFlySpeech.h
//  Ipadchat
//
//  Created by xiejiangbo on 2017/5/10.
//  Copyright © 2017年 leonchen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFlyMSC/IFlyMSC.h"

@class IFlyDataUploader;
@class IFlySpeechRecognizer;
@class IFlyPcmRecorder;

@protocol IFlySpeechDelegate<NSObject>
-(void)getIFlySpeechMessage:(NSString*)message;
-(void)getIFlySpeechVolume:(int)volume;
@end

@interface IFlySpeech : NSObject
@property(nonatomic,weak)id<IFlySpeechDelegate>delegate;
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;//Recognition conrol without view
@property (nonatomic, strong) IFlyRecognizerView *iflyRecognizerView;//Recognition control with view
@property (nonatomic, strong) IFlyDataUploader *uploader;//upload control
@property (nonatomic,strong) IFlyPcmRecorder *pcmRecorder;
@property (nonatomic, strong) NSString * textView;
+ (IFlySpeech *)ShareIFlySpeech;
-(void)startVoice;
-(void)stopVoice;
-(void)initRecognizer;
@end
