//
//  SettingViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "SettingViewController.h"
#import "StartSetPasswordViewController.h"
#import "NowBindPhoneStateViewController.h"
#import "CalibrationTimeViewController.h"
#import "AboutViewController.h"

#import "StartViewController.h"

@interface SettingViewController ()

@property (strong, nonatomic) NSArray *imageList;

@end

@implementation SettingViewController

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
    
    self.title = @"设置";
    self.list = @[@"启动密码",@"手机绑定",@"数字令牌",@"关于"];
    
    self.imageList = @[[UIImage imageNamed:@"set_startPassword.png"],[UIImage imageNamed:@"set_bindPhone.png"],[UIImage imageNamed:@"set_digitalCode.png"],[UIImage imageNamed:@"set_about.png"]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor getColorFromString:@"#4d4d4dff"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    cell.imageView.image = [self.imageList objectAtIndex:indexPath.row];
    cell.textLabel.text = [self.list objectAtIndex:indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            //启动密码
            NSString *password = [[NSUserDefaults standardUserDefaults]objectForKey:StartPassword];
            NSString *theQuestion = [[NSUserDefaults standardUserDefaults] objectForKey:TheQuestion];
            NSString *theAnwser = [[NSUserDefaults standardUserDefaults] objectForKey:TheQuestionAnswer];
            if (password.length > 0 && theQuestion.length > 0 && theAnwser.length > 0) {
                //TODO:已经设置启动密码、密保
                StartViewController *vc = [[StartViewController alloc]initWithNibName:@"StartViewController" bundle:nil];
                vc.isStart = YES;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
//                vc.hidesBottomBarWhenPushed = NO;
            }else{
                //没有启动密码，直接设置密码
                StartSetPasswordViewController *vc = [[StartSetPasswordViewController alloc]initWithNibName:@"StartSetPasswordViewController" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 1:{
            //绑定手机
            NowBindPhoneStateViewController *vc = [[NowBindPhoneStateViewController alloc]initWithNibName:@"NowBindPhoneStateViewController" bundle:nil];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            //校准时间 改为 数字令牌
            CalibrationTimeViewController *vc = [[CalibrationTimeViewController alloc]initWithNibName:@"CalibrationTimeViewController" bundle:nil];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:{
            AboutViewController *vc = [[AboutViewController alloc]initWithNibName:@"AboutViewController" bundle:nil];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

-(void)dealloc{
    self.list = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
