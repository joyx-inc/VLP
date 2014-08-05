//
//  CalibrationTimeViewController.h
//  VLingPai
//
//  Created by Mac on 14-8-5.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalibrationTimeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labDate;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
- (IBAction)bntClibrateTimeAction:(UIButton *)sender;

@end
