//
//  TabBarView.m
//  CarRental
//
//  Created by xiejiangbo on 2017/5/16.
//  Copyright © 2017年 yin chen. All rights reserved.
//
#define kDEVICE_WIDTH [[UIScreen mainScreen] bounds].size.width
//定义屏幕的高度
#define kDEVICE_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]
#import "TabBarView.h"
#import "NineClouds-Swift.h"
@interface TabBarView ()
@property(nonatomic,strong)UIImageView *bagImageView;
@property(nonatomic,strong)UIButton *oneBtn;
@property(nonatomic,strong)UIButton *twoBtn;
@property(nonatomic,strong)UIButton *thrBtn;
@property(nonatomic,strong)UIButton *forBtn;

@property(nonatomic,strong)UIImageView *oneImage;
@property(nonatomic,strong)UIImageView *twoImage;
@property(nonatomic,strong)UIImageView *thrImage;
@property(nonatomic,strong)UIImageView *forImage;
@property(nonatomic,strong)UIImageView *fengeImage;


@property (strong, nonatomic)NSArray *tabBarTitle;
@end
@implementation TabBarView

+ (TabBarView *)ShareTabBarView{
        static TabBarView *tabBarView = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            tabBarView = [[TabBarView alloc]init];
            tabBarView.tabBarTitle = @[@"首页",@"监测",@"检测",@"控制"];
        });
    return tabBarView;
}
-(UIImageView *)addInitView:(UIImageView *)bagImageView{
    self.bagImageView = bagImageView;
    self.bagImageView.userInteractionEnabled = YES;
    self.bagImageView.backgroundColor = [UIColor whiteColor];
    //Home_selec_image  Class_selec_image    ShoppingCar_selec_image   Mine_selec_image
    [self addView];
    [self addInitView];
    [self addInitBtn];
    
    return self.bagImageView;
}

