//
//  YLDiscoverTableViewCellModel.m
//  树的微博
//
//  Created by WYL on 16/1/21.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLDiscoverTableViewCellModel.h"

@implementation YLDiscoverTableViewCellModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setKeyValues:dict];
    }
    return self;
}

+ (instancetype)modelWithDict:(NSDictionary *)dict
{
    return [[super alloc] initWithDict:dict];
}

@end
