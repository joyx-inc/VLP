//
//  ConnecteDiscountViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-6.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "ConnecteDiscountViewController.h"
#import "MBProgressHUD.h"
#import "ConnecteSuccessViewController.h"

@interface ConnecteDiscountViewController ()<MBProgressHUDDelegate>

@end

@implementation ConnecteDiscountViewController

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

- (IBAction)btnConnectDiscountAction:(UIButton *)sender {
    [sender setTitle:@"等待电脑关联完成" forState:UIControlStateNormal];
    [self performSelector:@selector(showSuccessView) withObject:nil afterDelay:3];
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请在电脑上打开http://www.xxx.com 进行关联" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
//    alert.tag = 100;
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (alertView.tag == 100) {
//        [self performSelector:@selector(showSuccessView) withObject:nil afterDelay:3];
//    }
//}

-(void)showSuccessView{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = @"关联成功";
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
    
    [self performSelector:@selector(goSuccessView) withObject:nil afterDelay:2];
}

-(void)goSuccessView{
    ConnecteSuccessViewController *vc = [[ConnecteSuccessViewController alloc]initWithNibName:@"ConnecteSuccessViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)btnCancelAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
