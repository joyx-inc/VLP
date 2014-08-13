//
//  VerificationViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "VerificationViewController.h"
//#import ""
#import <ZXingWidgetController.h>
#import <QRCodeReader.h>

#import "ConnecteDiscountViewController.h"
#import "LogInSystemViewController.h"
#import "UploadScanResultInterface.h"
#import "MBProgressHUD.h"

@interface VerificationViewController ()<ZXingDelegate,UploadScanResultInterfaceDelegate,MBProgressHUDDelegate>

@property (strong, nonatomic) UploadScanResultInterface *uploadScanResultInterface;

@property (strong, nonatomic) MBProgressHUD *uploadResultHub;

@end

@implementation VerificationViewController

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
    
    self.title = @"微令牌";
    
    self.uploadScanResultInterface = [[UploadScanResultInterface alloc]init];
    self.uploadScanResultInterface.delegate = self;
    
    
//    self.isScanView = YES;
}

#pragma mark - ZXingDelegate
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result{
    DebugLog(@"%@",result);
    [controller dismissModalViewControllerAnimated:NO];
    
    self.scanResult = result;
    
    //TODO:结果处理
    
    [self.uploadScanResultInterface uploadScanResult:result];
    
    self.uploadResultHub = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:self.uploadResultHub];
	self.uploadResultHub.delegate = self;
	self.uploadResultHub.labelText = @"正在处理中，请稍后";
    [self.uploadResultHub show:YES];
    
    
//    if ([result isEqualToString:@"123456"]) {
//        ConnecteDiscountViewController *vc = [[ConnecteDiscountViewController alloc]initWithNibName:@"ConnecteDiscountViewController" bundle:nil];
////        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else{
//        LogInSystemViewController *vc = [[LogInSystemViewController alloc]initWithNibName:@"LogInSystemViewController" bundle:nil];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}
- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller{
    [controller dismissModalViewControllerAnimated:YES];
}
-(void)loadZxingViewController{
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
    NSMutableSet *readers = [[NSMutableSet alloc ] init];
    QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
    widController.readers = readers;
    
    [self presentViewController:widController animated:YES completion:nil];
}

#pragma mark - UploadScanResultInterfaceDelegate <NSObject>
-(void)getFinishedForUploadScanResultInterface:(NSString *)status system:(SystemModel *)systemModel account:(AccountModel *)accountModel{
    [self.uploadResultHub hide:YES];
    
    if ([status isEqualToString:@"ok"]) {
        //成功
        if (!accountModel.account) {
            //首次使用，没有绑定过账号
            ConnecteDiscountViewController *vc = [[ConnecteDiscountViewController alloc]initWithNibName:@"ConnecteDiscountViewController" bundle:nil];
            vc.systemModel = systemModel;
            vc.scanResult = self.scanResult;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            LogInSystemViewController *vc = [[LogInSystemViewController alloc]initWithNibName:@"LogInSystemViewController" bundle:nil];
            vc.accountModel = accountModel;
            vc.systemModel = systemModel;
            vc.scanResult = self.scanResult;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        //二维码已过期
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark_wrong.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"登录失败，二维码已过期";
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
    }
}
-(void)getFailedForUploadScanResultInterface:(NSString *)str{
    [self.uploadResultHub hide:YES];
    DebugLog(@"%@",str);
    
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark_wrong.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = @"结果处理失败，请重试";
    [HUD show:YES];
    [HUD hide:YES afterDelay:2];
}

- (IBAction)btnScanQRCodeAction:(UIButton *)sender {
    [self loadZxingViewController];
}

- (void)dealloc
{
    self.scanResult = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
