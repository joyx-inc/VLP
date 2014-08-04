//
//  LockViewController.h
//  JiuGongGe_2
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LockViewController : UIViewController{
    NSMutableArray* _paths;
    
    // after pattern is drawn, call this:
    id _target;
    SEL _action;
}

// get key from the pattern drawn
- (NSString*)getKey;

- (void)setTarget:(id)target withAction:(SEL)action;


@end
