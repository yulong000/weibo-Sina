//
//  YLStatusToolbar.h
//  树的微博
//
//  Created by WYL on 16/1/17.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLStatusToolbar;
@protocol YLStatusToolbarDelegate <NSObject>
@optional

/**
 *  转发微博
 */
- (void)statusToolbarRetweetBtnClicked:(YLStatusToolbar *)toolbar;
/**
 *  评论微博
 */
- (void)statusToolbarCommentBtnClicked:(YLStatusToolbar *)toolbar;
/**
 *  点赞
 */
- (void)statusToolbarAttitudeBtnClicked:(YLStatusToolbar *)toolbar;

@end

@interface YLStatusToolbar : UIImageView

/**
 *  微博模型
 */
@property (nonatomic, strong) YLStatus * status;

@property (nonatomic, weak) id < YLStatusToolbarDelegate > delegate;
@end
