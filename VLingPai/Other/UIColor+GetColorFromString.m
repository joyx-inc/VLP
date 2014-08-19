//
//  UIColor+GetColorFromString.m
//  VLingPai
//
//  Created by Mac on 14-8-18.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "UIColor+GetColorFromString.h"

@implementation UIColor (GetColorFromString)

+(UIColor *)getColorFromString:(NSString *)hexColor{
    if (hexColor.length != 9) {
        return nil;
    }
    
    unsigned int r,g,b,a;
    NSRange range;
    range.length = 2;
    
    range.location = 1;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&r];
    
    range.location = 3;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&g];
    
    range.location = 5;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&b];
    
    range.location = 7;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&a];
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0];
}

@end
