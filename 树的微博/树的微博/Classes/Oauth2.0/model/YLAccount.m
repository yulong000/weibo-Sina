//
//  YLAccount.m
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLAccount.h"

@implementation YLAccount

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[super alloc] initWithDict:dict];
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if(self = [super init])
    {
        _access_token = [decoder decodeObjectForKey:@"access_token"];
        _expires_in   = [decoder decodeObjectForKey:@"expires_in"];
        _remind_in    = [decoder decodeObjectForKey:@"remind_in"];
        _uid          = [decoder decodeObjectForKey:@"uid"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in   forKey:@"expires_in"];
    [encoder encodeObject:self.remind_in    forKey:@"remind_in"];
    [encoder encodeObject:self.uid          forKey:@"uid"];
}

@end
