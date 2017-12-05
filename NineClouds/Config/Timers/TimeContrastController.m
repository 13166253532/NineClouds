//
//  TimeContrastController.m
//  CarRental
//
//  Created by xiejiangbo on 2017/8/4.
//  Copyright © 2017年 yin chen. All rights reserved.
//

#import "TimeContrastController.h"

@implementation TimeContrastController
+ (TimeContrastController *)ShareTimeContrastController{
    static TimeContrastController *timeContrastController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timeContrastController = [[TimeContrastController alloc]init];
       
    });
    return timeContrastController;
}
-(NSString *)getTimeContrast:(NSString *)time{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 当前时间字符串格式
    NSString *nowDateStr = [dateFomatter stringFromDate:nowDate];
    // 截止时间data格式
    NSDate *expireDate = [dateFomatter dateFromString:time];
    // 当前时间data格式
    nowDate = [dateFomatter dateFromString:nowDateStr];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差nowDate
    NSDateComponents *dateCom = [calendar components:unit fromDate:expireDate toDate:nowDate options:0];
    //NSLog(@"日===%ld 小时===%ld 分===%ld 秒===%ld",dateCom.day,dateCom.hour,dateCom.minute,dateCom.second);
    if (dateCom.day == 0 && dateCom.hour == 0 && dateCom.minute == 0 && dateCom.second < 59) {
        return @"刚刚";
    }else if (dateCom.day == 0 && dateCom.hour == 0 && dateCom.minute != 0){
        return [NSString stringWithFormat:@"%ld分钟前",(long)dateCom.minute];
    }else if (dateCom.day == 0 && dateCom.hour != 0){
        return [NSString stringWithFormat:@"%ld小时前",(long)dateCom.hour];
    }else if (dateCom.day != 0){
        return time;
    }
    return time;
}
@end
