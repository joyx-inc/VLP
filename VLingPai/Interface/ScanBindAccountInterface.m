//
//  ScanBindAccountInterface.m
//  VLingPai
//
//  Created by Mac on 14-8-13.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "ScanBindAccountInterface.h"
//#import "JSONKit.h"

@implementation ScanBindAccountInterface

-(void)scanBindAccount:(NSString *)result withMethod:(NSString *)method{
    self.interfaceUrl = [NSString stringWithFormat:@"%@/bind?deviceId=%@",result,[[NSUserDefaults standardUserDefaults] objectForKey:IDFV]];
    self.baseDelegate = self;
    self.requestMethod = method;
    [self connect];
}

-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSString *status = [jsonObj objectForKey:@"status"];
        AccountModel *accountModel;
        SystemModel *systemModel;
        NSDictionary *system = [jsonObj objectForKey:@"app"];
        if (system) {
            systemModel = [[SystemModel alloc]initWithJsonMap:system];
        }
        NSDictionary *account = [jsonObj objectForKey:@"account"];
        if (account) {
            accountModel = [[AccountModel alloc]initWithJsonMap:account];
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(getFinishedScanBindAccountInterfaceDelegate:account:system:)]) {
            [_delegate getFinishedScanBindAccountInterfaceDelegate:status account:accountModel system:systemModel];
        }
    }
}
-(void)requestIsFailed:(NSError *)error{
    if (_delegate && [_delegate respondsToSelector:@selector(getFailedScanBindAccountInterfaceDelegate:)]) {
        [_delegate getFailedScanBindAccountInterfaceDelegate:[NSString stringWithFormat:@"获取失败:(%@)",error]];
    }
}
-(void)dealloc{
    self.delegate = nil;
}

@end
