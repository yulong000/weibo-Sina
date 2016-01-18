//
//  YLStatusUserInfoView.m
//  树的微博
//
//  Created by WYL on 16/1/17.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLStatusUserInfoView.h"
#import "YLStatusIconView.h"

#define kMargin 10

@interface YLStatusUserInfoView ()

/**
 *  头像
 */
@property (nonatomic, weak) YLStatusIconView *iconView;
/**
 *  会员图标
 */
@property (nonatomic, weak) UIImageView *vipView;
/**
 *  昵称
 */
@property (nonatomic, weak) UIButton *nameButton;
/**
 *  时间
 */
@property (nonatomic, weak) UILabel *timeLabel;
/**
 *  来源
 */
@property (nonatomic, weak) UILabel *sourceLabel;

/**
 *  对此微博进行某些操作
 */
@property (nonatomic, weak) UIButton *moreButton;

@end

@implementation YLStatusUserInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = WhiteColor;
        
        [self addSubviews];
    }
    return  self;
}
#pragma mark 添加子控件
- (void)addSubviews
{
    // 头像
    YLStatusIconView *iconView = [[YLStatusIconView alloc] init];
    [iconView addTarget:self action:@selector(iconViewClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    // 昵称
    UIButton *nameButton = [[UIButton alloc] init];
    nameButton.titleLabel.font = kStatusNameFont;
    [nameButton addTarget:self action:@selector(iconViewClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:nameButton];
    self.nameButton = nameButton;
    
    // 会员
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [self addSubview:vipView];
    self.vipView = vipView;
    
    // 时间
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.textColor = GrayColor;
    timeLabel.font = kStatusTimeFont;
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    // 设备
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.textColor = GrayColor;
    sourceLabel.font = kStatusSourceFont;
    [self addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    // 操作按钮
    UIButton *moreButton = [[UIButton alloc] init];
    [moreButton setImage:[UIImage imageNamed:@"timeline_icon_more"] forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"timeline_icon_more_highlighted"] forState:UIControlStateHighlighted];
    [moreButton addTarget:self action:@selector(moreButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moreButton];
    self.moreButton = moreButton;
}

- (void)setStatus:(YLStatus *)status
{
    _status = status;
    
    self.iconView.iconUrl = status.user.profile_image_url;
    [self.nameButton setTitle:status.user.name forState:UIControlStateNormal];
    if(status.user.mbrank > 2)
    {
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank]];
        [self.nameButton setTitleColor:OrangeColor forState:UIControlStateNormal];
    }
    else
    {
        self.vipView.image = [UIImage imageNamed:@"common_icon_membership_expired"];
        [self.nameButton setTitleColor:BlackColor forState:UIControlStateNormal];
    }
    self.timeLabel.text = _status.created_at;
    self.sourceLabel.text = _status.source;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconView.frame = CGRectMake(0, 0, self.height, self.height);
    
    CGSize nameButtonSize = [self.status.user.name sizeWithAttributes:@{NSFontAttributeName:kStatusNameFont}];
    self.nameButton.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame) + kStatusCellSubViewsGap, self.height * 0.5 - nameButtonSize.height, nameButtonSize.width, nameButtonSize.height);
    
    self.vipView.frame = CGRectMake(CGRectGetMaxX(self.nameButton.frame) + kStatusCellSubViewsGap, self.nameButton.y, 15, self.nameButton.height);
    
    CGSize timeLabelSize = [self.timeLabel.text sizeWithAttributes:@{NSFontAttributeName:kStatusTimeFont}];
    self.timeLabel.frame = CGRectMake(self.nameButton.x, CGRectGetMaxY(self.nameButton.frame), timeLabelSize.width, timeLabelSize.height);
    
    CGSize sourceLabelSize = [self.sourceLabel.text sizeWithAttributes:@{NSFontAttributeName : kStatusSourceFont}];
    self.sourceLabel.frame = CGRectMake(CGRectGetMaxX(self.timeLabel.frame) + kStatusCellSubViewsGap, self.timeLabel.y, sourceLabelSize.width, self.timeLabel.height);
    
    self.moreButton.frame = CGRectMake(self.width - 15, 0, 17, self.height);
}

#pragma mark 点击了头像
- (void)iconViewClicked
{
    if([self.delegate respondsToSelector:@selector(statusUserInfoViewClickedIconView:)])
    {
        [self.delegate statusUserInfoViewClickedIconView:self];
    }
}
#pragma mark 点击了更多
- (void)moreButtonClick
{
    if([self.delegate respondsToSelector:@selector(statusUserInfoViewClickedMoreButton:)])
    {
        [self.delegate statusUserInfoViewClickedMoreButton:self];
    }
}


@end
