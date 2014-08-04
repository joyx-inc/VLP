//
//  SetQuestionViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "SetQuestionViewController.h"

@interface SetQuestionViewController ()

@end

@implementation SetQuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSaveAction:(UIButton *)sender {
}

- (IBAction)btnCancelAction:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"" delegate:self cancelButtonTitle:@"继续设置" otherButtonTitles:@"我知道了", nil];
    [alert show];
}

#pragma mark - UIAlertViewDelegate <NSObject>
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}
@end
