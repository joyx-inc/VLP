//
//  SetStartPasswordViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "SetStartPasswordViewController.h"
#import "SetQuestionViewController.h"
#import "MBProgressHUD.h"

@interface SetStartPasswordViewController ()<MBProgressHUDDelegate>

@property (strong, nonatomic) LockViewController *lockVC;
@property (assign, nonatomic) BOOL OneOrTwo;  //第一次 NO  第二次 YES

@property (strong, nonatomic) NSString *passwordFirst;
@property (strong, nonatomic) NSString *passwordTwice;

@end

@implementation SetStartPasswordViewController
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
    
    self.title = @"设置启动密码";
    [self loadLockView];
    self.OneOrTwo = NO;
    
}


-(void)lockEntered:(NSString *)key{
    DebugLog(@"密码为：%@",key);
    if (self.OneOrTwo == NO) {
        self.passwordFirst = key;
        self.labAdvise.text = @"请再次绘制您所设置的启动密码";
        [self loadLockView];
        self.OneOrTwo = YES;
    }else{
        self.passwordTwice = key;
        if ([self.passwordTwice isEqualToString:self.passwordFirst]) {
            MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            
            HUD.mode = MBProgressHUDModeCustomView;
            
            HUD.delegate = self;
            HUD.labelText = @"密码绘制成功";
            
            [HUD show:YES];
            [HUD hide:YES afterDelay:2];
            
            [self performSelector:@selector(goNext) withObject:nil afterDelay:2];
            
            [[NSUserDefaults standardUserDefaults]setObject:key forKey:StartPassword];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"两次绘制的密码不一致,请重新绘制" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            self.OneOrTwo = NO;
            self.labAdvise.text = @"请绘制您的启动密码";
            [self loadLockView];
        }
    }
}
-(void)goNext{
    SetQuestionViewController *vc = [[SetQuestionViewController alloc]initWithNibName:@"SetQuestionViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadLockView{
    if (!lockVC) {
        lockVC = [[LockViewController alloc] init];
        [lockVC setTarget:self withAction:@selector(lockEntered:)];
        [self.view addSubview:lockVC.view];
        lockVC.view.frame = CGRectMake(0, 120, 320, 320);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
