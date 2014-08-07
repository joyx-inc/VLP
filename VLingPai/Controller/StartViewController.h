//
//  StartViewController.h
//  VLingPai
//
//  Created by Mac on 14-8-4.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LockViewController.h"

@interface StartViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labOutput;

@property (strong, nonatomic) LockViewController *lockVC;
@property (assign, nonatomic) NSInteger inputCount;

- (IBAction)btnForgetPasswordAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *viewBtnForget;

@property (assign, nonatomic) int watingCount;

@property (assign, nonatomic) BOOL isStart;  // NO 为是锁屏界面， YES 不是！！
@end
