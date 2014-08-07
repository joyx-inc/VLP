//
//  LogInSystemViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-6.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "LogInSystemViewController.h"
#import "MBProgressHUD.h"

@interface LogInSystemViewController ()<MBProgressHUDDelegate>

@end

@implementation LogInSystemViewController

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

- (IBAction)btnLogInAction:(UIButton *)sender {
    //TODO:联网登录确认
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = @"登录完成";
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
    
    [self performSelector:@selector(btnCancelAction:) withObject:nil afterDelay:2];
    
}

- (IBAction)btnCancelAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
