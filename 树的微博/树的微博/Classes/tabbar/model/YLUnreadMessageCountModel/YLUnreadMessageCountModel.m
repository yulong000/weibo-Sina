//
//  YLUnreadMessageCountModel.m
//  树的微博
//
//  Created by WYL on 16/1/19.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLUnreadMessageCountModel.h"

@implementation YLUnreadMessageCountModel

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

- (int)homeCount
{
    return self.status;
}

- (int)messageCount
{
    return self.cmt + self.mention_cmt + self.mention_status + self.dm;
}

- (int)discoverCount
{
    return self.invite;
}

- (int)meCount
{
    return self.photo + self.group + self.badge + self.follower + self.notice;
}

- (int)totalCount
{
    return self.homeCount + self.messageCount + self.discoverCount + self.meCount;
}

@end
