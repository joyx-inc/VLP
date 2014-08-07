//
//  AppDelegate.m
//  VLingPai
//
//  Created by Mac on 14-8-2.
//  Copyright (c) 2014年 zhcpeng. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "VerificationViewController.h"
#import "DiscountViewController.h"
#import "SettingViewController.h"
#import "StartViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    StartViewController *vc = [[StartViewController alloc]initWithNibName:@"StartViewController" bundle:nil];
    self.startViewNav = [[UINavigationController alloc]initWithRootViewController:vc];
    
//    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isFirst"];
    
    BOOL isFirst = [[NSUserDefaults standardUserDefaults] boolForKey:@"isFirst"];
    if (!isFirst) {
        FirstViewController *vc = [[FirstViewController alloc]initWithNibName:@"FirstViewController" bundle:nil];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
        self.window.rootViewController = nav;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirst"];
    }else{
        self.window.rootViewController = self.startViewNav;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)initTabBarController{
    if (!self.tabBarController) {
    
        //验证
        VerificationViewController *verificationVC = [[VerificationViewController alloc]initWithNibName:@"VerificationViewController" bundle:nil];
        UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:verificationVC];
        nav1.title = @"验证";
        
        //账号
        DiscountViewController *discountVC = [[DiscountViewController alloc]initWithNibName:@"DiscountViewController" bundle:nil];
        UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:discountVC];
        nav2.title = @"账号";
        
        //设置
        SettingViewController *settingVC = [[SettingViewController alloc]initWithNibName:@"SettingViewController" bundle:nil];
        UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:settingVC];
        nav3.title = @"设置";
        
        
        self.tabBarController = [[UITabBarController alloc]init];
        self.tabBarController.viewControllers = @[nav1,nav2,nav3];
        
        UITabBar *tabBar = self.tabBarController.tabBar;
        UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
        UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
        UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
        
        tabBarItem1.title = @"验证";
        tabBarItem2.title = @"账号";
        tabBarItem3.title = @"设置";
        
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:229/255.0f green:63/255.0f blue:17/255.0f alpha:1], UITextAttributeTextColor,nil] forState:UIControlStateSelected];
    
    }
    self.window.rootViewController = self.tabBarController;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:StartPassword];
    if (password) {
        self.window.rootViewController = self.startViewNav;
        [self.startViewNav popToRootViewControllerAnimated:NO];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
