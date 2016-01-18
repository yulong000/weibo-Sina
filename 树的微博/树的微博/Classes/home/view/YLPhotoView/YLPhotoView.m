//
//  YLPhotoView.m
//  树的微博
//
//  Created by WYL on 16/1/17.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLPhotoView.h"

@interface YLPhotoView ()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation YLPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        
        // 在右下角添加gif标识
        UIImageView *gifView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}

- (void)setThumbnail_pic:(NSString *)thumbnail_pic
{
    _thumbnail_pic = [thumbnail_pic copy];
    
    self.gifView.hidden = ![_thumbnail_pic hasSuffix:@"gif"];
    [self setImageWithURL:[NSURL URLWithString:_thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置位置在右下角
    self.gifView.layer.anchorPoint = CGPointMake(1.0, 1.0);
    self.gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
}


@end
