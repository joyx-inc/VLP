//
//  VerificationViewController.h
//  VLingPai
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//


//令牌主界面，包含扫码验证和数字令牌（需要在设置开启，默认关闭）

#import <UIKit/UIKit.h>


@interface VerificationViewController : UIViewController

@property (strong, nonatomic) NSString *scanResult;
//@property (assign, nonatomic) BOOL isScanView;

- (IBAction)btnScanQRCodeAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnScanQRCode;

@end
