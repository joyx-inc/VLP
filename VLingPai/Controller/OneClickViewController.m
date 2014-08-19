//
//  OneClickViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-13.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "OneClickViewController.h"
#import "ScanLoginInterface.h"
#import "ScanLoginCancelInterface.h"
#import "MBProgressHUD.h"

@interface OneClickViewController ()<ScanLoginInterfaceDelegate,MBProgressHUDDelegate>

@property (strong, nonatomic) ScanLoginInterface *scanLoginInterface;
@property (strong, nonatomic) ScanLoginCancelInterface *scanLoginCancelInterface;

@end

@implementation OneClickViewController

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
    
    self.title = @"一键身份认证";
    
    self.logInURL = [NSString stringWithFormat:@"%@vlp/api/qrscan/%@",BASE_INTERFACE_DOMAIN,self.asModel.code];
    self.cancelURL = [NSString stringWithFormat:@"%@vlp/api/qrscan/%@",BASE_INTERFACE_DOMAIN,self.asModel.code];
    
    self.labSystemName.text = self.asModel.systemModel.systemName;
    self.labAccount.text = self.asModel.accountModel.account;
    
    self.scanLoginInterface = [[ScanLoginInterface alloc]init];
    self.scanLoginInterface.delegate = self;
    
    self.scanLoginCancelInterface = [[ScanLoginCancelInterface alloc]init];
    
    self.btnLogin.layer.masksToBounds = YES;
    self.btnLogin.layer.cornerRadius = 1.5f;
    self.btnCancel.layer.masksToBounds = YES;
    self.btnCancel.layer.cornerRadius = 1.5f;
}

#pragma mark - ScanLoginInterfaceDelegate <NSObject>
-(void)getFinishedScanLoginInterface:(NSString *)status{
    if ([status isEqualToString:@"ok"]) {
        //成功
        
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"登录完成";
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        
        [self performSelector:@selector(dismissView) withObject:nil afterDelay:2];
        
    }else if ([status isEqualToString:@"expried"]){
        //二维码已过期
        
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark_wrong.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"登录失败，二维码已过期";
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        
        [self performSelector:@selector(dismissView) withObject:nil afterDelay:2];
    }
}
-(void)getFailedScanLoginInterface:(NSString *)error{
    DebugLog(@"%@",error);
}

- (void)dealloc
{
    self.asModel = nil;
    self.logInURL = nil;
    self.cancelURL = nil;
    self.scanLoginInterface.delegate = nil;
    self.scanLoginInterface = nil;
    self.scanLoginCancelInterface = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLogInAction:(UIButton *)sender {
    [self.scanLoginInterface scanLoginSystem:self.logInURL];
}

- (IBAction)btnCancelAction:(UIButton *)sender {
    [self.scanLoginCancelInterface scanCancelLoginAction:self.cancelURL];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)dismissView{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
