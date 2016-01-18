//
//  YLPhotosView.m
//  树的微博
//
//  Created by WYL on 16/1/17.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLPhotosView.h"
#import "YLPhotoView.h"

#define kPhotoMargin 5

#define kThumbnail_pic  @"thumbnail_pic"

@implementation YLPhotosView


- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.userInteractionEnabled = YES;
        // 添加9个photoview
        for(int i = 0; i < 9; i++)
        {
            YLPhotoView *photoView = [[YLPhotoView alloc]init];
            photoView.userInteractionEnabled = YES;
            photoView.tag = i;
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoTap:)]];
            [self addSubview:photoView];
        }
    }
    return self;
}

- (void)photoTap:(UITapGestureRecognizer *)recognizer
{
    // 取出实际图片的数量
    int count = (int)self.pic_urls.count;
    
    // 1.存储图片数据
    NSMutableArray *myPhotos = [NSMutableArray arrayWithCapacity:count];
    for(int i = 0; i < count; i++)
    {
        MJPhoto *mjPhoto = [[MJPhoto alloc]init];
        // 显示图片的view
        mjPhoto.srcImageView = self.subviews[i];
        
        // 将缩略图（thumbnail）的地址转换成中等图片（bmiddle）的地址
        NSString *photoUrl = [self.pic_urls[i][kThumbnail_pic] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjPhoto.url = [NSURL URLWithString:photoUrl];
        [myPhotos addObject:mjPhoto];
    }
    
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc]init];
    browser.currentPhotoIndex = recognizer.view.tag;
    browser.photos = myPhotos;
    [browser show];
}

- (void)setPic_urls:(NSArray<NSDictionary *> *)pic_urls
{
    _pic_urls = pic_urls;
    
    // 每行最多有3张图片
    int maxColumns = pic_urls.count == 4 ? 2 : 3;
    // 总列数
    int cols = (int)(pic_urls.count >= maxColumns ? maxColumns : pic_urls.count);
    CGFloat photoW = (self.width - (cols - 1) * kPhotoMargin) / cols;
    CGFloat photoH = photoW;
    
    for(int i = 0; i < self.subviews.count; i++)
    {
        // 取出i位置对应的photoview
        YLPhotoView *photoView = self.subviews[i];
        
        if(i < _pic_urls.count)
        {
            // 显示图片
            photoView.hidden = NO;
            
            // 传递数据
            photoView.thumbnail_pic = _pic_urls[i][kThumbnail_pic];
            
            // 设置frame
            // 如果有四张图片，则每行2张图片，否则每行3张图片
            int maxColumns = _pic_urls.count == 4 ? 2 : 3;
            
            CGFloat photoX = i % maxColumns * (photoW + kPhotoMargin);
            CGFloat photoY = i / maxColumns * (photoH + kPhotoMargin);
            photoView.frame = CGRectMake(photoX, photoY, photoW, photoH);
            
            if(_pic_urls.count == 1)
            {
                // 只有一张图片的时候，图片缩放到适当的比例（长宽比例不变，photoview可能会有部分是空白）
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                // 切除多出的边缘
                photoView.clipsToBounds = YES;
            }
            else
            {
                // 当有多张图片的时候，图片缩放并填充（长宽比例不变，图片可能会有部分被遮挡）
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
        }
        else
        {
            photoView.hidden = YES;
        }
    }
}

+ (CGSize)photosViewSizeWithPhotosCount:(NSInteger)count maxWidth:(CGFloat)maxW
{
    // 每行最多有3张图片
    int maxColumns = count == 4 ? 2 : 3;
    
    // 总行数
    // 1 ~ 3 : 1  ||  4 : 2   ||   5 ~ 6 : 2   ||   7 ~ 9 : 3
    int rows = (int)((count - 1) / maxColumns + 1);
    
    // 总列数
    int cols = (int)(count >= maxColumns ? maxColumns : count);
    
    CGFloat photoW = (maxW - 2 * kPhotoMargin) / 3;
    CGFloat photoH = photoW;
    
    // 高度
    CGFloat photosH = rows * (photoH + kPhotoMargin) - kPhotoMargin;
    
    // 宽度
    CGFloat photosW = cols * (photoW + kPhotoMargin) - kPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}


@end
