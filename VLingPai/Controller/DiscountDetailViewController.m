//
//  DiscountDetailViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-20.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "DiscountDetailViewController.h"
#import "DiscountDetailViewCell.h"
#import "DiscountDetail_cell_header.h"
#import "DiscountDetailModel.h"
#import "UIColor+GetColorFromString.h"

@interface DiscountDetailViewController ()

@end

@implementation DiscountDetailViewController

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
    
    self.title = @"账号登录记录";
    
    
    //Test Data
    self.arraySection = @[@"今天",@"昨天",@"前天",@"2014-8-17",@"2014-8-16"];
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++) {
        DiscountDetailModel *model = [[DiscountDetailModel alloc]initWithDictionary:@{@"method":@"用户名密码登录",@"ip":@"10.0.0.1",@"time":@"12:12"}];
        [array addObject:model];
        DiscountDetailModel *model2 = [[DiscountDetailModel alloc]initWithDictionary:@{@"method":@"扫码登录",@"ip":@"10.0.0.1",@"time":@"12:12"}];
        [array addObject:model2];
        DiscountDetailModel *model3 = [[DiscountDetailModel alloc]initWithDictionary:@{@"method":@"一键登录",@"ip":@"10.0.0.1",@"time":@"12:12"}];
        [array addObject:model3];
    }
    DiscountDetailModel *model2 = [[DiscountDetailModel alloc]initWithDictionary:@{@"method":@"扫码登录",@"ip":@"10.0.0.1",@"time":@"12:12"}];
    [array addObject:model2];
    DiscountDetailModel *model3 = [[DiscountDetailModel alloc]initWithDictionary:@{@"method":@"一键登录",@"ip":@"10.0.0.1",@"time":@"12:12"}];
    [array addObject:model3];
    DiscountDetailModel *model = [[DiscountDetailModel alloc]initWithDictionary:@{@"method":@"账号绑定",@"ip":@"10.0.0.1",@"time":@"12:12"}];
    [array addObject:model];
    //END
    
    self.arrayModel = array;
    
    UIButton *buttonClear = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonClear setTitle:@"清空" forState:UIControlStateNormal];
    [buttonClear setTitleColor:[UIColor getColorFromString:@"#0a5ffeff"] forState:UIControlStateNormal];
//    [buttonClear setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    buttonClear.frame = CGRectMake(0, 0, 50, 44);
    [buttonClear addTarget:self action:@selector(btnClearAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithCustomView:buttonClear];
    self.navigationItem.rightBarButtonItem = rightBar;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arraySection.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section +1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 38;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    DiscountDetail_cell_header *view = [[[NSBundle mainBundle] loadNibNamed:@"DiscountDetail_cell_header" owner:self options:nil]objectAtIndex:0];
    view.date = [self.arraySection objectAtIndex:section];
    
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return nil;
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor getColorFromString:@"#F4F4F4FF"];
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    DiscountDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DiscountDetailViewCell" owner:self options:nil]objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = [self.arrayModel objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)btnClearAction{
    self.arrayModel = nil;
    self.arraySection = nil;
    [self.myTableView reloadData];
}

- (void)dealloc
{
    self.arraySection = nil;
    self.arrayModel = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
