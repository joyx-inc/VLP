//
//  AccountAndSystemModel.h
//  VLingPai
//
//  Created by Mac on 14-8-13.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"
#import "SystemModel.h"

@interface AccountAndSystemModel : NSObject

@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) AccountModel *accountModel;
@property (strong, nonatomic) SystemModel *systemModel;

-(id)initWithJsonMap:(NSDictionary *)jsonMap;


@end
