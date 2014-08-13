//
//  ScanBindAccountInterface.h
//  VLingPai
//
//  Created by Mac on 14-8-13.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

//首次绑定账号 以及查询绑定结果（1秒钟刷新一次，之后可以优化为长连接）

#import "BaseInterface.h"

@protocol ScanBindAccountInterfaceDelegate <NSObject>

-(void)getFinishedScanBindAccountInterfaceDelegate:(NSString *)status;
-(void)getFailedScanBindAccountInterfaceDelegate:(NSString *)error;

@end

@interface ScanBindAccountInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<ScanBindAccountInterfaceDelegate>delegate;

-(void)scanBindAccount:(NSString *)result withMethod:(NSString *)method;

@end
