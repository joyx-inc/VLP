//
//  LogInSystemViewController.h
//  VLingPai
//
//  Created by Mac on 14-8-6.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AccountModel.h"
#import "SystemModel.h"

@interface LogInSystemViewController : UIViewController

@property (strong, nonatomic) AccountModel *accountModel;
@property (strong, nonatomic) SystemModel *systemModel;
@property (strong, nonatomic) NSString *scanResult;

@property (weak, nonatomic) IBOutlet UILabel *labUserName;
@property (weak, nonatomic) IBOutlet UILabel *labSystemName;
- (IBAction)btnLogInAction:(UIButton *)sender;
- (IBAction)btnCancelAction:(UIButton *)sender;

@end
