//
//  BindPhoneInterface.m
//  VLingPai
//
//  Created by Mac on 14-8-12.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "BindPhoneInterface.h"
//#import "JSONKit.h"


@implementation BindPhoneInterface

-(void)bindPhoneNum:(NSString *)mobile{
    self.interfaceUrl = [NSString stringWithFormat:@"%@/vlp/api/bind_mobile?mobile=%@&deviceId=%@",BASE_INTERFACE_DOMAIN,mobile,[[NSUserDefaults standardUserDefaults] objectForKey:IDFV]];
    self.baseDelegate = self;
    self.requestMethod = @"POST";
    [self connect];
}


-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSString *status = [jsonObj objectForKey:@"status"];
        NSString *secrect = [jsonObj objectForKey:@"secrect"];
//        NSDictionary *resultDict = @{@"status":status,@"secrect":secrect};
        
        if (_delegate && [_delegate respondsToSelector:@selector(getFinishedBindPhoneInterface:secrect:)]) {
            [_delegate getFinishedBindPhoneInterface:status secrect:secrect];
        }
    }
}
-(void)requestIsFailed:(NSError *)error{
    if (_delegate && [_delegate respondsToSelector:@selector(getFailedBindPhoneInterface:)]) {
        [_delegate getFailedBindPhoneInterface:[NSString stringWithFormat:@"获取失败:(%@)",error]];
    }
}
-(void)dealloc{
    self.delegate = nil;
}


@end
