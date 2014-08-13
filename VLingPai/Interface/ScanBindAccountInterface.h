//
//  ScanBindAccountInterface.h
//  VLingPai
//
//  Created by Mac on 14-8-13.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "BaseInterface.h"

@protocol ScanBindAccountInterfaceDelegate <NSObject>

-(void)getFinishedScanBindAccountInterfaceDelegate:(NSString *)status;
-(void)getFailedScanBindAccountInterfaceDelegate:(NSString *)error;

@end

@interface ScanBindAccountInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<ScanBindAccountInterfaceDelegate>delegate;

-(void)scanBindAccount:(NSString *)result withMethod:(NSString *)method;

@end
