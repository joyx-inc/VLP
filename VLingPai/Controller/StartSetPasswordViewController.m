//
//  StartSetPasswordViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "StartSetPasswordViewController.h"
#import "SetStartPasswordViewController.h"

@interface StartSetPasswordViewController ()

@end

@implementation StartSetPasswordViewController

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
    
    if (self.hidesBackButton) {
        self.navigationItem.hidesBackButton = YES;
    }
    
    self.btnSetPassword.layer.masksToBounds = YES;
    self.btnSetPassword.layer.cornerRadius = 1.5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goSetStartPasswordAction:(UIButton *)sender {
    SetStartPasswordViewController *vc = [[SetStartPasswordViewController alloc]initWithNibName:@"SetStartPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
