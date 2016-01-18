//
//  YLTabBar.m
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLTabBar.h"
#import "YLTabBarItem.h"

@interface YLTabBar ()


/**
 *  背景图片
 */
@property (nonatomic, weak) UIImageView *bgView;

/**
 *  发微博按钮
 */
@property (nonatomic, weak) UIButton *composeButton;

/**
 *  存放 items
 */
@property (nonatomic, strong) NSMutableArray *itemsArr;

/**
 *  当前选中的 item
 */
@property (nonatomic, weak) YLTabBarItem *currentItem;

@end

@implementation YLTabBar

- (NSMutableArray *)itemsArr
{
    if(_itemsArr == nil)
    {
        _itemsArr = [NSMutableArray array];
    }
    return _itemsArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = ClearColor;
        
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [[UIImage imageNamed:@"tabbar_slider"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
        [self addSubview:bgView];
        self.bgView = bgView;
        
        [self addComposeButton];
    }
    return  self;
}
#pragma mark 添加发微博按钮
- (void)addComposeButton
{
    UIButton *composeButton = [[UIButton alloc] init];
    [composeButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [composeButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [composeButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [composeButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [composeButton addTarget:self action:@selector(composeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:composeButton];
    self.composeButton = composeButton;
}
#pragma mark 增加一个 item
- (void)addTabBarItem:(UITabBarItem *)item
{
    YLTabBarItem *tabBarItem = [YLTabBarItem tabBarItemWithItem:item];
    [self.itemsArr addObject:tabBarItem];
    tabBarItem.tag = self.itemsArr.count - 1;
    [tabBarItem addTarget:self action:@selector(tabBarItemClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:tabBarItem];
    if(self.itemsArr.count == 4)
    {
        [self setNeedsLayout];
        [self tabBarItemClick:self.itemsArr.firstObject];
    }
}
#pragma mark 点击了 item
- (void)tabBarItemClick:(YLTabBarItem *)item
{
    self.currentItem.selected = NO;
    item.selected = YES;
    if(self.delegate && [self.delegate respondsToSelector:@selector(tabBar:didSelectItemFrom:to:)])
    {
        [self.delegate tabBar:self didSelectItemFrom:self.currentItem.tag to:item.tag];
    }
    self.currentItem = item;
}

#pragma mark 点击了发微博按钮
- (void)composeButtonClick
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(tabBarDidClickComposeButton:)])
    {
        [self.delegate tabBarDidClickComposeButton:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bgView.frame = self.bounds;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat itemWidth = width / (self.itemsArr.count + 1);
    
    self.composeButton.bounds = CGRectMake(0, 0, itemWidth, height);
    self.composeButton.center = self.center;
    
    for (int i = 0; i < self.itemsArr.count; i++)
    {
        YLTabBarItem *item = self.itemsArr[i];
        if(i < 2)
        {
            item.frame = CGRectMake(i * itemWidth, 0, itemWidth, height);
        }
        else
        {
            item.frame = CGRectMake((i + 1) * itemWidth, 0, itemWidth, height);
        }
    }
}

@end
