//
//  YLToolbarLocalView.m
//  树的微博
//
//  Created by WYL on 16/1/19.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLToolbarLocalView.h"

#define kTitleFont SystemFont(12)

@interface YLToolbarLocalView ()

@property (nonatomic, strong) UIButton *localBtn;

@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation YLToolbarLocalView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.localBtn = [[UIButton alloc] init];
        self.localBtn.titleLabel.font = kTitleFont;
        [self.localBtn addTarget:self action:@selector(getLocalBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.localBtn];
        
        self.deleteBtn = [[UIButton alloc] init];
        [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"compose_location_delete_button_background"] forState:UIControlStateNormal];
        [self.deleteBtn setBackgroundImage:[UIImage imageNamed:@"compose_location_delete_button_background_highlighted"] forState:UIControlStateHighlighted];
        [self.deleteBtn setImage:[UIImage imageNamed:@"compose_location_icon_delete"] forState:UIControlStateNormal];
        [self addSubview:self.deleteBtn];
        [self.deleteBtn addTarget:self action:@selector( deleteLocal) forControlEvents:UIControlEventTouchUpInside];
        self.local = @"";
    }
    return  self;
}

- (void)setLocal:(NSString *)local
{
    _local = [local copy];
    
    UIImage *img;
    UIImage *bg;
    UIImage *bgH;
    NSString *title;
    UIColor *titleColor;
    if(_local.length)
    {
        // success
        bg = [UIImage imageNamed:@"compose_location_button_background"];
        bgH = [UIImage imageNamed:@"compose_location_button_background_highlighted"];
        img = [UIImage imageNamed:@"compose_locatebutton_succeeded"];
        title = _local;
        titleColor = RGBA(80, 125, 175, 1);
    }
    else
    {
        img = [UIImage imageNamed:@"compose_locatebutton_ready"];
        bg = [UIImage imageNamed:@"compose_group_button_background"];
        bgH = [UIImage imageNamed:@"compose_group_button_background_highlighted"];
        title = @"显示位置";
        titleColor = GrayColor;
    }
    [self.localBtn setImage:img forState:UIControlStateNormal];
    [self.localBtn setBackgroundImage:[bg stretchableImageWithLeftCapWidth:bg.size.width * 0.5 topCapHeight:bg.size.height * 0.5] forState:UIControlStateNormal];
    [self.localBtn setBackgroundImage:[bgH stretchableImageWithLeftCapWidth:bgH.size.width * 0.5 topCapHeight:bgH.size.height * 0.5] forState:UIControlStateHighlighted];
    [self.localBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [self.localBtn setTitle:title forState:UIControlStateNormal];
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSString *text = [self.localBtn titleForState:UIControlStateNormal];
    CGFloat width = [text sizeWithAttributes:@{NSFontAttributeName : kTitleFont}].width + 30;
    self.localBtn.frame = CGRectMake(0, 0, width, self.height);
    self.deleteBtn.frame = CGRectMake(CGRectGetMaxX(self.localBtn.frame), 0, 30, self.height);
    self.deleteBtn.hidden = !self.local.length;
}

#pragma mark 获取位置
- (void)getLocalBtnClick
{
    if(self.localButtonClickBlock)
    {
        self.localButtonClickBlock();
    }
}
#pragma mark 删除位置
- (void)deleteLocal
{
    self.local = @"";
}

@end