-(void)addView{
    self.fengeImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bagImageView.bounds.size.width, 0.5)];
    self.fengeImage.backgroundColor = [UIColor grayColor];
    [self.bagImageView addSubview:self.fengeImage];
    
}
-(void)addInitBtn{
    
    self.oneBtn = [self getBtn];
    self.oneBtn.frame = CGRectMake(0, 0, self.bagImageView.bounds.size.width/4, self.bagImageView.bounds.size.height);
    [self.oneBtn addTarget:self action:@selector(oneBtnAction:) forControlEvents:UIControlEventTouchUpInside];
  
    self.twoBtn = [self getBtn];
    self.twoBtn.frame = CGRectMake(self.bagImageView.bounds.size.width/4, 0, self.bagImageView.bounds.size.width/4, self.bagImageView.bounds.size.height);
    [self.twoBtn addTarget:self action:@selector(twoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.thrBtn = [self getBtn];
    self.thrBtn.frame = CGRectMake(self.bagImageView.bounds.size.width/4*2, 0, self.bagImageView.bounds.size.width/4, self.bagImageView.bounds.size.height);
    [self.thrBtn addTarget:self action:@selector(thrBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.forBtn = [self getBtn];
    self.forBtn.frame = CGRectMake(self.bagImageView.bounds.size.width/4*3, 0, self.bagImageView.bounds.size.width/4, self.bagImageView.bounds.size.height);
    [self.forBtn addTarget:self action:@selector(forBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    

    
    [self.bagImageView addSubview:self.oneBtn];
    [self.bagImageView addSubview:self.twoBtn];
    [self.bagImageView addSubview:self.thrBtn];
    [self.bagImageView addSubview:self.forBtn];
    
}
-(UIButton *)getBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    return btn;
}
-(void)addInitView{
    CGFloat h=self.bagImageView.bounds.size.height;
    CGFloat w=self.bagImageView.bounds.size.width;
    
    self.oneImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, w/4, h)];
    self.oneImage.contentMode = UIViewContentModeScaleAspectFit;
    self.oneImage .image = [UIImage imageNamed:@"Home_selec_image"];

    
    self.twoImage = [[UIImageView alloc]initWithFrame:CGRectMake(w/4, 0, w/4, h)];
    self.twoImage .image = [UIImage imageNamed:@"Class_image"];
    self.twoImage.contentMode = UIViewContentModeScaleAspectFit;
    
    self.thrImage = [[UIImageView alloc]initWithFrame:CGRectMake(w/4*2, 0, w/4, h)];
    self.thrImage .image = [UIImage imageNamed:@"ShoppingCar_image"];
    self.thrImage.contentMode = UIViewContentModeScaleAspectFit;
    
    
    self.forImage = [[UIImageView alloc]initWithFrame:CGRectMake(w/4*3, 0, w/4, h)];
    self.forImage .image = [UIImage imageNamed:@"Mine_image"];
    self.forImage.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.bagImageView addSubview:self.oneImage];
    [self.bagImageView addSubview:self.twoImage];
    [self.bagImageView addSubview:self.thrImage];
    [self.bagImageView addSubview:self.forImage];

    
}
-(UILabel *)getLabel:(UILabel *)label{
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:10];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
-(void)oneBtnAction:(UIButton *)sender{
    [self.delegate getIndex:0];
    [self initAllView];
    [self oneAction];
}
-(void)oneAction{
    self.oneImage.image = [UIImage imageNamed:@"Home_selec_image"];
}
-(void)twoBtnAction:(UIButton *)sender{
        [self.delegate getIndex:1];
        [self initAllView];
        [self twoAction];
}

-(BOOL)isExpired:(NSString *)time{
    NSDateFormatter *dformatters = [[NSDateFormatter alloc]init];
    dformatters.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *newDate = [[NSDate alloc]init];
    NSDate *date1 = [dformatters dateFromString:time];
    if ([date1 compare:newDate] == NSOrderedAscending) {
        return NO;
    }else if([date1 compare:newDate] == NSOrderedDescending){
        return YES;
    }else if([date1 compare:newDate] == NSOrderedSame){
        
    }
    return YES;
}
-(BOOL)isStartTime:(NSString *)time{
    NSDateFormatter *dformatters = [[NSDateFormatter alloc]init];
    dformatters.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *newDate = [[NSDate alloc]init];
    NSDate *date1 = [dformatters dateFromString:time];
    if ([date1 compare:newDate] == NSOrderedAscending) {
        return YES;
    }else if([date1 compare:newDate] == NSOrderedDescending){
        return NO;
    }else if([date1 compare:newDate] == NSOrderedSame){
        
    }
    return NO;
}

-(void)twoAction{
    self.twoImage.image = [UIImage imageNamed:@"Class_selec_image"];
}
-(void)thrBtnAction:(UIButton *)sender{
        
        [self.delegate getIndex:2];
        [self initAllView];
        [self thrAction];
}
-(void)thrAction{
    self.thrImage.image = [UIImage imageNamed:@"ShoppingCar_selec_image"];
}
-(void)forBtnAction:(UIButton *)sender{
    [self.delegate getIndex:3];
    [self initAllView];
    [self forAction];
}
-(void)forAction{
    self.forImage.image = [UIImage imageNamed:@"Mine_selec_image"];
}
-(void)fiveBtnAction:(UIButton *)sender{
    [self.delegate getIndex:4];
    [self initAllView];
    [self fiveAction];
}
-(void)fiveAction{
   
}
-(void)selecLabelImage:(UILabel *)label andImage:(UIImageView *)image andImageName:(NSString *)imageName{
    label.textColor = COLOR_WITH_HEX(0x69d8ec);
    image.image = [UIImage imageNamed:imageName];
}

-(void)nomLabelImage:(UILabel *)label andImage:(UIImageView *)image andImageName:(NSString *)imageName{
    label.textColor = [UIColor whiteColor];
    image.image = [UIImage imageNamed:imageName];
}
-(void)initAllView{
    self.oneImage .image = [UIImage imageNamed:@"Home_image"];
    self.twoImage .image = [UIImage imageNamed:@"Class_image"];
    self.thrImage .image = [UIImage imageNamed:@"ShoppingCar_image"];
    self.forImage .image = [UIImage imageNamed:@"Mine_image"];
}


@end
