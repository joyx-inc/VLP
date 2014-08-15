//
//  DigitalTokenView.m
//  VLingPai
//
//  Created by Mac on 14-8-14.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "DigitalTokenView.h"
#import <QuartzCore/QuartzCore.h>
#import "TokenStore.h"


@interface DigitalTokenView ()
{
    TokenStore *store;
    TokenCode *tc;
    NSTimer *timer;
}

@property (strong, nonatomic) NSMutableArray *imageListArray;
@property (strong, nonatomic) UILabel *labTime;
@end

@implementation DigitalTokenView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.imageListArray = [NSMutableArray array];
        
        for (int i = 0; i < 8; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i * (30+2), 0, 30, 50)];
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = 6.0f;
            imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            imageView.layer.borderWidth = 0.4f;
            [self addSubview:imageView];
            [self.imageListArray addObject:imageView];
        }
        
        self.labTime = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, frame.size.width, 20)];
        _labTime.backgroundColor = [UIColor clearColor];
        _labTime.font = [UIFont systemFontOfSize:12];
        _labTime.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.labTime];
        
    }
    return self;
}

-(void)awakeFromNib{
    [self setCodeAndTime];
}

-(void)setCode:(NSString *)code{
    _code = code;
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *string = [code substringWithRange:range];
        [array addObject:string];
        
        UIImageView *imageView = [self.imageListArray objectAtIndex:i];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",string]];
    }
}

-(void)setCodeAndTime{
    Token *token = [store get:0];
    tc = token.code;
    [store save:token];
    
    NSString *code = [tc currentCode];
    self.code = code;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(outputCurrentTime) userInfo:nil repeats:YES];
}
-(void)outputCurrentTime{
    int x = ceilf(tc.currentProgress * 30);
    self.labTime.text = [NSString stringWithFormat:@"验证码将在%d秒后过期",x];
    
    if (x == 0 ) {
        [timer invalidate];
        timer = nil;
        [self setCodeAndTime];
    }
}

- (void)dealloc
{
    self.code = nil;
    self.imageListArray = nil;
    self.labTime = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
