//
//  YLTabBarItem.m
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLTabBarItem.h"
#import "YLBadgeView.h"

#define kImageViewHeightRatio 0.68

@interface YLTabBarItem ()

@property (nonatomic, weak) YLBadgeView *badgeView;

@end

@implementation YLTabBarItem

- (instancetype)initWithItem:(UITabBarItem *)item
{
    if(self = [super init])
    {
        YLBadgeView *badgeView = [[YLBadgeView alloc] init];
        badgeView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeView];
        self.badgeView = badgeView;
        
        [self setTabBarItem:item];
    }
    return self;
}
+ (instancetype)tabBarItemWithItem:(UITabBarItem *)item
{
    return [[super alloc] initWithItem:item];
}

- (void)setTabBarItem:(UITabBarItem *)item
{
    _tabBarItem = item;
    
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
    
    [self.tabBarItem addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc
{
    [self.tabBarItem removeObserver:self forKeyPath:@"badgeValue"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if([keyPath isEqualToString:@"badgeValue"])
    {
        self.badgeView.badgeValue = self.tabBarItem.badgeValue;
        CGFloat badgeViewH = 19;
        self.badgeView.frame = CGRectMake(self.width - self.badgeView.width - 10, 0, self.badgeView.width, badgeViewH);
    }
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
