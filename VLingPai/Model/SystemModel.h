//
//  SystemModel.h
//  VLingPai
//
//  Created by Mac on 14-8-12.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemModel : NSObject

@property (assign, nonatomic) NSInteger sid;
@property (strong, nonatomic) NSString *systemName;

-(id)initWithJsonMap:(NSDictionary *)jsonMap;

@end
