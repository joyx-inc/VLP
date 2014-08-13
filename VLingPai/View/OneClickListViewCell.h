//
//  OneClickListViewCell.h
//  VLingPai
//
//  Created by Mac on 14-8-13.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "AccountAndSystemModel.h"

@interface OneClickListViewCell : UITableViewCell

@property (strong, nonatomic) AccountAndSystemModel *asModel;

@property (weak, nonatomic) IBOutlet EGOImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *labSystemName;
@property (weak, nonatomic) IBOutlet UILabel *labAccountName;

@end
