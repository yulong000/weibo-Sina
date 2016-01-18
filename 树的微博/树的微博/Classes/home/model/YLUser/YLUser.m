//
//  YLUser.m
//  树的微博
//
//  Created by WYL on 16/1/17.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLUser.h"

@implementation YLUser

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setKeyValues:dict];
    }
    return self;
}

+ (instancetype)userWithDict:(NSDictionary *)dict
{
    return [[super alloc] initWithDict:dict];
}

@end
