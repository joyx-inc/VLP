//
//  OneClickViewController.h
//  VLingPai
//
//  Created by Mac on 14-8-13.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountAndSystemModel.h"

@interface OneClickViewController : UIViewController

@property (strong, nonatomic) AccountAndSystemModel *asModel;

@property (strong, nonatomic) NSString *logInURL;
@property (strong, nonatomic) NSString *cancelURL;

@property (weak, nonatomic) IBOutlet UILabel *labSystemName;
@property (weak, nonatomic) IBOutlet UILabel *labAccount;

- (IBAction)btnLogInAction:(UIButton *)sender;
- (IBAction)btnCancelAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

@end
