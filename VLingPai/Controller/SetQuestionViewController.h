//
//  SetQuestionViewController.h
//  VLingPai
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetQuestionViewController : UIViewController<UIAlertViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnChooeseQuestion;
- (IBAction)btnChooeseQuestionAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAnswer;

- (IBAction)btnSaveAction:(UIButton *)sender;
- (IBAction)btnCancelAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

- (IBAction)btnHiddenPickerView:(UIButton *)sender;
- (IBAction)btnChooesePickerData:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;
@property (weak, nonatomic) IBOutlet UIView *myPickerContentView;

@property (strong, nonatomic) NSArray *pickDataList;
@property (assign, nonatomic) BOOL haveChooeseQuestion;


@end
