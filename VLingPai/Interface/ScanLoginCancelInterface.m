//
//  ScanLoginCancelInterface.m
//  VLingPai
//
//  Created by Mac on 14-8-13.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "ScanLoginCancelInterface.h"

@implementation ScanLoginCancelInterface

-(void)scanCancelLoginAction:(NSString *)result{
    self.interfaceUrl = [NSString stringWithFormat:@"%@/cancel?deviceId=%@",result,[[NSUserDefaults standardUserDefaults] objectForKey:IDFV]];
//    self.baseDelegate = self;
    [self connect];
}

-(void)parseResult:(ASIHTTPRequest *)request{
    NSString *jsonStr = [[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    DebugLog(@"%@",jsonStr);
}
-(void)requestIsFailed:(NSError *)error{

}

@end
