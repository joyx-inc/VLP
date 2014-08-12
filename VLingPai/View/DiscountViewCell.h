//
//  DiscountViewCell.h
//  VLingPai
//
//  Created by Mac on 14-8-12.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiscountModel.h"
#import "EGOImageView.h"

@interface DiscountViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet EGOImageView *imageLogo;
@property (weak, nonatomic) IBOutlet UILabel *labSystemName;
@property (weak, nonatomic) IBOutlet UILabel *labDiscount;
@property (weak, nonatomic) IBOutlet UILabel *labUseCount;

@property (strong, nonatomic) DiscountModel *model;


@end
