//
//  ImportPhoneNumberViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "ImportPhoneNumberViewController.h"
#import "MBProgressHUD.h"
#import "StartSetPasswordViewController.h"
#import "RegexKitLite.h"
#import "AppDelegate.h"

#import "BindPhoneInterface.h"


@interface ImportPhoneNumberViewController ()<MBProgressHUDDelegate,BindPhoneInterfaceDelegate>

@property (strong, nonatomic) BindPhoneInterface *bindPhoneInterface;

@end

@implementation ImportPhoneNumberViewController

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
    
    self.title = @"绑定手机";
    
    self.bindPhoneInterface = [[BindPhoneInterface alloc]init];
    self.bindPhoneInterface.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnGoNextAction:(UIButton *)sender {
    if ([self.textFieldVericationCode.text isEqualToString:@"123456"]) {
        [self.bindPhoneInterface bindPhoneNum:self.textFieldPhoneNumber.text];
    }else{
        [self.textFieldVericationCode resignFirstResponder];
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark_wrong.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"您输入的验证码不正确";
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        
        self.textFieldVericationCode.text = @"";
    }
}

- (IBAction)btnGetVerificationCode:(UIButton *)sender {
    if (self.isTimeing) {
        return;
    }
    
    [self.textFieldPhoneNumber resignFirstResponder];
    
    if (self.textFieldPhoneNumber.text.length > 0) {
        
        NSString *phoneRegular = @"(1[345]\\d{9})|(18\\d{9})|(0\\d{9,10})";
        NSArray *result = [self.textFieldPhoneNumber.text componentsMatchedByRegex:phoneRegular];
        if (result.count > 0) {
            MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            
            HUD.mode = MBProgressHUDModeCustomView;
            
            HUD.delegate = self;
            HUD.labelText = @"发送成功";
            
            [HUD show:YES];
            [HUD hide:YES afterDelay:2];
            
            self.secondView.hidden = NO;
            
            self.isTimeing = YES;
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setBtnGetVerificationCodeTitle:) userInfo:nil repeats:YES];
            self.timeCount = 60;

        }else{
            MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark_wrong.png"]];
            
            HUD.mode = MBProgressHUDModeCustomView;
            
            HUD.delegate = self;
            HUD.labelText = @"请输入正确的手机号";
            
            [HUD show:YES];
            [HUD hide:YES afterDelay:2];
            
            [self performSelector:@selector(textFieldBecomeFirstResponder) withObject:nil afterDelay:2];
        }
    }else{
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark_wrong.png"]];
        
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.delegate = self;
        HUD.labelText = @"手机号不能为空";
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        
        [self performSelector:@selector(textFieldBecomeFirstResponder) withObject:nil afterDelay:2];
    }
}

-(void)setBtnGetVerificationCodeTitle:(NSTimer *)timer{
    [self.btnGetVerificationCode setTitle:[NSString stringWithFormat:@"%d秒后重新发送",self.timeCount] forState:UIControlStateNormal];
    self.timeCount--;
    if (self.timeCount < 0) {
        [timer invalidate];
        [self.btnGetVerificationCode setTitle:@"重新发送验证码到手机" forState:UIControlStateNormal];
        self.isTimeing = NO;
//        self.btnGetVerificationCode.backgroundColor = [UIColor colorWithRed:0 green:171/255.0 blue:1 alpha:1];
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.textFieldPhoneNumber resignFirstResponder];
    [self.textFieldVericationCode resignFirstResponder];
}

-(void)textFieldBecomeFirstResponder{
    self.textFieldPhoneNumber.text = @"";
    [self.textFieldPhoneNumber becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)goSetQuestionVC{
    StartSetPasswordViewController *vc = [[StartSetPasswordViewController alloc]initWithNibName:@"StartSetPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    vc.hidesBackButton = YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate initTabBarController];
            appDelegate.tabBarController.selectedIndex = 0;
            UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
            [nav popToRootViewControllerAnimated:YES];
        }else{
            StartSetPasswordViewController *vc = [[StartSetPasswordViewController alloc]initWithNibName:@"StartSetPasswordViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            vc.hidesBackButton = YES;
        }
    }
}

#pragma mark - BindPhoneInterfaceDelegate <NSObject>
-(void)getFinishedBindPhoneInterface:(NSString *)status secrect:(NSString *)secrect{
    if ([status isEqualToString:@"ok"]) {
        //成功
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"绑定成功" message:@"是否设置启动密码" delegate:self cancelButtonTitle:@"跳过" otherButtonTitles:@"去设置", nil];
        [alert show];
        alert.tag = 100;
        
        [[NSUserDefaults standardUserDefaults] setObject:self.textFieldPhoneNumber.text forKey:UserBindPhoneNumber];
    }else if ([status isEqualToString:@"exist"]){
        //手机号已绑定其它设备
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark_wrong.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"手机号已绑定其它设备";
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
    }
}
-(void)getFailedBindPhoneInterface:(NSString *)error{
    DebugLog(@"%@",error);
}

@end
