//
//  AccountAndSystemModel.m
//  VLingPai
//
//  Created by Mac on 14-8-13.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "AccountAndSystemModel.h"

@implementation AccountAndSystemModel

-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        if (jsonMap) {
            self.code = [jsonMap objectForKey:@"code"];
            self.accountModel = [[AccountModel alloc]initWithJsonMap:[jsonMap objectForKey:@"account"]];
            self.systemModel = [[SystemModel alloc]initWithJsonMap:[jsonMap objectForKey:@"app"]];
        }
    }
    return self;
}

-(void)dealloc{
    self.code = nil;
    self.accountModel = nil;
    self.systemModel = nil;
}

@end
