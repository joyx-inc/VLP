//
//  AccountModel.m
//  VLingPai
//
//  Created by Mac on 14-8-12.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel

-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        if (jsonMap) {
            self.account = [jsonMap objectForKey:@"account"];
            self.displayName = [jsonMap objectForKey:@"displayName"];
        }
    }
    return self;
}

-(void)dealloc{
    self.account = nil;
    self.displayName = nil;
}

@end
