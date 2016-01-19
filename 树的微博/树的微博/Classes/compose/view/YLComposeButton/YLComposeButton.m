//
//  YLComposeButton.m
//  树的微博
//
//  Created by WYL on 16/1/18.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLComposeButton.h"

@implementation YLComposeButton


+ (YLComposeButton *)buttonWithImage:(UIImage *)image title:(NSString *)title
{
    YLComposeButton *button = [[YLComposeButton alloc] init];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:GrayColor forState:UIControlStateNormal];
    button.titleLabel.font = SystemFont(15);
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    return button;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.width);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.width, contentRect.size.width, contentRect.size.height - contentRect.size.width);
}

- (void)setHighlighted:(BOOL)highlighted
{
    if(highlighted)
    {
        if([self.imageView.layer animationForKey:@"scale"] == nil)
        {
            CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            ani.duration = 0.2;
            ani.fromValue = @1.0;
            ani.toValue = @1.1;
            ani.fillMode = kCAFillModeForwards;
            ani.removedOnCompletion = NO;
            [self.imageView.layer addAnimation:ani forKey:@"scale"];
        }
    }
    else
    {
        [self.imageView.layer removeAnimationForKey:@"scale"];
    }
}
@end
