//
//  AccountModel.h
//  VLingPai
//
//  Created by Mac on 14-8-12.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject

@property (strong, nonatomic) NSString *account;        //账号
@property (strong, nonatomic) NSString *displayName;    //账号名称

-(id)initWithJsonMap:(NSDictionary *)jsonMap;

@end
