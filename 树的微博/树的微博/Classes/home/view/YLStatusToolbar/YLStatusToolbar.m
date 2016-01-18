//
//  YLStatusToolbar.m
//  树的微博
//
//  Created by WYL on 16/1/17.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLStatusToolbar.h"

@interface YLStatusToolbar ()

/**
 *  转发按钮
 */
@property (nonatomic, weak) UIButton *retweetBtn;
/**
 *  评论按钮
 */
@property (nonatomic, weak) UIButton *commentBtn;
/**
 *  点赞按钮
 */
@property (nonatomic, weak) UIButton *attitudeBtn;
/**
 *  存放按钮的数组
 */
@property (nonatomic, strong) NSMutableArray *btnArray;
/**
 *  存放分割线的数组
 */
@property (nonatomic, strong) NSMutableArray *dividerArray;


@end

@implementation YLStatusToolbar

- (NSMutableArray *)btnArray
{
    if(_btnArray == nil)
    {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (NSMutableArray *)dividerArray
{
    if(_dividerArray == nil)
    {
        _dividerArray = [NSMutableArray array];
    }
    return _dividerArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        // 1.设置图片
        self.userInteractionEnabled = YES;
        UIImage *image = [UIImage imageNamed:@"timeline_card_bottom_background"];
        UIImage *highlightImage = [UIImage imageNamed:@"timeline_card_bottom_background_highlighted"];
        self.image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        self.highlightedImage = [highlightImage stretchableImageWithLeftCapWidth:highlightImage.size.width * 0.5 topCapHeight:highlightImage.size.height * 0.5];
        
        // 2.添加按钮
        self.retweetBtn = [self addButtonWithTitle:@"转发" image:@"timeline_icon_retweet" highLightedImage:@"timeline_icon_retweet_highlighted"];
        self.commentBtn = [self addButtonWithTitle:@"评论" image:@"timeline_icon_comment" highLightedImage:@"timeline_icon_comment_highlighted"];
        self.attitudeBtn = [self addButtonWithTitle:@"赞" image:@"timeline_icon_unlike" highLightedImage:@"timeline_icon_unlike_highlighted"];
        
        [self.retweetBtn addTarget:self action:@selector(retweetBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.commentBtn addTarget:self action:@selector(commentBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.attitudeBtn addTarget:self action:@selector(attitudeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 3.添加分割线
        [self addDivider];
        [self addDivider];
    }
    return self;
}

#pragma mark 添加按钮
- (UIButton *)addButtonWithTitle:(NSString *)title image:(NSString *)image highLightedImage:(NSString *)highLightedImage
{
    UIButton * btn = [[UIButton alloc]init];
    // 图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highLightedImage] forState:UIControlStateHighlighted];
    // 背景图片
    UIImage *bgImage = [UIImage imageNamed:@"timeline_card_bottom_background"];
    UIImage *highlightedBgImage = [UIImage imageNamed:@"timeline_card_bottom_background_highlighted"];
    [btn setBackgroundImage:[bgImage stretchableImageWithLeftCapWidth:bgImage.size.width * 0.5 topCapHeight:bgImage.size.height * 0.5] forState:UIControlStateNormal];
    [btn setBackgroundImage:[highlightedBgImage stretchableImageWithLeftCapWidth:bgImage.size.width * 0.5 topCapHeight:bgImage.size.height * 0.5] forState:UIControlStateHighlighted];
    // 文字
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:GrayColor forState:UIControlStateNormal];
    btn.titleLabel.font = SystemFont(13);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.adjustsImageWhenHighlighted = NO;
    
    [self addSubview:btn];
    [self.btnArray addObject:btn];
    return btn;
}

#pragma mark 按钮中间的分割线
- (void)addDivider
{
    UIImageView *divider = [[UIImageView alloc]init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    divider.highlightedImage = [UIImage imageNamed:@"timeline_card_bottom_line_highlighted"];
    [self addSubview:divider];
    [self.dividerArray addObject:divider];
}

#pragma mark 布局按钮和分割线的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat dividerY = 0;
    CGFloat dividerW = 1;
    CGFloat dividerH = self.height;
    
    CGFloat btnY = 0;
    CGFloat btnW = (self.width - self.dividerArray.count * dividerW) / self.btnArray.count;
    CGFloat btnH = dividerH;
    
    for(int i = 0; i < self.btnArray.count; i++)
    {
        UIButton * btn = self.btnArray[i];
        CGFloat btnX = i * (btnW + dividerW);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    for(int j = 0; j < self.dividerArray.count; j++)
    {
        UIImageView *divider = self.dividerArray[j];
        UIButton *btn = self.btnArray[j];
        CGFloat dividerX = CGRectGetMaxX(btn.frame);
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
}

#pragma mark 为按钮设置数据
- (void)setStatus:(YLStatus *)status
{
    _status = status;
    
    [self setupBtn:self.retweetBtn originalTitle:@"转发" count:status.reposts_count];
    [self setupBtn:self.commentBtn originalTitle:@"评论" count:status.comments_count];
    [self setupBtn:self.attitudeBtn originalTitle:@"赞" count:status.attitudes_count];
}

#pragma mark 设置按钮的数字
- (void)setupBtn:(UIButton *)button originalTitle:(NSString *)title count:(int)count
{
    if(count)
    {
        NSString * str = nil;
        if(count >= 10000)
        {
            str = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
            // 当显示为 x.0 万的时候，去掉后面的 .0
            str = [str stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        else
        {
            str = [NSString stringWithFormat:@"%d", count];
        }
        [button setTitle:str forState:UIControlStateNormal];
    }
    else
    {
        [button setTitle:title forState:UIControlStateNormal];
    }
}

#pragma mark 转发微博
- (void)retweetBtnClick
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(statusToolbarRetweetBtnClicked:)])
    {
        [self.delegate statusToolbarRetweetBtnClicked:self];
    }
}
#pragma mark 评论
- (void)commentBtnClick
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(statusToolbarCommentBtnClicked:)])
    {
        [self.delegate statusToolbarCommentBtnClicked:self];
    }
}
#pragma mark 点赞
- (void)attitudeBtnClick
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(statusToolbarAttitudeBtnClicked:)])
    {
        [self.delegate statusToolbarAttitudeBtnClicked:self];
    }
}


@end
