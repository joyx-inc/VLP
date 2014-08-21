//
//  ConnecteSuccessViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-6.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "ConnecteSuccessViewController.h"


@interface ConnecteSuccessViewController ()

@end

@implementation ConnecteSuccessViewController

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
    
    self.title = @"关联成功";
    
    self.btnGoBack.layer.masksToBounds = YES;
    self.btnGoBack.layer.cornerRadius = 1.5f;
    
    self.labSystemName.text = self.systemModel.systemName;
    self.labAccount.text = self.accountModel.account;
    self.labAccountName.text = self.accountModel.displayName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnGoBackAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)dealloc{
    self.accountModel = nil;
    self.systemModel = nil;
}
@end
