//
//  FirstViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#import "ImportPhoneNumberViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

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

- (IBAction)startAction:(UIButton *)sender {
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    [appDelegate initTabBarController];
//    
////    UINavigationController *nav = (UINavigationController *)appDelegate.tabBarController.selectedViewController;
    
    ImportPhoneNumberViewController *vc = [[ImportPhoneNumberViewController alloc]initWithNibName:@"ImportPhoneNumberViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
