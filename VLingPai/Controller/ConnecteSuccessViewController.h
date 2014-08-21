//
//  ConnecteSuccessViewController.h
//  VLingPai
//
//  Created by Mac on 14-8-6.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AccountModel.h"
#import "SystemModel.h"

@interface ConnecteSuccessViewController : UIViewController

@property (strong, nonatomic) AccountModel *accountModel;
@property (strong, nonatomic) SystemModel *systemModel;

- (IBAction)btnGoBackAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnGoBack;

@property (weak, nonatomic) IBOutlet UILabel *labSystemName;
@property (weak, nonatomic) IBOutlet UILabel *labAccount;
@property (weak, nonatomic) IBOutlet UILabel *labAccountName;


@end
