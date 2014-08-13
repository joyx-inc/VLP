//
//  LogInSystemViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-6.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "LogInSystemViewController.h"
#import "MBProgressHUD.h"

#import "ScanLoginInterface.h"

@interface LogInSystemViewController ()<MBProgressHUDDelegate,ScanLoginInterfaceDelegate>

@property (strong, nonatomic) ScanLoginInterface *scanLoginInterface;

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
    
    NSString *accountName = self.accountModel.displayName;
    NSString *account = self.accountModel.account;
    if (accountName.length == 1){
        self.labUserName.text = [NSString stringWithFormat:@"%@(%@)",account,accountName];
    }else if (accountName.length == 2){
        NSString *str = [accountName substringWithRange:NSMakeRange(0, 1)];
        self.labUserName.text = [NSString stringWithFormat:@"%@(%@*)",account,str];
    }else if(accountName.length > 2){
        NSString *str1 = [accountName substringWithRange:NSMakeRange(0, 1)];
        NSString *str2 = [accountName substringWithRange:NSMakeRange(accountName.length - 1, 1)];
        self.labUserName.text = [NSString stringWithFormat:@"%@(%@*%@)",account,str1,str2];
    }else{
        self.labUserName.text = account;
    }
    
    self.labSystemName.text = [NSString stringWithFormat:@"登录:%@",self.systemModel.systemName];
    
    
    self.scanLoginInterface = [[ScanLoginInterface alloc]init];
    self.scanLoginInterface.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLogInAction:(UIButton *)sender {
    //TODO:联网登录确认
    
    [self.scanLoginInterface scanLoginSystem:self.scanResult];
    
}

- (IBAction)btnCancelAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
        
        [self performSelector:@selector(btnCancelAction:) withObject:nil afterDelay:2];
        
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
        
        [self performSelector:@selector(btnCancelAction:) withObject:nil afterDelay:2];
    }
}
-(void)getFailedScanLoginInterface:(NSString *)error{
    DebugLog(@"%@",error);
}

- (void)dealloc
{
    self.accountModel = nil;
    self.systemModel = nil;
    self.scanResult = nil;
    
    self.scanLoginInterface.delegate = nil;
    self.scanLoginInterface = nil;
}
@end
