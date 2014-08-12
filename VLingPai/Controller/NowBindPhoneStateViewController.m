//
//  NowBindPhoneStateViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-5.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "NowBindPhoneStateViewController.h"
#import "ImportPhoneNumberViewController.h"

@interface NowBindPhoneStateViewController ()

@end

@implementation NowBindPhoneStateViewController

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
    
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults] objectForKey:UserBindPhoneNumber];
    
    NSRange range1 = NSMakeRange(0, phoneNumber.length - 8);
    NSRange range2 = NSMakeRange(phoneNumber.length - 4, 4);
    
    NSString *str1 = [phoneNumber substringWithRange:range1];
    NSString *str2 = [phoneNumber substringWithRange:range2];
    
    NSString *text = [NSString stringWithFormat:@"%@****%@",str1,str2];
//    NSLog(@"%@",text);
    self.labPhoneNumber.text = text;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnResetPhoneNumber:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"重新绑定手机后，当前手机关联账号会请客，请谨慎操作，确定要重新绑定？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    alert.tag = 100;
}
#pragma mark - UIAlertViewDelegate <NSObject>
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"当前操作不可逆，请再次确认，确定要重新绑定？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            alert.tag = 200;
        }
    }else{
        if (buttonIndex == 1) {
            //TODO:清空用户数据
            
            
            ImportPhoneNumberViewController *vc = [[ImportPhoneNumberViewController alloc]initWithNibName:@"ImportPhoneNumberViewController" bundle:nil];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
@end
