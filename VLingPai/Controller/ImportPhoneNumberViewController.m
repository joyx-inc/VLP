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
//#import "VerificationViewController.h"

@interface ImportPhoneNumberViewController ()<MBProgressHUDDelegate>



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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnGoNextAction:(UIButton *)sender {
    if ([self.textFieldVericationCode.text isEqualToString:@"123456"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"绑定成功" message:@"是否设置启动密码" delegate:self cancelButtonTitle:@"跳过" otherButtonTitles:@"去设置", nil ];
        [alert show];
        alert.tag = 100;
    }else{
        [self.textFieldVericationCode resignFirstResponder];
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.delegate = self;
        HUD.labelText = @"您输入的验证码不正确";
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        
        self.textFieldVericationCode.text = @"";
    }
}

- (IBAction)btnGetVerificationCode:(UIButton *)sender {
    [self.textFieldPhoneNumber resignFirstResponder];
    if (self.textFieldPhoneNumber.text.length > 0) {
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.delegate = self;
        HUD.labelText = @"发送成功";
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        
        self.secondView.hidden = NO;
        
    }else{
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.delegate = self;
        HUD.labelText = @"请输入正确的手机号";
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        
        [self performSelector:@selector(textFieldBecomeFirstResponder) withObject:nil afterDelay:2];
    }
}

-(void)textFieldBecomeFirstResponder{
    self.textFieldPhoneNumber.text = @"";
    [self.textFieldPhoneNumber becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            //TODO:goV
        }else{
            StartSetPasswordViewController *vc = [[StartSetPasswordViewController alloc]initWithNibName:@"StartSetPasswordViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            vc.hidesBackButton = YES;
        }
    }
}
@end
