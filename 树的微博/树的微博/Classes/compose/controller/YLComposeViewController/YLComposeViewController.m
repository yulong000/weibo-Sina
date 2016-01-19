//
//  YLComposeViewController.m
//  树的微博
//
//  Created by WYL on 16/1/18.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLComposeViewController.h"
#import "YLComposeButton.h"
#import "YLComposeTextViewController.h"


@interface YLComposeViewController ()

@property (nonatomic, strong) NSMutableArray *btnsArr;

/**
 *  功能区
 */
@property (nonatomic, weak) UIScrollView *funcView;

/**
 *  关闭按钮
 */
@property (nonatomic, strong) UIButton *closeBtn;

/**
 *  返回/关闭
 */
@property (nonatomic, strong) UIView *operateView;

@end

@implementation YLComposeViewController

- (NSMutableArray *)btnsArr
{
    if(_btnsArr == nil)
    {
        _btnsArr = [NSMutableArray array];
    }
    return _btnsArr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compose_slogan"]];
    sloganView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:sloganView];
    [sloganView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(48);
        make.top.equalTo(self.view.mas_top).offset(110);
    }];
    
    // 功能键
    UIScrollView *funcView = [[UIScrollView alloc] init];
    funcView.frame = self.view.bounds;
    [self.view addSubview:funcView];
    self.funcView = funcView;
    funcView.contentSize = CGSizeMake(kScreenWidth, 250);
    funcView.pagingEnabled = YES;
    funcView.bounces = NO;
    funcView.showsHorizontalScrollIndicator = NO;
    funcView.showsVerticalScrollIndicator = NO;
    
    NSArray *infoArr = @[@[[UIImage imageNamed:@"tabbar_compose_idea"],             @"文字"],
                         @[[UIImage imageNamed:@"tabbar_compose_photo"],            @"照片/视频"],
                         @[[UIImage imageNamed:@"tabbar_compose_headlines"],        @"头条文章"],
                         @[[UIImage imageNamed:@"tabbar_compose_lbs"],              @"签到"],
                         @[[UIImage imageNamed:@"tabbar_compose_review"],           @"点评"],
                         @[[UIImage imageNamed:@"tabbar_compose_more"],             @"更多"],
                         @[[UIImage imageNamed:@"tabbar_compose_friend"],           @"好友圈"],
                         @[[UIImage imageNamed:@"tabbar_compose_wbcamera"],         @"微博相机"],
                         @[[UIImage imageNamed:@"tabbar_compose_music"],            @"音乐"],
                         @[[UIImage imageNamed:@"tabbar_compose_envelope"],         @"红包"],
                         @[[UIImage imageNamed:@"tabbar_compose_productrelease"],   @"商品"]];
    CGFloat btnW = 70;
    CGFloat btnH = 100;
    CGFloat gap = (kScreenWidth - btnW * 3) / 4;
    for(int i = 0; i < 6; i ++)
    {
        YLComposeButton *btn = [YLComposeButton buttonWithImage:[infoArr[i] firstObject] title:[infoArr[i] lastObject]];
        btn.tag = i;
        [btn addTarget:self action:@selector(composeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(i % 3 * (btnW + gap) + gap, i / 3 * (btnH + gap) + 250, btnW, btnH);
        [funcView addSubview:btn];
        [self.btnsArr addObject:btn];
        
        if(i == 5) break;
        YLComposeButton *btn2 = [YLComposeButton buttonWithImage:[infoArr[i + 6] firstObject] title:[infoArr[i + 6] lastObject]];
        btn2.tag = i + 6;
        [btn2 addTarget:self action:@selector(composeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn2.frame = CGRectMake(btn.x + kScreenWidth, btn.y, btnW, btnH);
        [funcView addSubview:btn2];
        [self.btnsArr addObject:btn2];
    }
    
    // 关闭
    UIButton *closeBtn = [[UIButton alloc] init];
    closeBtn.adjustsImageWhenHighlighted = NO;
    [closeBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"] forState:UIControlStateNormal];
    closeBtn.backgroundColor = WhiteColor;
    [closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    self.closeBtn = closeBtn;
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    // 动画
    [self.btnsArr enumerateObjectsUsingBlock:^(YLComposeButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if(idx > 5) idx -= 6;
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
        anim.values = @[@0, @(- 40), @(0)];
        anim.keyTimes = @[@0, @(idx * 0.05 + 0.5), @1];
        anim.duration = 0.5;
        anim.fillMode = kCAFillModeForwards;
        anim.removedOnCompletion = NO;
        [btn.layer addAnimation:anim forKey:nil];
    }];
}

#pragma mark 点击某个功能按钮
- (void)composeButtonClick:(YLComposeButton *)btn
{
    switch (btn.tag)
    {
        case 0:
        {
            // 发文字
            YLComposeTextViewController *textVc = [[YLComposeTextViewController alloc] init];
            textVc.view.backgroundColor = WhiteColor;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:textVc];
            [self dismissViewControllerAnimated:NO completion:^{
                
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
            }];
        }
            break;
        case 1:
        {
            // 发照片/视频
            
        }
            break;
        case 2:
        {
            // 发头条文章
            
        }
            break;
        case 3:
        {
            // 签到
            
        }
            break;
        case 4:
        {
            // 点评
            
        }
            break;
        case 5:
        {
            // 更多
            [self.funcView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
            [self.view addSubview:self.operateView];
            [self.closeBtn removeFromSuperview];
        }
            break;
        case 6:
        {
            // 好友圈
            
        }
            break;
        case 7:
        {
            // 微博相机
            
        }
            break;
        case 8:
        {
            // 音乐
            
        }
            break;
        case 9:
        {
            // 红包
            
        }
            break;
        case 10:
        {
            // 商品
            
        }
            break;
            
        default:
            break;
    }
}
#pragma mark 返回/关闭
- (UIView *)operateView
{
    if(_operateView == nil)
    {
        UIView *operateView = [[UIView alloc] initWithFrame:self.closeBtn.frame];
        
        UIButton *returnBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, operateView.width * 0.5, operateView.height)];
        returnBtn.adjustsImageWhenHighlighted = NO;
        [returnBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_return"] forState:UIControlStateNormal];
        returnBtn.backgroundColor = WhiteColor;
        [returnBtn addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
        [operateView addSubview:returnBtn];
        
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(operateView.width * 0.5, 0, operateView.width * 0.5, operateView.height)];
        closeBtn.adjustsImageWhenHighlighted = NO;
        [closeBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"] forState:UIControlStateNormal];
        closeBtn.backgroundColor = WhiteColor;
        [closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        [operateView addSubview:closeBtn];
        
        _operateView = operateView;
    }
    return _operateView;
}

#pragma mark 关闭
- (void)close:(UIButton *)btn
{
    // 动画
    [self.btnsArr enumerateObjectsUsingBlock:^(YLComposeButton *button, NSUInteger idx, BOOL * _Nonnull stop) {
        if(idx > 5) idx -= 6;
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
        anim.values = @[@0, @0, @(500)];
        anim.keyTimes = @[@0, @(0.6 - idx * 0.05), @1];
        anim.duration = 0.5;
        anim.fillMode = kCAFillModeForwards;
        anim.removedOnCompletion = NO;
        [button.layer addAnimation:anim forKey:nil];
    }];
    if(btn == self.closeBtn)
    {
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        anim.toValue = @(- M_PI_4);
        anim.duration = 0.2;
        anim.fillMode = kCAFillModeForwards;
        anim.removedOnCompletion = NO;
        [btn.imageView.layer addAnimation:anim forKey:nil];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}
#pragma mark 返回常用功能区
- (void)returnBack
{
    [self.funcView setContentOffset:CGPointZero animated:YES];
    [self.view addSubview:self.closeBtn];
    [self.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    [self.operateView removeFromSuperview];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self close:self.closeBtn];
}


@end
