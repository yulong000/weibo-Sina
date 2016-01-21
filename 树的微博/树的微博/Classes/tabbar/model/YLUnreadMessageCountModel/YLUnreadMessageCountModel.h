//
//  YLUnreadMessageCountModel.h
//  树的微博
//
//  Created by WYL on 16/1/19.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLUnreadMessageCountModel : NSObject

/**
 *  新微博未读数
 */
@property (nonatomic, assign) int status;

/**
 *  相册消息未读数
 */
@property (nonatomic, assign) int photo;

/**
 *  新通知未读数
 */
@property (nonatomic, assign) int notice;
/**
 *  新提及我的微博数
 */
@property (nonatomic, assign) int mention_status;
/**
 *  新提及我的评论数
 */
@property (nonatomic, assign) int mention_cmt;
/**
 *  新邀请未读数
 */
@property (nonatomic, assign) int invite;
/**
 *  微群消息未读数
 */
@property (nonatomic, assign) int group;
/**
 *  新粉丝数
 */
@property (nonatomic, assign) int follower;
/**
 *  新私信数
 */
@property (nonatomic, assign) int dm;
/**
 *  新评论数
 */
@property (nonatomic, assign) int cmt;
/**
 *  新勋章数
 */
@property (nonatomic, assign) int badge;

- (int)homeCount;
- (int)messageCount;
- (int)discoverCount;
- (int)meCount;
- (int)totalCount;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
/*
 
 "all_cmt" = 0;
 "all_follower" = 3;
 "all_mention_cmt" = 0;
 "all_mention_status" = 0;
 "attention_cmt" = 0;
 "attention_follower" = 0;
 "attention_mention_cmt" = 0;
 "attention_mention_status" = 0;
 badge = 0;//新勋章数
 "chat_group_client" = 0;
 "chat_group_notice" = 0;
 "chat_group_pc" = 0;
 cmt = 0;//新评论数
 dm = 1; //新私信数
 follower = 3;//新粉丝数
 group = 0;//微群消息未读数
 invite = 0;//新邀请未读数
 "mention_cmt" = 0;//新提及我的评论数
 "mention_status" = 0;//新提及我的微博数
 notice = 0;//新通知未读数
 "page_friends_to_me" = 0;
 photo = 0;			//相册消息未读数
 status = 101;		//新微博未读数
 
 */