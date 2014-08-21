//
//  StartViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-4.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "StartViewController.h"
#import "AppDelegate.h"
#import "InputQuestionAnswerViewController.h"

//#import "StartSetPasswordViewController.h"  //设置-设置密码-如果有密码进行解锁验证
#import "ResetStartPasswordViewController.h"

#import "ImportPhoneNumberViewController.h"     //如果用户第一次运行没有绑定手机就停止应用，再次启动时要求绑定手机
#import "MBProgressHUD.h"

#import "UIViewController+TopBarMessage.h"
#import <AudioToolbox/AudioToolbox.h>
#import "UIColor+GetColorFromString.h"

@interface StartViewController ()<MBProgressHUDDelegate>

@end

@implementation StartViewController
@synthesize lockVC;

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
    
    self.inputCount = 0;
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    NSString *userBindPhone = [[NSUserDefaults standardUserDefaults] objectForKey:UserBindPhoneNumber];
    if (!(userBindPhone.length > 0)) {
        //没有绑定手机
        ImportPhoneNumberViewController *vc = [[ImportPhoneNumberViewController alloc]initWithNibName:@"ImportPhoneNumberViewController" bundle:nil];
        
        [self.navigationController pushViewController:vc animated:NO];
        vc.navigationItem.hidesBackButton = YES;
        return;
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSString *password = [[NSUserDefaults standardUserDefaults]objectForKey:StartPassword];
    NSString *theQuestion = [[NSUserDefaults standardUserDefaults] objectForKey:TheQuestion];
    NSString *theAnwser = [[NSUserDefaults standardUserDefaults] objectForKey:TheQuestionAnswer];
    if (password.length > 0 && theQuestion.length > 0 && theAnwser.length > 0) {
        //已经设置启动密码、密保
        self.navigationItem.title = @"启动密码";
        if (!lockVC) {
            lockVC = [[LockViewController alloc] init];
            [lockVC setTarget:self withAction:@selector(lockEntered:)];
            [self.view addSubview:lockVC.view];
            if (DeviceHeight < 500) {
                lockVC.view.frame = CGRectMake(0, 45, 320, 320);
            }else{
                lockVC.view.frame = CGRectMake(0, 45+50, 320, 320);
            }
            
        }
    }else{
        //没有启动密码，直接到令牌界面
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate initTabBarController];
    }
}

-(void)lockEntered:(NSString *)key{
    self.inputCount++;
    DebugLog(@"密码为：%@",key);
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:StartPassword];
    if ([key isEqualToString:password]) {
        self.inputCount = 0;
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate setTimerStart];
        
//        self.labOutput.textColor = [UIColor darkTextColor];
//        self.labOutput.text = @"请输入启动密码";
        
        if (self.isStart) {
            ResetStartPasswordViewController *vc = [[ResetStartPasswordViewController alloc]initWithNibName:@"ResetStartPasswordViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate initTabBarController];
        }
    }else{
        //启动失败
        if (self.inputCount < 3) {
            self.labOutput.text = [NSString stringWithFormat:@"启动失败，还有%d次机会", 3-self.inputCount];
        }else if(self.inputCount < 6){
            self.viewBtnForget.hidden = NO;
            self.watingCount = 60;
            self.labOutput.text = [NSString stringWithFormat:@"休息一会，%d秒后再重新输入",60];
            self.lockVC.view.userInteractionEnabled = NO;
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setLabelText:) userInfo:nil repeats:YES];
        }
    }
}

-(void)setLabelText:(NSTimer *)timer{
    self.watingCount--;
    if (self.watingCount < 0) {
        self.inputCount = 0;
        self.lockVC.view.userInteractionEnabled = YES;
        self.labOutput.text = @"请输入密码";
        [timer invalidate];
        return;
    }
    self.labOutput.text = [NSString stringWithFormat:@"休息一会，%d秒后再重新输入",self.watingCount];
}

- (IBAction)btnForgetPasswordAction:(UIButton *)sender {
    InputQuestionAnswerViewController *vc = [[InputQuestionAnswerViewController alloc]initWithNibName:@"InputQuestionAnswerViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)showMessage{
//    [self showTopMessage:@"收到新的验证请求" topBarConfig:nil dismissDelay:10.0 withTapBlock:nil];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    NSDictionary *topBarConfig = @{kDXTopBarBackgroundColor:[UIColor getColorFromString:@"#4D4D4DFF"], kDXTopBarTextColor : [UIColor getColorFromString:@"#F5F5CFFF"], kDXTopBarIcon : [UIImage imageNamed:@"icon_warn.png"], kDXTopBarTextFont : [UIFont boldSystemFontOfSize:14.0]};
    
    [self showTopMessage:@"收到新的验证请求" topBarConfig:topBarConfig dismissDelay:10.0 withTapBlock:nil];
}

-(void)dealloc{
    self.lockVC = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
