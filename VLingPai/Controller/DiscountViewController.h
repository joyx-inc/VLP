//
//  DiscountViewController.h
//  VLingPai
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscountViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSArray *list;

@end
