//
//  DiscountViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "DiscountViewController.h"
#import "DiscountModel.h"
#import "DiscountViewCell.h"

@interface DiscountViewController ()

@end

@implementation DiscountViewController

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
    
    self.title = @"账号";
    
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        DiscountModel *model = [[DiscountModel alloc]init];
        model.logoURLStr = @"";
        model.systemName = @"xx系统";
        model.discountStr = @"admin";
        model.useCount = i * 100;
        [array addObject:model];
    }
    self.list = array;
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    cell.textLabel.text = [self.list objectAtIndex:indexPath.row];
    
    DiscountViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DiscountViewCell" owner:self options:nil] objectAtIndex:0];
    }
    cell.model = [self.list objectAtIndex:indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
            
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
