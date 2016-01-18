//
//  YLStatusIconView.m
//  树的微博
//
//  Created by WYL on 16/1/17.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLStatusIconView.h"

@interface YLStatusIconView ()

@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation YLStatusIconView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = ClearColor;
        self.iconView = [[UIImageView alloc] init];
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.iconView];
    }
    return  self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconView.frame = self.bounds;
    self.iconView.layer.cornerRadius = self.iconView.width * 0.5;
    self.iconView.clipsToBounds = YES;
}

- (void)setIconUrl:(NSString *)iconUrl
{
    _iconUrl = [iconUrl copy];
    
    [self.iconView setImageWithURL:[NSURL URLWithString:_iconUrl] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
}

@end
