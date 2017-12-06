//
//  IFlySpeech.m
//  Ipadchat
//
//  Created by xiejiangbo on 2017/5/10.
//  Copyright © 2017年 leonchen. All rights reserved.
//

#import "IFlySpeech.h"
//#import "AppDelegate.h"
#import "iflyMSC/IFlyMSC.h"
#import "IATConfig.h"
#import "ISRDataHelper.h"
#define NAME        @"userwords"
#define USERWORDS   @"{\"userword\":[{\"name\":\"我的常用词\",\"words\":[\"佳晨实业\",\"蜀南庭苑\",\"高兰路\",\"复联二\"]},{\"name\":\"我的好友\",\"words\":[\"李馨琪\",\"鹿晓雷\",\"张集栋\",\"周家莉\",\"叶震珂\",\"熊泽萌\"]}]}"


@interface IFlySpeech ()<IFlySpeechRecognizerDelegate,IFlyRecognizerViewDelegate,UIActionSheetDelegate,IFlyPcmRecorderDelegate>
//语义理解对象
@property (nonatomic, strong)IFlySpeechUnderstander *iFlySpeechUnderstander;
@property(strong,nonatomic)NSDictionary *dic;
@end
@implementation IFlySpeech
static IFlySpeech* iFlySpeech = nil;
//- (AppDelegate *)appDelegate
//{
//    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
//}
+ (IFlySpeech *)ShareIFlySpeech{
        static IFlySpeech *iFlySpeech = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            iFlySpeech = [[IFlySpeech alloc]init];
        });
    return iFlySpeech;
}
//+ (IFlySpeech *)ShareIFlySpeech{
//    if (! iFlySpeech) {
//        iFlySpeech=[[super allocWithZone:NULL]init];
//    }
//    return iFlySpeech;
//}
-(void)initRecognizer{
    if (_iFlySpeechRecognizer == nil) {
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    }
    [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
    //set recognition domain
    [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    
    _iFlySpeechRecognizer.delegate = self;
    if (_iFlySpeechRecognizer != nil) {
        IATConfig *instance = [IATConfig sharedInstance];
        
        //set timeout of recording
        [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //set VAD timeout of end of speech(EOS)
        [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
        //set VAD timeout of beginning of speech(BOS)
        [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
        //set network timeout
        [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        
        //set sample rate, 16K as a recommended option
        [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
        
        //set language
        [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        //set accent
        [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
        
        //set whether or not to show punctuation in recognition results
        [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
        
    }
    //Initialize recorder
    if (_pcmRecorder == nil)
    {
        _pcmRecorder = [IFlyPcmRecorder sharedInstance];
    }
    
    _pcmRecorder.delegate = self;
    
    [_pcmRecorder setSample:[IATConfig sharedInstance].sampleRate];
    
    [_pcmRecorder setSaveAudioPath:nil];    //not save the audio file
}
-(void)startVoice{
    _textView = [NSString string];
    if (_iFlySpeechRecognizer == nil) {
        [self initRecognizer];
    }
    [_iFlySpeechRecognizer cancel];
    [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    //Set the audio name of saved recording file while is generated in the local storage path of SDK,by default in library/cache.
    [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    [_iFlySpeechRecognizer setDelegate:self];
    
    BOOL ret = [_iFlySpeechRecognizer startListening];
    
    if (ret) {
       
        
    }else{
        //启动识别服务失败，请稍后重试!
    }
    
    
}
-(void)stopVoice{
    
    NSLog(@"结束----%@",self.textView);
    [_iFlySpeechRecognizer stopListening];
}
//结果返回代理
-(void)onResults:(NSArray *)results isLast:(BOOL)isLast{

    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    NSString *result =[NSString stringWithFormat:@"%@",resultString];
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:resultString];
    NSLog(@"resultFromJson=%@",resultFromJson);
    _textView = [NSString stringWithFormat:@"%@%@", _textView,resultFromJson];
    if (isLast){
        NSLog(@"ISR Results(json)：%@",result);
    }
}
- (void)onResult:(NSArray *)resultArray isLast:(BOOL)isLast
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [resultArray objectAtIndex:0];
    
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
   
}
-(NSDictionary *)getDic:(NSString *)message{
    
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return dict;
}
-(NSString *)getJsonStr:(NSDictionary *)dic{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *string=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *stringTwo=[string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return [stringTwo stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}
//会话结束回调
- (void) onUploadFinished:(IFlySpeechError *)error
{
    NSLog(@"%d",[error errorCode]);
    
    if ([error errorCode] == 0) {
        //[_popUpView showText: NSLocalizedString(@"T_ISR_UpSucc", nil)];
    }
    else {
        //[_popUpView showText: [NSString stringWithFormat:@"%@:%d", NSLocalizedString(@"T_ISR_UpFail", nil), error.errorCode]];
        
    }
}
//音量回调
-(void)onVolumeChanged:(int)volume{
    [self.delegate getIFlySpeechVolume:volume];
}
//录音开始回调
-(void)onBeginOfSpeech{
    
}
//录音结束回调
-(void)onEndOfSpeech{
    
}
//会话取消
-(void)onCancel{
    
}
@end
