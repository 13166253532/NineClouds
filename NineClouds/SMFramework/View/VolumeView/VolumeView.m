//
//  VolumeView.m
//  NineClouds
//
//  Created by xiejiangbo on 2017/12/6.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "VolumeView.h"
@interface VolumeView ()

@property(strong,nonatomic)NSDictionary *dic;
@property(nonatomic,strong)UIImageView *soundImageView;
@property(nonatomic,strong)UIButton *suspensionBtn;
@end
@implementation VolumeView
static VolumeView* volumeView = nil;
+ (VolumeView *)ShareVolumeView{
    static VolumeView *volumeView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        volumeView = [[VolumeView alloc]init];
    });
    
    return volumeView;
}
-(void)actionButton{
    _suspensionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _suspensionBtn.frame = CGRectMake(100*WHIDTH_RATIO, 100*HEIGHT_RATIO, SCREEN_WHIDTH/6.5, SCREEN_WHIDTH/6.5);
    [_suspensionBtn setBackgroundImage:[UIImage imageNamed:@"yuyin"] forState:UIControlStateNormal];
    [_suspensionBtn setBackgroundImage:[UIImage imageNamed:@"yuyinselec"] forState:UIControlStateSelected];
    _suspensionBtn.backgroundColor = [UIColor clearColor];
    [_suspensionBtn addTarget:self action:@selector(MicrophoneUsageDescription:) forControlEvents:UIControlEventTouchUpInside];
    [[self getRootController] addSubview:_suspensionBtn];
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panVerticalUpView:)];
    [_suspensionBtn addGestureRecognizer:panGR];
    //[[UIApplication sharedApplication].keyWindow addSubview:_suspensionBtn];
    [self addInitSoundView];
}
-(UIView *)getRootController{
    return [UIApplication sharedApplication].keyWindow.rootViewController.view;
}
-(void)panVerticalUpView:(UIPanGestureRecognizer *)sender{
    //相对距离
    //CGPoint point = [sender translationInView:self.view];
    CGPoint point = [sender locationInView:[self getRootController]];
    //NSLog(@"point x:%f y:%f",point.x,point.y);
    _suspensionBtn.center = CGPointMake(point.x, point.y);
}
-(void)MicrophoneUsageDescription:(UIButton *)sender{
    AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (videoAuthStatus == AVAuthorizationStatusNotDetermined) {// 未询问用户是否授权
        //第一次询问用户是否进行授权
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            if (granted) {
                NSLog(@"granted==YES");
                [self voiceStopVoiceAction:sender];
            }else {
                NSLog(@"granted==NO");
                _suspensionBtn.selected = YES;
                return ;
            }
        }];
    }else if(videoAuthStatus == AVAuthorizationStatusRestricted || videoAuthStatus == AVAuthorizationStatusDenied) {// 未授权
         NSLog(@"未授权");
        [self showSetAlertView];
        _suspensionBtn.selected = NO;
    }else{// 已授权
        [self voiceStopVoiceAction:sender];
        NSLog(@"授权");
    }

}
- (void)showSetAlertView {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"麦克风权限未开启" message:@"麦克风权限未开启，请进入系统【设置】>【隐私】>【麦克风】中打开开关,开启麦克风功能" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *setAction = [UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //跳入当前App设置界面
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:setAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

-(void)voiceStopVoiceAction:(UIButton *)sender{
    if (_suspensionBtn.selected == YES) {
        [[IFlySpeech ShareIFlySpeech] stopVoice];
        _soundImageView.hidden = YES;
    }else{
        [[IFlySpeech ShareIFlySpeech] startVoice];
    }
    _suspensionBtn.selected = YES!=_suspensionBtn.selected?YES:NO;
}


-(void)addInitSoundView{
    _soundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT/4, SCREEN_HEIGHT/4)];
    _soundImageView.image = [UIImage imageNamed:@"sound_1"];
    _soundImageView.center = CGPointMake(SCREEN_WHIDTH/2, SCREEN_HEIGHT/2);
    _soundImageView.hidden = YES;
    [[self getRootController] addSubview:_soundImageView];
    //[[UIApplication sharedApplication].keyWindow addSubview:_soundImageView];
}
-(void)setIFlySpeechVolume:(int)volume{
    _soundImageView.hidden = NO;
    if (volume<3) {
        _soundImageView.image = [UIImage imageNamed:@"sound_1"];
    }else if (volume>=3&&volume<5){
        _soundImageView.image = [UIImage imageNamed:@"sound_2"];
    }else if (volume>=5&&volume<9){
        _soundImageView.image = [UIImage imageNamed:@"sound_3"];
    }else if (volume>=9&&volume<15){
        _soundImageView.image = [UIImage imageNamed:@"sound_4"];
    }else if (volume>=15&&volume<=20){
        _soundImageView.image = [UIImage imageNamed:@"sound_5"];
    }else if (volume>=20&&volume<=30){
        _soundImageView.image = [UIImage imageNamed:@"sound_5"];
    }
}
-(void)isSoundImageViewHidden{
    _soundImageView.hidden = YES;
}
@end
