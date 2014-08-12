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

@interface VerificationViewController ()<ZXingDelegate>

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
    
    
//    self.isScanView = YES;
}

#pragma mark - ZXingDelegate
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result{
    NSLog(@"%@",result);
    [controller dismissModalViewControllerAnimated:NO];
    
    //TODO:结果处理
    if ([result isEqualToString:@"123456"]) {
        ConnecteDiscountViewController *vc = [[ConnecteDiscountViewController alloc]initWithNibName:@"ConnecteDiscountViewController" bundle:nil];
//        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        LogInSystemViewController *vc = [[LogInSystemViewController alloc]initWithNibName:@"LogInSystemViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnScanQRCodeAction:(UIButton *)sender {
    [self loadZxingViewController];
}
@end
