//
//  YLStatusUserInfoView.h
//  树的微博
//
//  Created by WYL on 16/1/17.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLStatusUserInfoView;
@protocol YLStatusUserInfoViewDelegate <NSObject>
@optional

/**
 *  点击了头像
 */
- (void)statusUserInfoViewClickedIconView:(YLStatusUserInfoView *)userInfoView;

/**
 *  点击了更多
 */
- (void)statusUserInfoViewClickedMoreButton:(YLStatusUserInfoView *)userInfoView;

@end

@interface YLStatusUserInfoView : UIView

@property (nonatomic, strong) YLStatus *status;

@property (nonatomic, weak) id < YLStatusUserInfoViewDelegate > delegate;

@end
