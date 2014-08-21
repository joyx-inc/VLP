//
//  UploadScanResultInterface.m
//  VLingPai
//
//  Created by Mac on 14-8-12.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "UploadScanResultInterface.h"
//#import "JSONKit.h"


@implementation UploadScanResultInterface

-(void)uploadScanResult:(NSString *)result{
    self.interfaceUrl = [NSString stringWithFormat:@"%@?deviceId=%@",result,[[NSUserDefaults standardUserDefaults] objectForKey:IDFV]];
    self.baseDelegate = self;
    [self connect];
}


-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    
    id jsonObj = [jsonStr objectFromJSONString];
    
    if (jsonObj) {
        NSString *status = [jsonObj objectForKey:@"status"];
        AccountModel *discountModel = [[AccountModel alloc]initWithJsonMap:[jsonObj objectForKey:@"account"]];
        SystemModel *systemModel = [[SystemModel alloc]initWithJsonMap:[jsonObj objectForKey:@"app"]];
        
        if (_delegate && [_delegate respondsToSelector:@selector(getFinishedForUploadScanResultInterface:system:account:)]) {
            [_delegate getFinishedForUploadScanResultInterface:status system:systemModel account:discountModel];
        }
    }
}
-(void)requestIsFailed:(NSError *)error{
    if (_delegate && [_delegate respondsToSelector:@selector(getFailedForUploadScanResultInterface:)]) {
        [_delegate getFailedForUploadScanResultInterface:[NSString stringWithFormat:@"获取失败:(%@)",error]];
    }
}
-(void)dealloc{
    self.delegate = nil;
}
@end
