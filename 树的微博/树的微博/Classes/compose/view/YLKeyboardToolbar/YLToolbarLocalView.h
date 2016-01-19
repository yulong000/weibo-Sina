//
//  YLToolbarLocalView.h
//  树的微博
//
//  Created by WYL on 16/1/19.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLToolbarLocalView : UIView

/**
 *  位置信息
 */
@property (nonatomic, copy) NSString *local;

/**
 *  获取位置信息
 */
@property (nonatomic, copy) void(^localButtonClickBlock)();

@end
