//
//  AppDelegate.m
//  TYCProject
//
//  Created by tangyunchuan on 2019/1/10.
//  Copyright © 2019 tangyunchuan. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+rd3.h"
#import "BaseTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    BaseTabBarViewController * m = [[BaseTabBarViewController alloc]init];
    CATransition *anim = [CATransition animation];
    anim.type = @"fade";
    anim.duration = 0.5;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];
    [UIApplication sharedApplication].keyWindow.rootViewController = m;
    
    [self setupAll3Rd:launchOptions];
    return YES;
}

#pragma mark -
#pragma mark 设置导航栏全局样式
- (void)setUpNavigationBarStyle
{
    if (VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0"))
    {
        [[UINavigationBar appearance] setTintColor:UIColorFromRGB(0x54, 0x54, 0x54)];
        [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(248, 248, 249)];
    }
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:kSystemFont(18), NSForegroundColorAttributeName:UIColorFromRGB(51, 51, 51)}];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
