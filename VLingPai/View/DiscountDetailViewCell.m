//
//  DiscountDetailViewCell.m
//  VLingPai
//
//  Created by Mac on 14-8-20.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "DiscountDetailViewCell.h"

@implementation DiscountDetailViewCell

- (void)awakeFromNib
{
    // Initialization code
    
    self.imgBG.image = [[UIImage imageNamed:@"discountDetail_cell_image2.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 9, 1, 1)];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(DiscountDetailModel *)model{
    if (!model) {
        return;
    }
    self.labLoginMethod.text = model.logInMethod;
    self.labIPAddress.text = model.ipAddress;
    self.labTime.text = model.time;
}
- (void)dealloc
{
    self.model = nil;
}
@end
