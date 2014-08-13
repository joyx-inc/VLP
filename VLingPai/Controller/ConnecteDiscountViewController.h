//
//  ConnecteDiscountViewController.h
//  VLingPai
//
//  Created by Mac on 14-8-6.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//


//首次使用关联账号界面
#import <UIKit/UIKit.h>

//#import "AccountModel.h"
#import "SystemModel.h"

@interface ConnecteDiscountViewController : UIViewController<UIAlertViewDelegate>
- (IBAction)btnConnectDiscountAction:(UIButton *)sender;
- (IBAction)btnCancelAction:(UIButton *)sender;

@property (strong, nonatomic) SystemModel *systemModel;
@property (weak, nonatomic) IBOutlet UILabel *labSystemName;
@end
