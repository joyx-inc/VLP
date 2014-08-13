//
//  OneClickInterface.h
//  VLingPai
//
//  Created by Mac on 14-8-13.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "BaseInterface.h"

@protocol OneClickInterfaceDelegate <NSObject>

-(void)getFinishedOneClickInterface:(NSString *)status count:(NSInteger)count list:(NSArray *)list;
-(void)getFailedOneClickInterface:(NSString *)error;

@end

@interface OneClickInterface : BaseInterface<BaseInterfaceDelegate>

@property (assign, nonatomic) id<OneClickInterfaceDelegate>delegate;

-(void)startOneClick;

@end
