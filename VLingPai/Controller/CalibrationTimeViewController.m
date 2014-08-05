//
//  CalibrationTimeViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-5.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "CalibrationTimeViewController.h"
#import <NTP_Component/ios-ntp.h>
#import "MBProgressHUD.h"

@interface CalibrationTimeViewController ()<GetNTPDateDelegate,MBProgressHUDDelegate>{
    NSDateFormatter *formatterDate;
    NSDateFormatter *formatterTime;
    
    NSTimer *timer;
    NSInteger outTime;
}


@end

@implementation CalibrationTimeViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"校准时间";
    self.hidesBottomBarWhenPushed = YES;
    
    NSString *dateFormatter = @"yyyy-MM-dd";
    formatterDate = [[NSDateFormatter alloc]init];
    [formatterDate setDateFormat:dateFormatter];
    
    NSString *timeFormatter = @"HH:mm:ss";
    formatterTime = [[NSDateFormatter alloc]init];
    [formatterTime setDateFormat:timeFormatter];
    
    NSDate *nowDate = [NSDate date];
    NSString *dateStr = [formatterDate stringFromDate:nowDate];
    NSString *timeStr = [formatterTime stringFromDate:nowDate];
    
    self.labDate.text = dateStr;
    self.labTime.text = timeStr;
    
    
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setLabelTitle) userInfo:nil repeats:YES];
    
    timer = [[NSTimer alloc]initWithFireDate:[NSDate date] interval:1.0 target:self selector:@selector(setLabelTitle) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];

    outTime = [[NSUserDefaults standardUserDefaults] integerForKey:@"outTime"];
}

-(void)setLabelTitle{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSinceNow:outTime];
    
    NSString *dateStr = [formatterDate stringFromDate:date];
    NSString *timeStr = [formatterTime stringFromDate:date];
    
    self.labDate.text = dateStr;
    self.labTime.text = timeStr;
}

-(void)getNTPDate:(NSDate *)date{
    NSDate *deviceDate = [NSDate date];
    outTime = [date timeIntervalSinceDate:deviceDate];
    NSLog(@"时间差：%d",outTime);
    
    [NetworkClock sharedNetworkClock].getNTPDateDelegate = nil;
    
    [[NSUserDefaults standardUserDefaults] setInteger:outTime forKey:@"outTime"];
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = @"时间校准成功！";
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
}

//-(NSDateFormatter *)getFormatterDate{
//    if (!formatterDate) {
//        NSString *dateFormatter = @"yyyy-MM-dd";
//        formatterDate = [[NSDateFormatter alloc]init];
//        [formatterDate setDateFormat:dateFormatter];
//        return formatterDate;
//    }
//    return formatterDate;
//}
//-(NSDateFormatter *)getFormatterTime{
//    if (!formatterTime) {
//        NSString *timeFormatter = @"HH:mm:ss";
//        formatterTime = [[NSDateFormatter alloc]init];
//        [formatterTime setDateFormat:timeFormatter];
//        return formatterTime;
//    }
//    return formatterTime;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bntClibrateTimeAction:(UIButton *)sender {
    [NetworkClock sharedNetworkClock].getNTPDateDelegate = self;
    [[NetworkClock sharedNetworkClock] updateDate];
}

-(void)dealloc{
    [timer invalidate];
}
@end
