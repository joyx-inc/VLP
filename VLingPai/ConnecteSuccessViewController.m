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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnGoBackAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
