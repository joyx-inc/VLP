//
//  AppDelegate.h
//  VLingPai
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;  //主界面的rootViewController

@property (strong, nonatomic) UINavigationController *startViewNav;  //如果开启了启动密码，这是验证密码的rootViewController

@property (unsafe_unretained, nonatomic) UIBackgroundTaskIdentifier myTask;


-(void)initTabBarController;

@end
