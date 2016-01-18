//
//  YLAccount.h
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLAccount : NSObject < NSCoding >

/**
 *  token
 */
@property (nonatomic, copy) NSString *access_token;

/**
 *  token 的生命周期
 */
@property (nonatomic, copy) NSString *expires_in;

/**
 *  token 的生命周期（待废弃）
 */
@property (nonatomic, copy) NSString *remind_in;

/**
 *  用户的 uid
 */
@property (nonatomic, copy) NSString *uid;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
