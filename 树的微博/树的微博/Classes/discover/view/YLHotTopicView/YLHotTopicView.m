//
//  YLHotTopicView.m
//  树的微博
//
//  Created by WYL on 16/1/20.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLHotTopicView.h"

@implementation YLHotTopicView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = WhiteColor;
        [self addButtons];
    }
    return  self;
}

- (void)addButtons
{
    for(int i = 0; i < 4; i++)
    {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        [btn setTitleColor:BlackColor forState:UIControlStateNormal];
        [btn setTitleColor:GrayColor forState:UIControlStateHighlighted];
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        btn.titleLabel.font = SystemFont(16);
        [self addSubview:btn];
    }
}


- (void)layoutSubviews
{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        
        btn.frame = CGRectMake(idx % 2 * self.width * 0.5, idx / 2 * self.height * 0.5, self.width * 0.5, self.height * 0.5);
    }];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [RGBA(240, 240, 240, 1) set];
    CGFloat margin = 5;
    CGContextMoveToPoint(ctx, self.width * 0.5, margin);
    CGContextAddLineToPoint(ctx, self.width * 0.5, self.height * 0.5 - margin);
    
    CGContextMoveToPoint(ctx, self.width * 0.5, self.height * 0.5 + margin);
    CGContextAddLineToPoint(ctx, self.width * 0.5, self.height - margin);
    
    CGContextMoveToPoint(ctx, margin, self.height * 0.5);
    CGContextAddLineToPoint(ctx, self.width * 0.5 - margin, self.height * 0.5);
    
    CGContextMoveToPoint(ctx, self.width * 0.5 + margin, self.height * 0.5);
    CGContextAddLineToPoint(ctx, self.width - margin, self.height * 0.5);
    
    CGContextStrokePath(ctx);
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if(idx >= _titles.count) *stop = YES;
        
        [btn setTitle:_titles[idx] forState:UIControlStateNormal];
    }];
}

@end
