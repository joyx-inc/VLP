//
//  DigitalTokenViewController.m
//  VLingPai
//
//  Created by Mac on 14-8-14.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "DigitalTokenViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "TokenStore.h"
#import "MCProgressBarView.h"
#import "UIColor+GetColorFromString.h"

@interface DigitalTokenViewController ()
{
    TokenStore *store;
    TokenCode *tc;
    NSTimer *timer;
    MCProgressBarView *progressView;
}

@property (strong, nonatomic) NSMutableArray *imageListArray;

@end

@implementation DigitalTokenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view1.layer.masksToBounds = YES;
    self.view1.layer.cornerRadius = 1.5;
    self.view1.layer.borderWidth = 0.4;
    self.view1.layer.borderColor = [[UIColor getColorFromString:@"#d2d2d2ff"] CGColor];
    self.view2.layer.masksToBounds = YES;
    self.view2.layer.cornerRadius = 1.5;
    self.view2.layer.borderWidth = 0.4;
    self.view2.layer.borderColor = [[UIColor getColorFromString:@"#d2d2d2ff"] CGColor];
    self.view3.layer.masksToBounds = YES;
    self.view3.layer.cornerRadius = 1.5;
    self.view3.layer.borderWidth = 0.4;
    self.view3.layer.borderColor = [[UIColor getColorFromString:@"#d2d2d2ff"] CGColor];
    self.view4.layer.masksToBounds = YES;
    self.view4.layer.cornerRadius = 1.5;
    self.view4.layer.borderWidth = 0.4;
    self.view4.layer.borderColor = [[UIColor getColorFromString:@"#d2d2d2ff"] CGColor];
    
    UIImage * backgroundImage = [[UIImage imageNamed:@"progress_trackImage.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    UIImage * foregroundImage = [[UIImage imageNamed:@"progress_progressImage.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    progressView = [[MCProgressBarView alloc]initWithFrame:CGRectMake(20, 75, 280, 4) backgroundImage:backgroundImage foregroundImage:foregroundImage];
    progressView.progress = 0;
    [self.view addSubview:progressView];
     
    store = [[TokenStore alloc]init];    
    [self setCodeAndTime];
}
-(void)setCode:(NSString *)code{
    if (code.length == 0) {
        return;
    }
    
    _code = code;
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *string = [code substringWithRange:range];
        [array addObject:string];
        
        UIImageView *imageView = (UIImageView *)[self.view viewWithTag:100+i];
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
    progressView.progress = 1 - tc.currentProgress;
    int x = ceilf(tc.currentProgress * 30);
    self.labTime.text = [NSString stringWithFormat:@"%d",x];
    
    if (x == 0 ) {
        [timer invalidate];
        timer = nil;
        [self setCodeAndTime];
        progressView.progress = 0;
    }
}

- (void)dealloc
{
    self.code = nil;
    self.imageListArray = nil;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
