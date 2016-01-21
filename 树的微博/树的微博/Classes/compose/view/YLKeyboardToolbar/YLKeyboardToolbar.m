//
//  YLKeyboardToolbar.m
//  树的微博
//
//  Created by WYL on 16/1/19.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLKeyboardToolbar.h"
#import "YLToolbarLocalView.h"
#import "YLToolbarSecretButton.h"
#import "YLToolbarMoreButton.h"

#define kMargin 5               // 边距
#define kLocalViewHeight 25     // 位置信息的高度
#define kToolbarBgHeight 40     // 工具栏的高度

@interface YLKeyboardToolbar ()

/**
 *  位置
 */
@property (nonatomic, weak) YLToolbarLocalView *localView;

/**
 *  隐私
 */
@property (nonatomic, weak) YLToolbarSecretButton *secretButton;

/**
 *  功能背景
 */
@property (nonatomic, weak) UIView *bgView;

/**
 *  工具栏背景
 */
@property (nonatomic, weak) UIImageView *toolbarBg;

/**
 *  功能按钮
 */
@property (nonatomic, strong) NSMutableArray *funcBtnsArr;

/**
 *  更多按钮
 */
@property (nonatomic, strong) NSMutableArray *moreBtnsArr;


@end

@implementation YLKeyboardToolbar
@synthesize secretType = _secretType, location = _location;

- (NSMutableArray *)funcBtnsArr
{
    if(_funcBtnsArr == nil)
    {
        _funcBtnsArr = [NSMutableArray array];
    }
    return _funcBtnsArr;
}

