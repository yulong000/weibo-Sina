//
//  YLTabBarItem.h
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLTabBarItem : UIButton

@property (nonatomic, strong) UITabBarItem *tabBarItem;

- (instancetype)initWithItem:(UITabBarItem *)item;
+ (instancetype)tabBarItemWithItem:(UITabBarItem *)item;

@end
