//
//  YLTabBarController.m
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLTabBarController.h"

#import "YLHomeViewController.h"
#import "YLMessageViewController.h"
#import "YLDiscoverViewController.h"
#import "YLMeViewController.h"


#import "YLTabBar.h"

@interface YLTabBarController () <YLTabBarDelegate>

@property (nonatomic, strong) YLTabBar *tabbar;

@end

@implementation YLTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTabBar];
}

#pragma mark 移除系统默认生成的 items
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIControl *item in self.tabBar.subviews)
    {
        if([item isKindOfClass:[UIControl class]])
        {
            [item removeFromSuperview];
        }
    }
}

#pragma mark 设置 tabbar
- (void)setTabBar
{
    self.tabbar = [[YLTabBar alloc] initWithFrame:self.tabBar.bounds];
    self.tabbar.delegate = self;
    [self.tabBar addSubview:self.tabbar];
    [self setChildViewControllers];
}
#pragma mark 设置子控制器
- (void)setChildViewControllers
{
    YLHomeViewController *homeVc = [[YLHomeViewController alloc] init];
    [self setupChildVc:homeVc title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    YLMessageViewController *messageVc = [[YLMessageViewController alloc] init];
    [self setupChildVc:messageVc title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    YLDiscoverViewController *discoverVc = [[YLDiscoverViewController alloc] init];
    [self setupChildVc:discoverVc title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    YLMeViewController *meVc = [[YLMeViewController alloc] init];
    [self setupChildVc:meVc title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
}
#pragma mark 设置单个子控制器
- (void)setupChildVc:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    viewController.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    [self.tabbar addTabBarItem:viewController.tabBarItem];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nav];
}

#pragma mark tabbar 代理方法
#pragma mark 切换控制器
- (void)tabBar:(YLTabBar *)tabBar didSelectItemFrom:(NSUInteger)from to:(NSUInteger)to
{
    self.selectedIndex = to;
}
#pragma mark 点击了发微博
- (void)tabBarDidClickComposeButton:(YLTabBar *)tabBar
{
    
}

@end
