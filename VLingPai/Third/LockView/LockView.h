//
//  LockView.h
//  JiuGongGe_2
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LockView : UIView{
    NSValue *_trackPointValue;
    NSMutableArray *_dotViews;
}


- (void)clearDotViews;
- (void)addDotView:(UIView*)view;
- (void)drawLineFromLastDotTo:(CGPoint)pt;

@end
