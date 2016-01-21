//
//  YLMessageTableViewCellModel.m
//  树的微博
//
//  Created by WYL on 16/1/20.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLMessageTableViewCellModel.h"

@implementation YLMessageTableViewCellModel

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

- (NSString *)created_at
{
    // "Sat Dec 20 22:46:08 +0800 2014"
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createDate = [formatter dateFromString:_created_at];
    
    if(createDate.isToday)
    {
        if(createDate.deltaWithNow.hour >= 1)
        {
            return [NSString stringWithFormat:@"%d小时前", (int)createDate.deltaWithNow.hour];
        }
        else if(createDate.deltaWithNow.minute >= 1)
        {
            return [NSString stringWithFormat:@"%d分钟前", (int)createDate.deltaWithNow.minute];
        }
        else
        {
            return @"刚刚";
        }
    }
    else if (createDate.isYesterday)
    {
        formatter.dateFormat = @"昨天 HH:mm";
    }
    else if (createDate.isThisYear)
    {
        formatter.dateFormat = @"MM-dd HH:mm";
    }
    else
    {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    return [formatter stringFromDate:createDate];
}

@end
