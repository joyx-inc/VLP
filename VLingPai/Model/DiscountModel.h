//
//  DiscountModel.h
//  VLingPai
//
//  Created by Mac on 14-8-12.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//


//账号 cell model
#import <Foundation/Foundation.h>

@interface DiscountModel : NSObject

@property (strong, nonatomic) NSString *logoURLStr;     //logo图片地址
@property (strong, nonatomic) NSString *systemName;     //要系统的系统名称
@property (strong, nonatomic) NSString *discountStr;    //账号
@property (assign, nonatomic) NSInteger useCount;       //登录次数

-(id)initWithJsonMap:(NSDictionary *)jsonMap;

@end
