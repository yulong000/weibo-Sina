//
//  YLMembershipView.m
//  树的微博
//
//  Created by WYL on 16/1/21.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLMembershipView.h"

@interface YLMembershipView ()

@property (nonatomic, weak) UIImageView *vipView;
@property (nonatomic, weak) UILabel     *vipLabel;
@property (nonatomic, weak) UIImageView *arrowView;

@end

@implementation YLMembershipView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = ClearColor;
        UIImageView *vipView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_icon_membership"]];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        UILabel *vipLabel = [[UILabel alloc] init];
        vipLabel.text = @"会员";
        vipLabel.textAlignment = NSTextAlignmentCenter;
        vipLabel.textColor = OrangeColor;
        vipLabel.font = SystemFont(12);
        [self addSubview:vipLabel];
        self.vipLabel = vipLabel;
        
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_icon_membership_arrow"]];
        arrowView.contentMode = UIViewContentModeCenter;
        [self addSubview:arrowView];
        self.arrowView = arrowView;
    }
    return  self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat arrowW = 15;
    CGFloat labelW = 30;
    CGFloat vipW = 25;
    self.arrowView.frame = CGRectMake(self.width - arrowW, 0, arrowW, self.height);
    self.vipLabel.frame = CGRectMake(self.arrowView.x - labelW, 0, labelW, self.height);
    self.vipView.frame = CGRectMake(self.vipLabel.x - vipW, 0, vipW, self.height);
}


@end
