//
//  YLToolbarMoreButton.m
//  树的微博
//
//  Created by WYL on 16/1/19.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLToolbarMoreButton.h"

@implementation YLToolbarMoreButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.titleLabel.font = SystemFont(14);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:GrayColor forState:UIControlStateNormal];
    }
    return  self;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.width);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, contentRect.size.width, contentRect.size.width, contentRect.size.height - contentRect.size.width);
}
@end
