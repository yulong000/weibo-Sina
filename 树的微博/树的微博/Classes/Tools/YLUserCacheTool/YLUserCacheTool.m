//
//  YLUserCacheTool.m
//  树的微博
//
//  Created by WYL on 16/1/16.
//  Copyright © 2016年 WYL. All rights reserved.
//

#import "YLUserCacheTool.h"
#import "FMDB.h"

// account 存放的本地路径
#define kAccountLocalFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

// statuses 存放的本地路径
#define kStatusesLocalFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"statuses.sqlite"]


@interface YLUserCacheTool ()

@property (nonatomic, strong) FMDatabaseQueue *queue;

@end

@implementation YLUserCacheTool

+ (instancetype)shareUserCacheTool
{
    static YLUserCacheTool *userCacheTool = nil;
    static dispatch_once_t predicate = 0;
    dispatch_once(&predicate, ^{
        
        userCacheTool = [[YLUserCacheTool alloc] init];
    });
    return userCacheTool;
}

- (instancetype)init
{
    if(self = [super init])
    {
        self.queue = [FMDatabaseQueue databaseQueueWithPath:kStatusesLocalFilePath];
        // 创建表
        [self.queue inDatabase:^(FMDatabase *db) {
           
            [db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement, access_token text, idstr text, dict blob)"];
        }];
    }
    return self;
}

#pragma mark - 账户信息
#pragma mark 保存账户信息到本地
- (BOOL)saveAccount:(YLAccount *)account
{
    return [NSKeyedArchiver archiveRootObject:account toFile:kAccountLocalFilePath];
}
#pragma mark 读取本地存储的用户信息
- (YLAccount *)getLocalAccountInfo
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountLocalFilePath];
}

#pragma mark - 微博数据
#pragma mark 保存微博数据到本地
- (void)saveStatusesToLocal:(NSArray <NSDictionary *> *)statusesArr
{
    [self.queue inDatabase:^(FMDatabase *db) {
       
        for (NSDictionary *dict in statusesArr)
        {
            NSString *idstr = dict[@"idstr"];
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
            [db executeUpdate:@"insert into t_status (access_token, idstr, dict) values(?, ?, ?)", Account.access_token, idstr, data];
        }
    }];
}
#pragma mark 从本地读取符合条件的微博数据
- (NSArray <NSDictionary *> *)getStatusesWithParam:(YLStatusesParam *)param
{
    __block NSMutableArray *arr = [NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase *db) {
       
        FMResultSet *set = nil;
        if(param.since_id)
        {
            // 设定了最小的 id
            set = [db executeQuery:@"select * from t_status where access_token = ? and idstr > ? order by idstr limit 0, ?;", Account.access_token, param.since_id, param.count];
        }
        else if(param.max_id)
        {
            // 设定了最大的 id  desc 降序
            set = [db executeQuery:@"select * from t_status where access_token = ? and idstr <= ? order by idstr desc limit 0, ?;", Account.access_token, param.max_id, param.count];
        }
        else
        {
            set = [db executeQuery:@"select * from t_status where access_token = ? order by idstr desc limit 0, ?;", Account.access_token, param.count];
        }
        
        while (set.next)
        {
            NSData *data = [set dataForColumn:@"dict"];
            NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [arr addObject:dict];
        }
    }];
    return [NSArray arrayWithArray:arr];
}

@end


@implementation YLStatusesParam

#pragma mark 默认20条
- (NSNumber *)count
{
    return _count ? _count : @20;
}

@end
