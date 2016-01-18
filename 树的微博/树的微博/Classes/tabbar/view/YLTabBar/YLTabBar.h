//
//  YLTabBar.h
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLTabBar;
@protocol YLTabBarDelegate <NSObject>

@optional

/**
 *  从一个 item 切换到另一个 item
 */
- (void)tabBar:(YLTabBar *)tabBar didSelectItemFrom:(NSUInteger)from to:(NSUInteger)to;

/**
 *  点击了发微博按钮
 */
- (void)tabBarDidClickComposeButton:(YLTabBar *)tabBar;

@end

@interface YLTabBar : UIView

@property (nonatomic, weak) id < YLTabBarDelegate > delegate;


- (void)addTabBarItem:(UITabBarItem *)item;
@end
