//
//  DiscountDetailViewCell.h
//  VLingPai
//
//  Created by Mac on 14-8-20.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscountDetailModel.h"

@interface DiscountDetailViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labLoginMethod;
@property (weak, nonatomic) IBOutlet UILabel *labIPAddress;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgBG;

@property (strong, nonatomic) DiscountDetailModel *model;
@end
