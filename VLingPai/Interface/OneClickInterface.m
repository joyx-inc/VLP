//
//  OneClickInterface.m
//  VLingPai
//
//  Created by Mac on 14-8-13.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "OneClickInterface.h"
#import "AccountAndSystemModel.h"

@implementation OneClickInterface

-(void)startOneClick{
    self.interfaceUrl = [NSString stringWithFormat:@"%@/vlp/api/one_click?deviceId=%@",BASE_INTERFACE_DOMAIN,[[NSUserDefaults standardUserDefaults] objectForKey:IDFV]];
    self.baseDelegate = self;
//    self.requestMethod = @"POST";
    [self connect];
}


-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSString *status = [jsonObj objectForKey:@"status"];
        NSInteger count = [[jsonObj objectForKey:@"count"]integerValue];
        NSArray *list = [jsonObj objectForKey:@"list"];
        NSMutableArray *resultList = [NSMutableArray array];
        for (NSDictionary *dict in list) {
            AccountAndSystemModel *asModel = [[AccountAndSystemModel alloc]initWithJsonMap:dict];
            [resultList addObject:asModel];
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(getFinishedOneClickInterface:count:list:)]) {
            [_delegate getFinishedOneClickInterface:status count:count list:resultList];
        }
    }
}
-(void)requestIsFailed:(NSError *)error{
    if (_delegate && [_delegate respondsToSelector:@selector(getFailedOneClickInterface:)]) {
        [_delegate getFailedOneClickInterface:[NSString stringWithFormat:@"获取失败:(%@)",error]];
    }
}
-(void)dealloc{
    self.delegate = nil;
}

@end
