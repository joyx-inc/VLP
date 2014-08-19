//
//  LockView.m
//  JiuGongGe_2
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "LockView.h"

@implementation LockView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //  NSLog(@"drawrect...");
    
    if (!_trackPointValue)
        return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {0.1, 0.68, 0.5, 0.5};
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetStrokeColorWithColor(context, color);
    
    CGPoint from;
    UIView *lastDot;
    for (UIView *dotView in _dotViews) {
        from = dotView.center;
        //    NSLog(@"drwaing dotview: %@", dotView);
        //    NSLog(@"\tdrawing from: %f, %f", from.x, from.y);
        
        if (!lastDot)
            CGContextMoveToPoint(context, from.x, from.y);
        else
            CGContextAddLineToPoint(context, from.x, from.y);
        
        lastDot = dotView;
    }
    
    CGPoint pt = [_trackPointValue CGPointValue];
    //  NSLog(@"\t to: %f, %f", pt.x, pt.y);
    CGContextAddLineToPoint(context, pt.x, pt.y);
    
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
    
    _trackPointValue = nil;
}


- (void)clearDotViews {
    [_dotViews removeAllObjects];
}


- (void)addDotView:(UIView *)view {
    if (!_dotViews)
        _dotViews = [NSMutableArray array];
    
    [_dotViews addObject:view];
}


- (void)drawLineFromLastDotTo:(CGPoint)pt {
    _trackPointValue = [NSValue valueWithCGPoint:pt];
    [self setNeedsDisplay];
}


@end
