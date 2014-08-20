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
#import "UIColor+GetColorFromString.h"

@interface SetQuestionViewController ()<MBProgressHUDDelegate>{
    UIImage *imageActive;
    UIImage *imageNormal;
}

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
    
    imageNormal = [[UIImage imageNamed:@"textField_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    imageActive = [[UIImage imageNamed:@"textField_bg_active.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    
    self.textFieldAnswer.background = imageNormal;
    
    
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
//    [self showPickContentView];
    if (!self.chooeseQuestionView) {
        [self initChooeseQuestionView];
    }
    [self.view bringSubviewToFront:self.chooeseQuestionView];
    self.chooeseQuestionView.hidden = NO;
}

- (IBAction)btnSaveAction:(UIButton *)sender {
    if (self.haveChooeseQuestion == NO) {
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark_wrong.png"]];
        
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.delegate = self;
        HUD.labelText = @"请选择密保问题";
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        
        return;
    }
    
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
      
    }else{
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark_wrong.png"]];
        
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.delegate = self;
        HUD.labelText = @"请输入密保答案";
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
    }
}

- (IBAction)btnCancelAction:(UIButton *)sender {
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"放弃密保问题您将无法恢复密码，请谨慎操作" delegate:self cancelButtonTitle:@"继续设置" otherButtonTitles:@"我知道了", nil];
//    [alert show];
}

//- (IBAction)btnHiddenPickerView:(UIButton *)sender {
//    [self hiddenPickContentView];
//}
//
//- (IBAction)btnChooesePickerData:(UIButton *)sender {
//    NSInteger row = [self.myPickerView selectedRowInComponent:0];
//    [self.btnChooeseQuestion setTitle:[self.pickDataList objectAtIndex:row] forState:UIControlStateNormal];
//    self.haveChooeseQuestion = YES;
//    [self hiddenPickContentView];
//}

-(void)goVericationView{
    self.navigationController.hidesBottomBarWhenPushed = NO;
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate initTabBarController];
    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
//    [nav popToRootViewControllerAnimated:NO];
    nav.hidesBottomBarWhenPushed = NO;
//    appDelegate.tabBarController.selectedIndex = 0;
}

//-(void)showPickContentView{
//    if (self.myPickerContentView.frame.origin.y < DeviceHeight) {
//        return;
//    }
//    [UIView animateWithDuration:0.6 animations:^(void){
//        CGRect frame = self.myPickerContentView.frame;
//        frame.origin.y -= 192;
//        self.myPickerContentView.frame = frame;
//    }];
//}
//-(void)hiddenPickContentView{
//    if (self.myPickerContentView.frame.origin.y >= DeviceHeight) {
//        return;
//    }
//    [UIView animateWithDuration:0.6 animations:^(void){
//        CGRect frame = self.myPickerContentView.frame;
//        frame.origin.y += 192;
//        self.myPickerContentView.frame = frame;
//    }];
//}


#pragma mark - UIAlertViewDelegate <NSObject>
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    textField.background = imageActive;
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    textField.background = imageNormal;
    [textField resignFirstResponder];
    return YES;
}

-(void)initChooeseQuestionView{
    self.chooeseQuestionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, DeviceHeight)];
    _chooeseQuestionView.backgroundColor = [UIColor getColorFromString:@"#00000080"];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, 280, self.pickDataList.count * 44)];
    tableView.layer.masksToBounds = YES;
    tableView.layer.cornerRadius = 5;
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.chooeseQuestionView addSubview:tableView];
    tableView.center = self.chooeseQuestionView.center;
    [tableView scrollRectToVisible:CGRectMake(0, 0, 280, 220) animated:NO];
    
    [self.view addSubview:self.chooeseQuestionView];
    [self.view sendSubviewToBack:self.chooeseQuestionView];
    self.chooeseQuestionView.hidden = YES;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.pickDataList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.textColor = [UIColor getColorFromString:@"#747474ff"];
    }
    
    if (indexPath.row == self.oldIndexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    if (self.oldIndexPath == nil) {
        self.oldIndexPath = indexPath;
    }
    
    cell.textLabel.text = [self.pickDataList objectAtIndex: indexPath.row];
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    UITableViewCell *cellOld = [tableView cellForRowAtIndexPath:self.oldIndexPath];
    cellOld.accessoryType = UITableViewCellAccessoryNone;
    
    self.oldIndexPath = indexPath;
    
    [self.view sendSubviewToBack:self.chooeseQuestionView];
    self.chooeseQuestionView.hidden = YES;
    
    [self.btnChooeseQuestion setTitle:[self.pickDataList objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    self.haveChooeseQuestion = YES;
    
}

- (void)dealloc
{
    self.chooeseQuestionView = nil;
    self.pickDataList = nil;
    self.oldIndexPath = nil;
}
@end
