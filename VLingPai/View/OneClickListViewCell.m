//
//  OneClickListViewCell.m
//  VLingPai
//
//  Created by Mac on 14-8-13.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "OneClickListViewCell.h"

@implementation OneClickListViewCell

- (void)awakeFromNib
{
    // Initialization code
}

-(void)setAsModel:(AccountAndSystemModel *)asModel{
    if (!asModel) {
        return;
    }
    
    _asModel = asModel;
    
    _labSystemName.text = asModel.systemModel.systemName;
    _labAccountName.text = asModel.accountModel.account;
}

-(void)dealloc{
    self.asModel = nil;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
