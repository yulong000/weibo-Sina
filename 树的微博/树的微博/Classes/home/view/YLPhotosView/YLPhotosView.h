//
//  YLPhotosView.h
//  树的微博
//
//  Created by WYL on 16/1/17.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLPhotoView;
@interface YLPhotosView : UIImageView

/**
 *  存放图片 url 的数组（最多9个）
 */
@property (nonatomic, strong) NSArray <NSDictionary *>* pic_urls;

/**
 *  通过图片的张数，返回YLPhotosView的size
 */
+ (CGSize)photosViewSizeWithPhotosCount:(NSInteger)count maxWidth:(CGFloat)maxW;

@end
