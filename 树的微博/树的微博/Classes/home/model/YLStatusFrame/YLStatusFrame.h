//
//  YLStatusFrame.h
//  树的微博
//
//  Created by WYL on 16/1/17.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YLStatusFrame : NSObject

/**
 *  微博内容
 */
@property (nonatomic, strong) YLStatus *status;

/**
// *  发微博者信息的父控件
// */
@property (nonatomic, assign, readonly)CGRect topViewF;
///**
// *  头像
// */
//@property (nonatomic, assign, readonly)CGRect iconViewF;
///**
// *  昵称
// */
//@property (nonatomic, assign, readonly)CGRect nameLabelF;
///**
// *  会员图标
// */
//@property (nonatomic, assign, readonly)CGRect vipViewF;
///**
// *  时间
// */
//@property (nonatomic, assign, readonly)CGRect timeLabelF;
///**
// *  来源
// */
//@property (nonatomic, assign, readonly)CGRect sourceLabelF;

/**
 *  user 信息
 */
@property (nonatomic, assign, readonly) CGRect userInfoViewF;
/**
 *  配图
 */
@property (nonatomic, assign, readonly) CGRect photosViewF;
/**
 *  正文
 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;

/**
 *  被转发微博的父控件
 */
@property (nonatomic, assign, readonly) CGRect retweetViewF;
/**
 *  被转发微博的作者的昵称
 */
@property (nonatomic, assign, readonly) CGRect retweetNameLabelF;
/**
 *  被转发微博的正文
 */
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;
/**
 *  被转发微博的配图
 */
@property (nonatomic, assign, readonly) CGRect retweetPhotosViewF;

/**
 *  微博消息的工具条
 */
@property (nonatomic, assign, readonly) CGRect statusToolBarF;
/**
 *  cell 的高度
 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

- (instancetype)initWithStatus:(YLStatus *)status;
+ (instancetype)frameWithStauts:(YLStatus *)status;

@end
