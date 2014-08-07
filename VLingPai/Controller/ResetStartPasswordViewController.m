//
//  ResetStartPasswordViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-6.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "ResetStartPasswordViewController.h"
#import "MBProgressHUD.h"
#import "StartSetPasswordViewController.h"

@interface ResetStartPasswordViewController ()<MBProgressHUDDelegate>

@end

@implementation ResetStartPasswordViewController

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

- (IBAction)btnChangePassword:(UIButton *)sender {
    StartSetPasswordViewController *vc = [[StartSetPasswordViewController alloc]initWithNibName:@"StartSetPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnDeletePassword:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:StartPassword];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:TheQuestion];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:TheQuestionAnswer];
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    
    HUD.mode = MBProgressHUDModeCustomView;
    
    HUD.delegate = self;
    HUD.labelText = @"成功删除启动密码";
    
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
    
    [self performSelector:@selector(goBackAction) withObject:nil afterDelay:2];
}

-(void)goBackAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
