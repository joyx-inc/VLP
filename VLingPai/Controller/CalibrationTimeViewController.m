//
//  CalibrationTimeViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-5.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "CalibrationTimeViewController.h"
//#import <NTP_Component/ios-ntp.h>
#import "ios-ntp.h"
#import "MBProgressHUD.h"

#import "TokenStore.h"

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
    
    self.title = @"数字令牌";
    self.hidesBottomBarWhenPushed = YES;
    
    
    //开始调用令牌前必须执行并且只能执行一次
    [self initVidAndOTP];
    
    
    BOOL isOpen = [[NSUserDefaults standardUserDefaults] boolForKey:isOpenOTP];
    if (isOpen) {
        [self.mySwitch setOn:YES];
        [self setTime];
        [self whenSwitchIsOn];
    }
    
    

}

-(void)setLabelTitle{
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSinceNow:outTime];
    
//    NSString *dateStr = [formatterDate stringFromDate:date];
    NSString *timeStr = [formatterTime stringFromDate:date];
    
//    self.labDate.text = dateStr;
    self.labTime.text = timeStr;
}


-(void)initVidAndOTP{
    BOOL isFirstOpen = [[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstOpen"];
    if (isFirstOpen) {
        // Built URI
        NSURLComponents *urlc = [[NSURLComponents alloc] init];
        urlc.scheme = @"otpauth";
        urlc.host = 0 ? @"totp" : @"hotp";
        urlc.path = [NSString stringWithFormat:@"/%@:%@", ISSuer, ID];
        urlc.query = [NSString stringWithFormat:@"algorithm=%s&digits=%lu&secret=%@&%s=%lu",
                      "md5", (unsigned long)8, Secret,  0 ? "period" : "counter",(unsigned long)30];
        
        // Make token
        Token* tokenAlloc = [[Token alloc] initWithURL:[urlc URL]];
        if (tokenAlloc != nil)
            [[[TokenStore alloc] init] add:tokenAlloc];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isFirstOpen"];
    }
}


-(void)whenSwitchIsOn{
    self.contentView.hidden = NO;
    [self setTime];
    self.labVid.text = [[NSUserDefaults standardUserDefaults] objectForKey:Vid];
    
}

-(void)setTime{
    //    NSString *dateFormatter = @"yyyy-MM-dd";
    //    formatterDate = [[NSDateFormatter alloc]init];
    //    [formatterDate setDateFormat:dateFormatter];
    
    NSString *timeFormatter = @"HH:mm:ss";
    formatterTime = [[NSDateFormatter alloc]init];
    [formatterTime setDateFormat:timeFormatter];
    
    outTime = [[NSUserDefaults standardUserDefaults] integerForKey:@"outTime"];
    NSDate *vDate = [NSDate date];
    //    NSString *dateStr = [formatterDate stringFromDate:nowDate];
    NSString *timeStr = [formatterTime stringFromDate:vDate];
    
    //    self.labDate.text = dateStr;
    self.labTime.text = timeStr;
    
    timer = [[NSTimer alloc]initWithFireDate:[NSDate date] interval:1.0 target:self selector:@selector(setLabelTitle) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}


-(void)getNTPDate:(NSDate *)date{
    NSDate *deviceDate = [NSDate date];
    outTime = [date timeIntervalSinceDate:deviceDate];
    NSLog(@"时间差：%d",outTime);
    [self setTime];
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



- (IBAction)bntClibrateTimeAction:(UIButton *)sender {
    [NetworkClock sharedNetworkClock].getNTPDateDelegate = self;
    [[NetworkClock sharedNetworkClock] updateDate];
}


#pragma mark - UISwitchAction
- (IBAction)switchAction:(UISwitch *)sender {
    if (sender.isOn) {
        [self whenSwitchIsOn];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:isOpenOTP];
    }else{
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        self.contentView.hidden = YES;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:isOpenOTP];
    }
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

-(void)dealloc{
    [timer invalidate];
}
@end
