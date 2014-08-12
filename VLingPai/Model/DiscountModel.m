//
//  DiscountModel.m
//  VLingPai
//
//  Created by Mac on 14-8-12.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "DiscountModel.h"

@implementation DiscountModel

-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        if (jsonMap) {
            
        }
    }
    return self;
}

-(void)dealloc{
    self.logoURLStr = nil;
    self.systemName = nil;
    self.discountStr = nil;
    
}

@end
