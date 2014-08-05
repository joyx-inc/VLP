//
//  SetQuestionViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "SetQuestionViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"

@interface SetQuestionViewController ()<MBProgressHUDDelegate>

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
    
    self.title = @"设置密保";
    self.navigationItem.hidesBackButton = YES;
    
    self.myPickerContentView.frame = CGRectMake(0, DeviceHeight, 320, 192);
    
    self.pickDataList = @[@"你父亲叫什么名字？",@"你爱人叫什么名字？",@"你高中班主任叫什么名字？",@"你最喜欢的电影叫什么？",@"你最喜欢的歌曲叫什么？"];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickDataList.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.pickDataList objectAtIndex:row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnChooeseQuestionAction:(UIButton *)sender {
    [self showPickContentView];
}

- (IBAction)btnSaveAction:(UIButton *)sender {
    if (self.textFieldAnswer.text.length > 0) {
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
        
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.delegate = self;
        HUD.labelText = @"成功设置密保问题";
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        
        [[NSUserDefaults standardUserDefaults] setObject:self.btnChooeseQuestion.titleLabel.text forKey:TheQuestion];
        [[NSUserDefaults standardUserDefaults] setObject:self.textFieldAnswer.text forKey:TheQuestionAnswer];
        
        
        [self performSelector:@selector(goVericationView) withObject:nil afterDelay:2];
        
        
        
    }
}

- (IBAction)btnCancelAction:(UIButton *)sender {
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"放弃密保问题您将无法恢复密码，请谨慎操作" delegate:self cancelButtonTitle:@"继续设置" otherButtonTitles:@"我知道了", nil];
//    [alert show];
}

- (IBAction)btnHiddenPickerView:(UIButton *)sender {
    [self hiddenPickContentView];
}

- (IBAction)btnChooesePickerData:(UIButton *)sender {
    NSInteger row = [self.myPickerView selectedRowInComponent:0];
    [self.btnChooeseQuestion setTitle:[self.pickDataList objectAtIndex:row] forState:UIControlStateNormal];
    
    [self hiddenPickContentView];
}

-(void)goVericationView{
    //TODO:去扫码/令牌界面
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate initTabBarController];
}

-(void)showPickContentView{
    if (self.myPickerContentView.frame.origin.y < DeviceHeight) {
        return;
    }
    [UIView animateWithDuration:0.6 animations:^(void){
        CGRect frame = self.myPickerContentView.frame;
        frame.origin.y -= 192;
        self.myPickerContentView.frame = frame;
    }];
}
-(void)hiddenPickContentView{
    if (self.myPickerContentView.frame.origin.y >= DeviceHeight) {
        return;
    }
    [UIView animateWithDuration:0.6 animations:^(void){
        CGRect frame = self.myPickerContentView.frame;
        frame.origin.y += 192;
        self.myPickerContentView.frame = frame;
    }];
}


#pragma mark - UIAlertViewDelegate <NSObject>
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
