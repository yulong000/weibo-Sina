//
//  AppDelegate.m
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "AppDelegate.h"
#import "YLTabBarController.h"
#import "YLOAuthViewController.h"

@interface AppDelegate ()

@end

/**
 *  全局的 account
 */
YLAccount *Account = nil;


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    YLAccount *account = [[YLUserCacheTool shareUserCacheTool] getLocalAccountInfo];
    if(account)
    {
        // 获取到本地帐号
        Account = account;
        YLTabBarController *tabbar = [[YLTabBarController alloc] init];
        tabbar.view.backgroundColor = WhiteColor;
        self.window.rootViewController = tabbar;
    }
    else
    {
        // 未获取到，请求
        YLOAuthViewController *auth = [[YLOAuthViewController alloc] init];
        auth.view.backgroundColor = WhiteColor;
        __weak typeof(self) weakSelf = self;
        auth.getAccountSuccess = ^(YLAccount *account){
            
            // 请求成功，跳转
            YLTabBarController *tabbar = [[YLTabBarController alloc] init];
            tabbar.view.backgroundColor = WhiteColor;
            weakSelf.window.rootViewController = tabbar;
            Account = account;
        };
        self.window.rootViewController = auth;
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
