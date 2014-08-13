//
//  ScanLoginInterface.m
//  VLingPai
//
//  Created by Mac on 14-8-13.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "ScanLoginInterface.h"
#import "JSONKit.h"

@implementation ScanLoginInterface

-(void)scanLoginSystem:(NSString *)result{
    self.interfaceUrl = [NSString stringWithFormat:@"%@/login?deviceId=%@",result,[[NSUserDefaults standardUserDefaults] objectForKey:IDFV]];
    //    self.args = @{@"result": result};
    self.baseDelegate = self;
    [self connect];
}

-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSString *status = [jsonObj objectForKey:@"status"];
        
        if (_delegate && [_delegate respondsToSelector:@selector(getFinishedScanLoginInterface:)]) {
            [_delegate getFinishedScanLoginInterface:status];
        }
    }
}
-(void)requestIsFailed:(NSError *)error{
    if (_delegate && [_delegate respondsToSelector:@selector(getFailedScanLoginInterface:)]) {
        [_delegate getFailedScanLoginInterface:[NSString stringWithFormat:@"获取失败:(%@)",error]];
    }
}
-(void)dealloc{
    self.delegate = nil;
}

@end
