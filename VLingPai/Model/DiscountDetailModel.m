//
//  DiscountDetailModel.m
//  VLingPai
//
//  Created by Mac on 14-8-20.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "DiscountDetailModel.h"

@implementation DiscountDetailModel

-(id)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.logInMethod = [dict objectForKey:@"method"];
        self.ipAddress = [dict objectForKey:@"ip"];
        self.time = [dict objectForKey:@"time"];
    }
    return self;
}

-(void)dealloc{
    self.logInMethod = nil;
    self.ipAddress = nil;
    self.time = nil;
}

@end
