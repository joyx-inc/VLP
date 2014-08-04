//
//  StartViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-4.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "StartViewController.h"
//#import "VerificationViewController.h"
#import "AppDelegate.h"

@interface StartViewController ()

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
    self.title = @"请输入启动密码";
    
    [self loadLockView];
}

-(void)lockEntered:(NSString *)key{
    self.inputCount++;
    NSLog(@"密码为：%@",key);
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:StartPassword];
    if ([key isEqualToString:password]) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate initTabBarController];
    }else{
        //启动失败
        if (self.inputCount < 3) {
            self.labOutput.text = [NSString stringWithFormat:@"启动失败，还有%d次机会", 3-self.inputCount];
//            [self loadLockView];
        }else if(self.inputCount < 6){
            self.viewBtnForget.hidden = NO;
            self.labOutput.text = [NSString stringWithFormat:@"休息一会，%d秒后再重新输入",(self.inputCount - 3) * 60];
            self.lockVC.view.userInteractionEnabled = NO;
            [self performSelector:@selector(lockViewIsEnabled) withObject:nil afterDelay:(self.inputCount - 3) * 60];
            
        }
    }
}
-(void)loadLockView{
    if (!lockVC) {
        lockVC = [[LockViewController alloc] init];
        [lockVC setTarget:self withAction:@selector(lockEntered:)];
        [self.view addSubview:lockVC.view];
        lockVC.view.frame = CGRectMake(0, 120, 320, 320);
    }
}
-(void)lockViewIsEnabled{
    lockVC.view.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnForgetPasswordAction:(UIButton *)sender {
}
@end
