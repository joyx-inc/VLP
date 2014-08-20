//
//  DiscountDetailModel.h
//  VLingPai
//
//  Created by Mac on 14-8-20.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiscountDetailModel : NSObject

@property (strong, nonatomic) NSString *logInMethod;
@property (strong, nonatomic) NSString *ipAddress;
@property (strong, nonatomic) NSString *time;

-(id)initWithDictionary:(NSDictionary *)dict;

@end
