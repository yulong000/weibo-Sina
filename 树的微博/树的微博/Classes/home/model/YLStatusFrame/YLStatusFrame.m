//
//  YLStatusFrame.m
//  树的微博
//
//  Created by WYL on 16/1/17.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLStatusFrame.h"
#import "YLStatus.h"
#import "YLPhotosView.h"
#import "YLPhotoView.h"

@implementation YLStatusFrame

- (instancetype)initWithStatus:(YLStatus *)status
{
    if(self = [super init])
    {
        self.status = status;
    }
    return self;
}

+ (instancetype)frameWithStauts:(YLStatus *)status
{
    return [[super alloc] initWithStatus:status];
}

#pragma mark 根据微博数据计算所有子控件的frame
- (void)setStatus:(YLStatus *)status
{
    _status = status;
    
    // cell的宽度
    CGFloat cellW = kScreenWidth - 2 * kStatusTableBorder;
    
    // 大背景
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0;
    
    // 个人信息
    CGFloat userInfoViewX = kStatusCellSubViewsGap;
    CGFloat userInfoViewY = kStatusCellSubViewsGap;
    CGFloat userInfoViewW = cellW - 2 * kStatusCellSubViewsGap;
    CGFloat userInfoViewH = 50;
    _userInfoViewF = CGRectMake(userInfoViewX, userInfoViewY, userInfoViewW, userInfoViewH);
    
    // 正文
    CGFloat contentLabelX = userInfoViewX;
    CGFloat contentLabelY = CGRectGetMaxY(_userInfoViewF) + kStatusCellSubViewsGap;
    CGFloat oneLineH = [@"text" boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kStatusContentFont} context:nil].size.height;
    CGSize contentLabelSize = [status.text boundingRectWithSize:CGSizeMake(userInfoViewW, oneLineH * 2) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kStatusContentFont} context:nil].size;
    _contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    // 配图
    if(status.pic_urls.count)
    {
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelF) + kStatusCellSubViewsGap;
        CGSize photosViewSize = [YLPhotosView photosViewSizeWithPhotosCount:status.pic_urls.count maxWidth:userInfoViewW];
        _photosViewF = (CGRect){{photoViewX, photoViewY}, photosViewSize};
    }
    
    // 被转发的微博
    if(status.retweeted_status)
    {
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + kStatusCellSubViewsGap;
        CGFloat retweetViewW = cellW;
        CGFloat retweetViewH = 0;
        
        // 11.被转发微博的昵称
        CGFloat retweetNameLabelX = kStatusCellSubViewsGap;
        CGFloat retweetNameLabelY = kStatusCellSubViewsGap;
        CGSize retweetNameLabelSize = [[NSString stringWithFormat:@"@%@", status.retweeted_status.user.name] sizeWithAttributes:@{NSFontAttributeName:kRetweetStatusNameFont}];
        _retweetNameLabelF = (CGRect){{retweetNameLabelX, retweetNameLabelY}, retweetNameLabelSize};
        
        // 12.被转发微博的正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + kStatusCellSubViewsGap;
        CGSize retweetContentLabelSize = [status.retweeted_status.text boundingRectWithSize:CGSizeMake(retweetViewW - kStatusCellSubViewsGap * 2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kRetweetStatusContentFont} context:nil].size;
        _retweetContentLabelF = (CGRect){{retweetContentLabelX, retweetContentLabelY}, retweetContentLabelSize};
        
        // 13.被转发微博的配图
        if(status.retweeted_status.pic_urls.count)
        {
            CGFloat retweetPhotoViewX = retweetContentLabelX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelF) + kStatusCellSubViewsGap;
            CGSize retweetPhotosViewSize = [YLPhotosView photosViewSizeWithPhotosCount:status.retweeted_status.pic_urls.count maxWidth:retweetViewW - 2 * kStatusCellSubViewsGap];
            _retweetPhotosViewF = (CGRect){{retweetPhotoViewX, retweetPhotoViewY}, retweetPhotosViewSize};
            
            retweetViewH = CGRectGetMaxY(_retweetPhotosViewF);
        }
        else
        {
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        }
        retweetViewH += kStatusCellSubViewsGap;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        // 有转发微博时topview的高度
        topViewH = CGRectGetMaxY(_retweetViewF);
    }
    else
    {
        // 没有转发微博时topview的高度
        if(status.pic_urls.count)
        {
            // 有配图
            topViewH = CGRectGetMaxY(_photosViewF);
        }
        else
        {
            // 没有配图
            topViewH = CGRectGetMaxY(_contentLabelF);
        }
        topViewH += kStatusCellSubViewsGap;
    }

    // 工具条
    CGFloat statusToolBarX = 0;
    CGFloat statusToolBarY = topViewH;
    CGFloat statusToolBarW = cellW;
    CGFloat statusToolBarH = 35;
    _statusToolBarF = CGRectMake(statusToolBarX, statusToolBarY, statusToolBarW, statusToolBarH);
    
    topViewH = CGRectGetMaxY(_statusToolBarF);
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    // cell的高度
    _cellHeight = CGRectGetMaxY(_topViewF) + kStatusCellSubViewsGap * 0.5;
}


@end
