//
//  UploadScanResultInterface.h
//  VLingPai
//
//  Created by Mac on 14-8-12.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "BaseInterface.h"

//#import "DiscountModel.h"
#import "AccountModel.h"
#import "SystemModel.h"

@protocol UploadScanResultInterfaceDelegate <NSObject>

-(void)getFinishedForUploadScanResultInterface:(NSString *)status system:(SystemModel *)systemModel account:(AccountModel *)accountModel;
-(void)getFailedForUploadScanResultInterface:(NSString *)str;

@end

@interface UploadScanResultInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<UploadScanResultInterfaceDelegate>delegate;

-(void)uploadScanResult:(NSString *)result;

@end
