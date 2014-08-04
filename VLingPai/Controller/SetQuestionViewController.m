//
//  SetQuestionViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "SetQuestionViewController.h"
#import "MBProgressHUD.h"

@interface SetQuestionViewController ()<MBProgressHUDDelegate>

@end

@implementation SetQuestionViewController

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
    
    self.title = @"设置密保";
    self.navigationItem.hidesBackButton = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnChooeseQuestionAction:(UIButton *)sender {
    
}

- (IBAction)btnSaveAction:(UIButton *)sender {
    if (self.textFieldAnswer.text.length > 0) {
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.delegate = self;
        HUD.labelText = @"成功设置密保问题";
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.btnChooeseQuestion.titleLabel.text forKey:TheQuestion];
        [[NSUserDefaults standardUserDefaults] setObject:self.textFieldAnswer forKey:TheQuestionAnswer];
        
        [self performSelector:@selector(goVericationView) withObject:nil afterDelay:2];
    }
}

- (IBAction)btnCancelAction:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"放弃密保问题您将无法恢复密码，请谨慎操作" delegate:self cancelButtonTitle:@"继续设置" otherButtonTitles:@"我知道了", nil];
    [alert show];
}

-(void)goVericationView{
    //TODO:去扫码/令牌界面
    
}

#pragma mark - UIAlertViewDelegate <NSObject>
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
