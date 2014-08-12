//
//  SystemModel.m
//  VLingPai
//
//  Created by Mac on 14-8-12.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "SystemModel.h"

@implementation SystemModel

-(id)initWithJsonMap:(NSDictionary *)jsonMap
{
    if (self = [super init]) {
        if (jsonMap) {
            self.sid = [[jsonMap objectForKey:@"id"]integerValue];
            self.systemName = [jsonMap objectForKey:@"name"];
        }
    }
    return self;
}

-(void)dealloc{
    self.systemName = nil;
    
}

@end
