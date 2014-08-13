//
//  BindPhoneInterface.h
//  VLingPai
//
//  Created by Mac on 14-8-12.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "BaseInterface.h"

@protocol BindPhoneInterfaceDelegate <NSObject>

-(void)getFinishedBindPhoneInterface:(NSString *)status secrect:(NSString *)secrect;
-(void)getFailedBindPhoneInterface:(NSString *)error;

@end

@interface BindPhoneInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<BindPhoneInterfaceDelegate>delegate;

-(void)bindPhoneNum:(NSString *)mobile;

@end
