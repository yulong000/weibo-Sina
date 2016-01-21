//
//  YLDiscoverTableViewCellModel.h
//  树的微博
//
//  Created by WYL on 16/1/21.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLDiscoverTableViewCellModel : NSObject

/**
 *  图片
 */
@property (nonatomic, copy)     NSString *image;

/**
 *  标题
 */
@property (nonatomic, copy)     NSString *title;

/**
 *  详情信息
 */
@property (nonatomic, copy)     NSString *detailTitle;

/**
 *  未读个数
 */
@property (nonatomic, strong)   NSNumber *unreadCount;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
