//
//  InputQuestionAnswerViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-4.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "InputQuestionAnswerViewController.h"
#import "MBProgressHUD.h"
//#import "SetStartPasswordViewController.h"
#import "StartSetPasswordViewController.h"
#import "AppDelegate.h"

@interface InputQuestionAnswerViewController ()<MBProgressHUDDelegate>{
    UIImage *imageActive;
    UIImage *imageNormal;
}

@end

@implementation InputQuestionAnswerViewController

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
    
    self.labQuestion.text = [[NSUserDefaults standardUserDefaults] objectForKey:TheQuestion];
    
    self.btnGoNext.layer.masksToBounds = YES;
    self.btnGoNext.layer.cornerRadius = 1.5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goNextAction:(UIButton *)sender {
    NSString *theAnswer = [[NSUserDefaults standardUserDefaults] objectForKey:TheQuestionAnswer];
    if ([self.textFieldAnswer.text isEqualToString:theAnswer]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"密码删除成功" message:@"请选择" delegate:self cancelButtonTitle:@"直接使用" otherButtonTitles:@"设置新密码", nil];
        [alert show];
        alert.tag = 100;
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:StartPassword];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:TheQuestion];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:TheQuestionAnswer];

    }else{
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark_wrong.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"您输入的答案不正确";
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
    }    
}

#pragma mark - UIAlertViewDelegate <NSObject>
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            //直接使用
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate initTabBarController];
            appDelegate.tabBarController.selectedIndex = 0;
            UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
            [nav popToRootViewControllerAnimated:YES];
        }else{
            //更新密码
            StartSetPasswordViewController *vc = [[StartSetPasswordViewController alloc]initWithNibName:@"StartSetPasswordViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.background = imageActive;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    textField.background = imageNormal;
    return YES;
}
@end
