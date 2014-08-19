//
//  ImportPhoneNumberViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "ImportPhoneNumberViewController.h"
#import "MBProgressHUD.h"
#import "StartSetPasswordViewController.h"
#import "RegexKitLite.h"
#import "AppDelegate.h"

#import "BindPhoneInterface.h"
#import "UIColor+GetColorFromString.h"

@interface ImportPhoneNumberViewController ()<MBProgressHUDDelegate,BindPhoneInterfaceDelegate>{
    UIImage *imageActive;
    UIImage *imageNormal;
    CGSize keyboardSize;
}

@property (strong, nonatomic) BindPhoneInterface *bindPhoneInterface;

@end

@implementation ImportPhoneNumberViewController

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
    
    self.title = @"绑定手机";
    
    self.bindPhoneInterface = [[BindPhoneInterface alloc]init];
    self.bindPhoneInterface.delegate = self;
    
    imageNormal = [[UIImage imageNamed:@"textField_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    
    imageActive = [[UIImage imageNamed:@"textField_bg_active.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];

    self.textFieldPhoneNumber.background = imageNormal;
    self.textFieldVericationCode.background = imageNormal;
    
    self.btnGetVerificationCode.layer.masksToBounds = YES;
    self.btnGetVerificationCode.layer.cornerRadius = 1.5f;
    
    self.btnGoNext.layer.masksToBounds = YES;
    self.btnGoNext.layer.cornerRadius = 1.5f;
    
    
    //键盘将要出现时的触发事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:)name:UIKeyboardWillShowNotification object:nil];
    
    //键盘将要消失时的触发事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillBeHidden:)name:UIKeyboardWillHideNotification object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnGoNextAction:(UIButton *)sender {
    if ([self.textFieldVericationCode.text isEqualToString:@"123456"]) {
        [self.textFieldVericationCode resignFirstResponder];
        [self.bindPhoneInterface bindPhoneNum:self.textFieldPhoneNumber.text];
    }else{
        [self.textFieldVericationCode resignFirstResponder];
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark_wrong.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"您输入的验证码不正确";
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        
        self.textFieldVericationCode.text = @"";
    }
}

- (IBAction)btnGetVerificationCode:(UIButton *)sender {
    if (self.isTimeing) {
        return;
    }
    
    [self.textFieldPhoneNumber resignFirstResponder];
    
    if (self.textFieldPhoneNumber.text.length > 0) {
        
        NSString *phoneRegular = @"(1[345]\\d{9})|(18\\d{9})|(0\\d{9,10})";
        NSArray *result = [self.textFieldPhoneNumber.text componentsMatchedByRegex:phoneRegular];
        if (result.count > 0) {
            MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            
            HUD.mode = MBProgressHUDModeCustomView;
            
            HUD.delegate = self;
            HUD.labelText = @"发送成功";
            
            [HUD show:YES];
            [HUD hide:YES afterDelay:2];
            
            self.secondView.hidden = NO;
            
            
            [self startTime];
            
//            self.isTimeing = YES;
//            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setBtnGetVerificationCodeTitle:) userInfo:nil repeats:YES];
//            self.timeCount = 60;

        }else{
            MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            [self.navigationController.view addSubview:HUD];
            
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark_wrong.png"]];
            
            HUD.mode = MBProgressHUDModeCustomView;
            
            HUD.delegate = self;
            HUD.labelText = @"请输入正确的手机号";
            
            [HUD show:YES];
            [HUD hide:YES afterDelay:2];
            
            [self performSelector:@selector(textFieldBecomeFirstResponder) withObject:nil afterDelay:2];
        }
    }else{
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark_wrong.png"]];
        
        HUD.mode = MBProgressHUDModeCustomView;
        
        HUD.delegate = self;
        HUD.labelText = @"手机号不能为空";
        
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
        
        [self performSelector:@selector(textFieldBecomeFirstResponder) withObject:nil afterDelay:2];
    }
}


-(void)startTime{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_btnGetVerificationCode setTitle:@"重新发送验证码到手机" forState:UIControlStateNormal];
                _btnGetVerificationCode.userInteractionEnabled = YES;
                [_btnGetVerificationCode setBackgroundColor:[UIColor getColorFromString:@"#397ed3ff"]];
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
//                NSLog(@"____%@",strTime);
                [_btnGetVerificationCode setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                _btnGetVerificationCode.userInteractionEnabled = NO;
                [_btnGetVerificationCode setBackgroundColor:[UIColor getColorFromString:@"#a4c7f4ff"]];
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.textFieldPhoneNumber resignFirstResponder];
    self.textFieldPhoneNumber.background = imageNormal;
    [self.textFieldVericationCode resignFirstResponder];
    self.textFieldVericationCode.background = imageNormal;
}

-(void)textFieldBecomeFirstResponder{
    self.textFieldPhoneNumber.text = @"";
    [self.textFieldPhoneNumber becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    textField.background = imageNormal;
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.background = imageActive;
}

-(void)goSetQuestionVC{
    StartSetPasswordViewController *vc = [[StartSetPasswordViewController alloc]initWithNibName:@"StartSetPasswordViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    vc.hidesBackButton = YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex == 0) {
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate initTabBarController];
            appDelegate.tabBarController.selectedIndex = 0;
            UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
            [nav popToRootViewControllerAnimated:YES];
        }else{
            StartSetPasswordViewController *vc = [[StartSetPasswordViewController alloc]initWithNibName:@"StartSetPasswordViewController" bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
            vc.hidesBackButton = YES;
        }
    }
}

#pragma mark - BindPhoneInterfaceDelegate <NSObject>
-(void)getFinishedBindPhoneInterface:(NSString *)status secrect:(NSString *)secrect{
    if ([status isEqualToString:@"ok"]) {
        //成功
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"绑定成功" message:@"是否设置启动密码" delegate:self cancelButtonTitle:@"跳过" otherButtonTitles:@"去设置", nil];
        [alert show];
        alert.tag = 100;
        
        [[NSUserDefaults standardUserDefaults] setObject:self.textFieldPhoneNumber.text forKey:UserBindPhoneNumber];
    }else if ([status isEqualToString:@"exist"]){
        //手机号已绑定其它设备
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:HUD];
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark_wrong.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.delegate = self;
        HUD.labelText = @"手机号已绑定其它设备";
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
    }
}
-(void)getFailedBindPhoneInterface:(NSString *)error{
    DebugLog(@"%@",error);
}

-(void)keyboardWillShow:(NSNotification *)notification
{
    
    if ([self.textFieldVericationCode isFirstResponder]) {
        
        NSDictionary *info = [notification userInfo];
        NSValue *value = [info objectForKey:@"UIKeyboardFrameEndUserInfoKey"];
        keyboardSize = [value CGRectValue].size;//获取键盘的size值
        //    NSLog(@"value %@ %f",value,keyboardSize.height);
        //获取键盘出现的动画时间
        //    NSValue *animationDurationValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        //    NSTimeInterval animationDuration;
        //    [animationDurationValue getValue:&animationDuration];
        //    CGFloat height =0 - keyboardSize.height +44;//加上导航栏的高度44
        //    NSLog(@"height = %f",height);
        //    NSTimeInterval animation = animationDuration;
        
        //视图移动的动画开始
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        CGRect frame =CGRectMake(self.view.frame.origin.x, -keyboardSize.height, self.view.frame.size.width,self.view.frame.size.height);
        self.view.frame = frame;
        [UIView commitAnimations];
    }

}

-(void)keyboardWillBeHidden:(NSNotification *)aNotification
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    CGRect frame =CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width,self.view.frame.size.height);
    self.view.frame = frame;
    [UIView commitAnimations];
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
