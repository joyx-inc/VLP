//
//  ImportPhoneNumberViewController.h
//  VLingPai
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImportPhoneNumberViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFieldPhoneNumber;

- (IBAction)btnGoNextAction:(UIButton *)sender;
- (IBAction)btnGetVerificationCode:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnGetVerificationCode;
@property (weak, nonatomic) IBOutlet UIButton *btnGoNext;

@property (weak, nonatomic) IBOutlet UITextField *textFieldVericationCode;

@property (weak, nonatomic) IBOutlet UIView *secondView;

//@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) NSInteger timeCount;
@property (assign, nonatomic) BOOL isTimeing;



@end
