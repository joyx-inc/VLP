//
//  DiscountDetailViewController.h
//  VLingPai
//
//  Created by Mac on 14-8-20.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscountDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *arraySection;
@property (strong, nonatomic) NSArray *arrayModel;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end
