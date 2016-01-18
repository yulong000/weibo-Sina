//
//  YLTabBarItem.m
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLTabBarItem.h"

#define kImageViewHeightRatio 0.68

@implementation YLTabBarItem

- (instancetype)initWithItem:(UITabBarItem *)item
{
    if(self = [super init])
    {
        [self setTitle:item.title forState:UIControlStateNormal];
        [self setTitleColor:RGBA(112, 112, 112, 1) forState:UIControlStateNormal];
        [self setTitleColor:RGBA(255, 130, 0, 1) forState:UIControlStateSelected];
        [self setTitleColor:RGBA(255, 130, 0, 1) forState:UIControlStateSelected | UIControlStateHighlighted];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = SystemFont(11);
        
        [self setImage:item.image forState:UIControlStateNormal];
        [self setImage:item.selectedImage forState:UIControlStateSelected];
        [self setImage:item.selectedImage forState:UIControlStateHighlighted | UIControlStateSelected];
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}
+ (instancetype)tabBarItemWithItem:(UITabBarItem *)item
{
    return [[super alloc] initWithItem:item];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 2, contentRect.size.width, contentRect.size.height * kImageViewHeightRatio);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.height * kImageViewHeightRatio - 2, contentRect.size.width, contentRect.size.height * (1 - kImageViewHeightRatio));
}
@end
