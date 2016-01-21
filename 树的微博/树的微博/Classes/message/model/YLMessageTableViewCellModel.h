//
//  YLMessageTableViewCellModel.h
//  树的微博
//
//  Created by WYL on 16/1/20.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLMessageTableViewCellModel : NSObject

/**
 *  图片
 */
@property (nonatomic, copy)     NSString *image;
/**
 *  标题
 */
@property (nonatomic, copy)     NSString *title;
/**
 *  详细内容
 */
@property (nonatomic, copy)     NSString *detailTitle;
/**
 *  最后时间
 */
@property (nonatomic, copy)     NSString *created_at;
/**
 *  未读个数
 */
@property (nonatomic, strong)   NSNumber *unreadCount;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict;

@end
