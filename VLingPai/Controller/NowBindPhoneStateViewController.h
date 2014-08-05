//
//  NowBindPhoneStateViewController.h
//  VLingPai
//
//  Created by Mac on 14-8-5.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NowBindPhoneStateViewController : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labPhoneNumber;

- (IBAction)btnResetPhoneNumber:(UIButton *)sender;
@end
