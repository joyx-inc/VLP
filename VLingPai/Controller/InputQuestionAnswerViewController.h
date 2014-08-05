//
//  InputQuestionAnswerViewController.h
//  VLingPai
//
//  Created by Mac on 14-8-4.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputQuestionAnswerViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labQuestion;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAnswer;
- (IBAction)goNextAction:(UIButton *)sender;

@end
