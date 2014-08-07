//
//  LogInSystemViewController.h
//  VLingPai
//
//  Created by Mac on 14-8-6.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogInSystemViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labUserName;
@property (weak, nonatomic) IBOutlet UILabel *labSystemName;
- (IBAction)btnLogInAction:(UIButton *)sender;
- (IBAction)btnCancelAction:(UIButton *)sender;

@end
