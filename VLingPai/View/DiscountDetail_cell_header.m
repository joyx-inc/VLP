//
//  DiscountDetail_cell_header.m
//  VLingPai
//
//  Created by Mac on 14-8-20.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "DiscountDetail_cell_header.h"

@implementation DiscountDetail_cell_header

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
    self.labDate.layer.masksToBounds = YES;
    self.labDate.layer.cornerRadius = 9.0f;
}

-(void)setDate:(NSString *)date{
    if (date.length == 0) {
        self.labDate.hidden = YES;
        return;
    }
    
    CGSize size = [date sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(300, 20) lineBreakMode:NSLineBreakByCharWrapping];
    CGRect frame = self.labDate.frame;
    frame.size.width = size.width + 20;
    self.labDate.frame = frame;
    
    self.labDate.text = date;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
