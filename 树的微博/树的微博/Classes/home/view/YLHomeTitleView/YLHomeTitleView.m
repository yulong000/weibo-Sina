//
//  YLHomeTitleView.m
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLHomeTitleView.h"

#define kImageViewWidth 20              // 箭头的宽度

#define kTitleFont BoldSystemFont(20)   // 字体


@interface YLHomeTitleView ()

@property (nonatomic, strong) UIImageView *arrowView;

@property (nonatomic, strong) UIButton *titleButton;

@end

@implementation YLHomeTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.titleButton = [[UIButton alloc] init];
        self.titleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, kImageViewWidth);
        self.titleButton.titleLabel.font = kTitleFont;
        self.titleButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.titleButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleButton setTitleColor:RGBA(80, 80, 80, 1) forState:UIControlStateNormal];
        [self.titleButton setBackgroundImage:[[UIImage imageNamed:@"navigationbar_filter_background_highlighted"] stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateHighlighted];
        [self.titleButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.titleButton];
        
        self.arrowView = [[UIImageView alloc] init];
        self.arrowView.contentMode = UIViewContentModeCenter;
        self.arrowView.image = [UIImage imageNamed:@"navigationbar_arrow_down"];
        self.arrowView.tag = 1;
        [self addSubview:self.arrowView];
    }
    return  self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    self.width = [_title boundingRectWithSize:CGSizeMake(MAXFLOAT, self.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : kTitleFont} context:nil].size.width + 5 + kImageViewWidth;
    [self.titleButton setTitle:_title forState:UIControlStateNormal];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleButton.frame = self.bounds;
    self.arrowView.frame = CGRectMake(self.width - kImageViewWidth, 0, kImageViewWidth, self.height);
}

- (void)buttonClick
{
    if(self.arrowView.tag == 0)
    {
        self.arrowView.tag = 1;
        self.arrowView.image = [UIImage imageNamed:@"navigationbar_arrow_down"];
    }
    else
    {
        self.arrowView.tag = 0;
        self.arrowView.image = [UIImage imageNamed:@"navigationbar_arrow_up"];
    }
    if(self.titleClickBlock)
    {
        self.titleClickBlock(self.arrowView.tag);
    }
}

@end
