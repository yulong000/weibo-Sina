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
#import "YLComposeViewController.h"

#import "YLTabBar.h"

@interface YLTabBarController () <YLTabBarDelegate>

@property (nonatomic, strong) YLHomeViewController *home;
@property (nonatomic, strong) YLMessageViewController *message;
@property (nonatomic, strong) YLDiscoverViewController *discover;
@property (nonatomic, strong) YLMeViewController *me;

@property (nonatomic, strong) YLTabBar *tabbar;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation YLTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTabBar];
    
    // 开启定时器， 获取未读消息
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kGetUnreadMessageCountInterval target:self selector:@selector(getUnreadMessageCount) userInfo:nil repeats:YES];
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
    self.home = homeVc;
    
    YLMessageViewController *messageVc = [[YLMessageViewController alloc] init];
    [self setupChildVc:messageVc title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    self.message = messageVc;
    
    YLDiscoverViewController *discoverVc = [[YLDiscoverViewController alloc] init];
    [self setupChildVc:discoverVc title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    self.discover = discoverVc;
    
    YLMeViewController *meVc = [[YLMeViewController alloc] init];
    [self setupChildVc:meVc title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    self.me = meVc;
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
#pragma mark 获取消息未读数
- (void)getUnreadMessageCount
{
    /*
     source         false	string	采用OAuth授权方式不需要此参数，其他授权方式为必填参数，数值为应用的AppKey。
     access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     uid            true	int64	需要获取消息未读数的用户UID，必须是当前登录用户。
     callback       false	string	JSONP回调函数，用于前端调用返回JS格式的信息。
     unread_message	false	boolean	未读数版本。0：原版未读数，1：新版未读数。默认为0。
     */
    
    NSDictionary *params = @{@"access_token" : Account.access_token, @"uid" : Account.uid};
    [[YLNetworkTool shareNetworkTool] getWithURL:GetUnreadMessageCountAPI params:params success:^(id json) {
        
        YLUnreadMessageCountModel *model = [YLUnreadMessageCountModel modelWithDict:json];
        [[NSNotificationCenter defaultCenter] postNotificationName:kGetUnreadMessageCountNotification object:self userInfo:@{kGetUnreadMessageCountNotification : model}];
        // 设置角标
        self.home.tabBarItem.badgeValue = StringValueFromInt(model.homeCount);
        self.message.tabBarItem.badgeValue = StringValueFromInt(model.messageCount);
        self.discover.tabBarItem.badgeValue = StringValueFromInt(model.discoverCount);
        self.me.tabBarItem.badgeValue = StringValueFromInt(model.meCount);
        [UIApplication sharedApplication].applicationIconBadgeNumber = model.totalCount;
        
    } failure:^(NSError *error) {
        
        YLLog(@"获取新消息失败");
    }];
}

#pragma mark tabbar 代理方法
#pragma mark 切换控制器
- (void)tabBar:(YLTabBar *)tabBar didSelectItemFrom:(NSUInteger)from to:(NSUInteger)to
{
    self.selectedIndex = to;
    if(from == to && to == 0 && self.home.tabBarItem.badgeValue.intValue)
    {
        [self.home beginRefresh];
    }
}
#pragma mark 点击了发微博
- (void)tabBarDidClickComposeButton:(YLTabBar *)tabBar
{
    YLComposeViewController *composeVc = [[YLComposeViewController alloc] init];
    composeVc.view.backgroundColor = WhiteColor;
    [self presentViewController:composeVc animated:YES completion:nil];
}

@end