- (NSMutableArray *)moreBtnsArr
{
    if(_moreBtnsArr == nil)
    {
        _moreBtnsArr = [NSMutableArray array];
    }
    return _moreBtnsArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        // 位置
        YLToolbarLocalView *localView = [[YLToolbarLocalView alloc] init];
        __weak typeof(self) weakSelf = self;
        localView.localButtonClickBlock = ^{
        
            [weakSelf chageLocalClick];
        };
        [self addSubview:localView];
        self.localView = localView;
        
        // 保密度
        YLToolbarSecretButton *secretButton = [[YLToolbarSecretButton alloc] init];
        [secretButton addTarget:self action:@selector(changeSecretClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:secretButton];
        self.secretButton = secretButton;
        
        // 功能区
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = RGBA(240, 240, 240, 1);
        [self addSubview:bgView];
        self.bgView = bgView;
        
        UIImageView *toolbarBg = [[UIImageView alloc] init];
        UIImage *bg = [UIImage imageNamed:@"compose_toolbar_background"];
        toolbarBg.image = [bg stretchableImageWithLeftCapWidth:bg.size.width * 0.5 topCapHeight:bg.size.height * 0.5];
        toolbarBg.userInteractionEnabled = YES;
        self.toolbarBg = toolbarBg;
        [bgView addSubview:toolbarBg];
        
        NSArray *imagesArr = @[@[[UIImage imageNamed:@"compose_toolbar_picture"],
                                 [UIImage imageNamed:@"compose_toolbar_picture_highlighted"]],
                               @[[UIImage imageNamed:@"compose_mentionbutton_background"],
                                 [UIImage imageNamed:@"compose_mentionbutton_background_highlighted"]],
                               @[[UIImage imageNamed:@"compose_trendbutton_background"],
                                 [UIImage imageNamed:@"compose_trendbutton_background_highlighted"]],
                               @[[UIImage imageNamed:@"compose_emoticonbutton_background"],
                                 [UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"]],
                               @[[UIImage imageNamed:@"compose_toolbar_more"],
                                 [UIImage imageNamed:@"compose_toolbar_more_highlighted"]]
                               ];
        
        for(int i = 0; i < 5; i++)
        {
            UIButton *btn = [[UIButton alloc] init];
            btn.tag = i;
            [btn setImage:[imagesArr[i] firstObject] forState:UIControlStateNormal];
            [btn setImage:[imagesArr[i] lastObject] forState:UIControlStateHighlighted];
            [toolbarBg addSubview:btn];
            [self.funcBtnsArr addObject:btn];
            [btn addTarget:self action:@selector(operateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if(i == 3 || i == 4)
            {
                [btn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateSelected];
                [btn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted | UIControlStateSelected];
            }
        }
        
        // 更多
        NSArray *moreBtnsArr = @[@[[UIImage imageNamed:@"message_more_headlines"],              @"头条文章"],
                                      @[[UIImage imageNamed:@"compose_more_stock"],             @"股票"],
                                      @[[UIImage imageNamed:@"compose_more_productrelease"],    @"商品"]];
        for(int i = 0; i < 3; i++)
        {
            YLToolbarMoreButton *btn = [[YLToolbarMoreButton alloc] init];
            btn.tag = i + 5;
            [btn setImage:[moreBtnsArr[i] firstObject] forState:UIControlStateNormal];
            [btn setTitle:[moreBtnsArr[i] lastObject] forState:UIControlStateNormal];
            [bgView addSubview:btn];
            [self.moreBtnsArr addObject:btn];
            [btn addTarget:self action:@selector(operateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return  self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.localView.frame = CGRectMake(kMargin, 0, 100, kLocalViewHeight);
    
    CGFloat secretBtnWidth = [[self.secretButton titleForState:UIControlStateNormal] sizeWithAttributes:@{NSFontAttributeName : SystemFont(10)}].width + 35;
    self.secretButton.frame = CGRectMake(self.width -  secretBtnWidth - kMargin * 2, 0, secretBtnWidth, kLocalViewHeight);
    
    CGFloat bgViewY = kLocalViewHeight + kMargin;
    self.bgView.frame = CGRectMake(0, bgViewY, self.width, self.height - bgViewY);
    
    self.toolbarBg.frame = CGRectMake(0, 0, self.bgView.width, kToolbarBgHeight);
    
    CGFloat funcBtnW = self.toolbarBg.width / self.funcBtnsArr.count;
    [self.funcBtnsArr enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        
        btn.frame = CGRectMake(idx * funcBtnW, 0, funcBtnW, self.toolbarBg.height);
    }];
    
    CGFloat moreBtnW = 60;  // 更多功能的宽高
    CGFloat moreBtnH = 90;
    CGFloat moreBtnY = CGRectGetMaxY(self.toolbarBg.frame) + 20;
    CGFloat btnGap = 20;
    [self.moreBtnsArr enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        
        btn.frame = CGRectMake(idx * (moreBtnW + btnGap) + btnGap, moreBtnY, moreBtnW, moreBtnH);
    }];
}
#pragma mark 更改位置
- (void)chageLocalClick
{
    if([self.delegate respondsToSelector:@selector(keyboardToolbarDidClickLocationButton:)])
    {
        [self.delegate keyboardToolbarDidClickLocationButton:self];
    }
}

#pragma mark 更改私密程度
- (void)changeSecretClick
{
    if([self.delegate respondsToSelector:@selector(keyboardToolbarDidClickSecrectButton:)])
    {
        [self.delegate keyboardToolbarDidClickSecrectButton:self];
    }
}
#pragma mark 功能按钮
- (void)operateButtonClick:(UIButton *)btn
{
    if(btn.tag == KeyboardToolbarButtonTypeEmotion || btn.tag == KeyboardToolbarButtonTypeMore)
    {
        if(self.selectedButton == btn)
        {
            self.selectedButton.selected = NO;
            self.selectedButton = nil;
        }
        else
        {
            self.selectedButton.selected = NO;
            btn.selected = YES;
            self.selectedButton = btn;
        }
    }
    if([self.delegate respondsToSelector:@selector(keyboardToolbar:didClickButton:)])
    {
        [self.delegate keyboardToolbar:self didClickButton:btn.tag];
    }
}

#pragma mark 设置隐私策略
- (void)setSecretType:(ToolbarSecretType)secretType
{
    _secretType = secretType;
    
    self.secretButton.secretType = _secretType;
}
- (ToolbarSecretType)secretType
{
    return self.secretButton.secretType;
}

#pragma mark 设置位置
- (void)setLocation:(NSString *)location
{
    _location = [location copy];
    
    self.localView.local = _location;
}
- (NSString *)location
{
    return self.localView.local;
}

- (void)clickSelectedButton
{
    [self operateButtonClick:self.selectedButton];
}

@end
