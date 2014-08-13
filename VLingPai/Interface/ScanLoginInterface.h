//
//  ScanLoginInterface.h
//  VLingPai
//
//  Created by Mac on 14-8-13.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "BaseInterface.h"

@protocol ScanLoginInterfaceDelegate <NSObject>

-(void)getFinishedScanLoginInterface:(NSString *)status;
-(void)getFailedScanLoginInterface:(NSString *)error;

@end

@interface ScanLoginInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<ScanLoginInterfaceDelegate>delegate;

-(void)scanLoginSystem:(NSString *)result;

@end
