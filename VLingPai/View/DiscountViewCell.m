//
//  DiscountViewCell.m
//  VLingPai
//
//  Created by Mac on 14-8-12.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "DiscountViewCell.h"

@implementation DiscountViewCell

- (void)awakeFromNib
{
    // Initialization code
}

-(void)setModel:(DiscountModel *)model{
    if (model == nil) {
        return;
    }
    
    _model = model;
    
    self.imageLogo.imageURL = [NSURL URLWithString:model.logoURLStr];
    self.labSystemName.text = model.systemName;
    self.labDiscount.text = model.discountStr;
    self.labUseCount.text = [NSString stringWithFormat:@"%d次",model.useCount];
    
}

-(void)dealloc{
    self.model = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
