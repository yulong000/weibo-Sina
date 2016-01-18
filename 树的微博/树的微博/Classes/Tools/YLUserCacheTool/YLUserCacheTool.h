//
//  YLUserCacheTool.h
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YLAccount, YLStatusesParam;
@interface YLUserCacheTool : NSObject

+ (instancetype)shareUserCacheTool;

/**
 *  保存账户信息到本地
 */
- (BOOL)saveAccount:(YLAccount *)account;
/**
 *  读取本地存储的用户信息
 */
- (YLAccount *)getLocalAccountInfo;



/**
 *  保存微博数据到本地
 *
 *  @param statusesArr 微博数据，dicts
 */
- (void)saveStatusesToLocal:(NSArray <NSDictionary *> *)statusesArr;
/**
 *  从本地读取符合条件的微博数据
 *
 *  @param param 参数
 */
- (NSArray <NSDictionary *> *)getStatusesWithParam:(YLStatusesParam *)param;

@end


/**
 *  获取微博数据时传入的参数
 */

@interface YLStatusesParam : NSObject

/**
 *  若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 */
@property (nonatomic, strong) NSNumber *since_id;

/**
 *  若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 */
@property (nonatomic, strong) NSNumber *max_id;

/**
 *  单页返回的条数， 最大100， 默认20
 */
@property (nonatomic, strong) NSNumber *count;

@end